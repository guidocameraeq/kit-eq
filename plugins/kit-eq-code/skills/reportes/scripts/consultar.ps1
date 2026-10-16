<#
  consultar.ps1 — Kit eQ, skill "reportes".
  Corre UNA consulta de SOLO LECTURA (SELECT) contra SQL Server y la guarda en CSV.

  Uso (desde la carpeta Reportes):
    powershell -NoProfile -ExecutionPolicy Bypass -File consultar.ps1 `
      -Conexion .\conexion-eq.json -Consulta "SELECT TOP 10 * FROM dbo.MiVista" -Salida .\resultados\prueba.csv

  Qué hace:
    1. Revisa que la consulta sea un solo SELECT (o WITH ... SELECT). Si no, frena.
    2. Prueba llegar al servidor con un tiempo de espera corto. Si no llega, avisa en criollo.
    3. Guarda el resultado en CSV (UTF-8, separador ;) y escribe un resumen: filas y columnas.

  Qué NO hace: no escribe, no borra, no modifica nada en la base. No guarda claves en ningún lado.
  Usa System.Data.SqlClient, que viene con Windows PowerShell 5.1 (no hace falta instalar nada).
#>
param(
  [string]$Conexion = '',
  [Parameter(Mandatory = $true)][string]$Consulta,
  [Parameter(Mandatory = $true)][string]$Salida,
  [int]$Espera = 8,
  [string]$Catalogo = '',
  [switch]$SoloProbar
)

$ErrorActionPreference = 'Stop'
# Que los mensajes con tildes y ñ lleguen bien a Claude (si no, salen como "pesta�a").
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch { }

function Salir([string]$mensaje, [int]$codigo) {
  Write-Output $mensaje
  exit $codigo
}

# --- 1. Solo lectura: un solo SELECT -------------------------------------
$q = $Consulta.Trim()
# Una sola pasada, de izquierda a derecha, como lee SQL Server: textos entre comillas,
# nombres entre [corchetes] o "comillas dobles" y comentarios. Si se hiciera en dos
# pasadas, un texto como '--' o '/*' escondería lo que viene detrás (por ejemplo un DROP).
$token = [regex]'(?s)''(?:[^'']|'''')*''|\[(?:[^\]]|\]\])*\]|"(?:[^"]|"")*"|--[^\r\n]*|/\*.*?\*/'
$plano = $token.Replace($q, {
  param($m)
  $t = $m.Value
  if ($t.StartsWith("'")) { "''" }
  elseif ($t.StartsWith('[') -or $t.StartsWith('"')) { 'x' }
  else { ' ' }
})
$plano = $plano.Trim().TrimEnd(';').Trim()

if ($plano -notmatch '^(?i)(SELECT|WITH)\b') {
  Salir "FRENADO: la consulta tiene que empezar con SELECT (o WITH). Este kit solo lee." 2
}
if ($plano.Contains(';')) {
  Salir "FRENADO: hay mas de una instruccion (punto y coma en el medio). Va una sola consulta." 2
}
$prohibidas = 'INSERT','UPDATE','DELETE','MERGE','DROP','ALTER','CREATE','TRUNCATE','EXEC','EXECUTE','GRANT','REVOKE','DENY','BACKUP','RESTORE','INTO','OPENROWSET','OPENDATASOURCE','OPENQUERY','SHUTDOWN','DBCC','RECONFIGURE','WAITFOR','KILL','CHECKPOINT','SETUSER'
foreach ($p in $prohibidas) {
  if ($plano -match "(?i)\b$p\b") {
    Salir "FRENADO: la consulta usa '$p'. Este kit solo hace SELECT de lectura." 2
  }
}
if ($plano -match '(?i)\b(sp_|xp_)\w*') {
  Salir "FRENADO: la consulta llama a un procedimiento del sistema. Este kit solo hace SELECT de lectura." 2
}

# --- 1b. Solo las vistas validadas (el usuario del servidor lee mas que eso) ---
# El usuario de solo lectura puede leer cualquier tabla o vista. Lo que lo limita a las
# vistas del catalogo es esto: toda tabla o vista que aparezca despues de FROM o JOIN tiene
# que estar en la lista de vistas.md (que viaja dentro del kit). Si falta el catalogo, frena.
if (-not $Catalogo) { $Catalogo = Join-Path (Split-Path -Parent $PSScriptRoot) 'vistas.md' }
if (-not (Test-Path -LiteralPath $Catalogo)) {
  Salir "FALTA CATALOGO: no encuentro vistas.md en '$Catalogo'. Viene dentro del kit: actualizalo o avisale a Guido." 3
}
$permitidas = @{}
$enTabla = $false
foreach ($linea in (Get-Content -LiteralPath $Catalogo -Encoding UTF8)) {
  if ($linea -match '^##\s+Las\s+\d+\s+vistas') { $enTabla = $true; continue }
  if ($enTabla -and $linea -match '^##\s') { break }
  if ($enTabla -and $linea -match '^\|\s*`([A-Za-z_][A-Za-z0-9_]*)`\s*\|') { $permitidas[$Matches[1].ToLower()] = $true }
}
if ($permitidas.Count -eq 0) {
  Salir "FALTA CATALOGO: vistas.md no tiene la lista de vistas validadas. Avisale a Guido." 3
}
# Sin textos ni comentarios, pero con los nombres entre [corchetes] a la vista.
$sinTextos = [regex]::Replace($q, '(?s)''(?:[^'']|'''')*''|--[^\r\n]*|/\*.*?\*/', ' ')
if ($sinTextos -match '(?i)\bAPPLY\b') {
  Salir "FRENADO: la consulta usa APPLY. Usa JOIN sobre las vistas del catalogo." 2
}
$ident = '(?:\[(?:[^\]]|\]\])+\]|"(?:[^"]|"")+"|[A-Za-z_#@][\w$#@]*)'
$objeto = "$ident(?:\s*\.\s*$ident){0,3}"
if ([regex]::IsMatch($sinTextos, "(?i)\b(?:FROM|JOIN)\s+$objeto(?:\s+(?:AS\s+)?[A-Za-z_]\w*)?\s*,")) {
  Salir "FRENADO: hay dos tablas separadas por coma. Usa JOIN, asi se puede controlar que vistas se leen." 2
}
$ctes = @{}
foreach ($m in [regex]::Matches($sinTextos, '(?i)(?:\bWITH|,)\s*([A-Za-z_]\w*)\s*(?:\([^)]*\))?\s*AS\s*\(')) {
  $ctes[$m.Groups[1].Value.ToLower()] = $true
}
foreach ($m in [regex]::Matches($sinTextos, "(?i)\b(?:FROM|JOIN)\s+(?!\()($objeto)")) {
  $partes = @([regex]::Matches($m.Groups[1].Value, $ident) | ForEach-Object { $_.Value.Trim('[', ']', '"') })
  $nombre = $partes[$partes.Count - 1].ToLower()
  $esperado = ($partes.Count -eq 1) -or ($partes.Count -eq 2 -and $partes[0].ToLower() -eq 'dbo')
  $esCte = ($partes.Count -eq 1) -and $ctes.ContainsKey($nombre)
  if (-not $esCte -and (-not $esperado -or -not $permitidas.ContainsKey($nombre))) {
    Salir "FRENADO: '$($partes -join '.')' no esta entre las vistas validadas (vistas.md). Solo se consultan esas, con el nombre dbo.NombreDeLaVista. Si hace falta otra, avisale a Guido." 2
  }
}

# --- 2. Conexión --------------------------------------------------------
# La carpeta Reportes es siempre la misma (Documentos\Reportes), se abra la sesion donde se abra.
# La conexion y los resultados se buscan ahi; una ruta que no sea completa se toma desde ahi.
# (KIT_EQ_REPORTES existe para las pruebas y para quien tenga Documentos en otro lado.)
$reportes = $env:KIT_EQ_REPORTES
if (-not $reportes) { $reportes = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'Reportes' }
if (-not $Conexion) { $Conexion = Join-Path $reportes 'conexion-eq.json' }
elseif (-not [System.IO.Path]::IsPathRooted($Conexion)) { $Conexion = Join-Path $reportes $Conexion }
if (-not [System.IO.Path]::IsPathRooted($Salida)) { $Salida = Join-Path $reportes $Salida }

if (-not (Test-Path -LiteralPath $Conexion)) {
  Salir "FALTA CONEXION: no encuentro '$Conexion'. Lo copia la skill 'configurar' desde la carpeta compartida." 3
}
try {
  $c = Get-Content -LiteralPath $Conexion -Raw -Encoding UTF8 | ConvertFrom-Json
} catch {
  Salir "CONEXION ROTA: '$Conexion' esta mal escrito (ojo: en el nombre del servidor la barra invertida va doble, SERVIDOR\\INSTANCIA). Avisale a Guido." 3
}
foreach ($campo in 'servidor', 'base', 'autenticacion') {
  if (-not $c.$campo) { Salir "CONEXION INCOMPLETA: falta el dato '$campo' en $Conexion." 3 }
}

$b = New-Object System.Data.SqlClient.SqlConnectionStringBuilder
$b['Data Source'] = $c.servidor
$b['Initial Catalog'] = $c.base
$b['Connect Timeout'] = $Espera
$b['Application Name'] = 'kit-eq reportes'
$b['ApplicationIntent'] = 'ReadOnly'
if ($c.autenticacion -eq 'windows') {
  $b['Integrated Security'] = $true
} else {
  if (-not $c.usuario) { Salir "CONEXION INCOMPLETA: falta 'usuario' en $Conexion." 3 }
  if (-not $c.clave) { Salir "CONEXION INCOMPLETA: falta 'clave' en $Conexion." 3 }
  $b['User ID'] = $c.usuario
  $b['Password'] = $c.clave
}

$cn = New-Object System.Data.SqlClient.SqlConnection $b.ConnectionString
try {
  $cn.Open()
} catch {
  $detalle = $_.Exception.Message
  if ($detalle -match '(?i)login failed|error de inicio de sesi') {
    Salir "SIN PERMISO: el servidor respondio, pero no acepto el usuario. Avisale a Guido (no reintentes con otra clave)." 4
  }
  Salir "SIN RED: no llego al servidor. ¿Estas en la oficina (wifi de la empresa) o con la VPN prendida? Desde Cowork no se llega nunca: usa la pestaña Code." 5
}

if ($SoloProbar) {
  $cn.Close()
  Salir "CONEXION OK: llegue al servidor y a la base." 0
}

# --- 3. Consulta y CSV --------------------------------------------------
try {
  # Cinturón y tiradores: la consulta corre dentro de una transacción que SIEMPRE se
  # deshace. Si algo se le escapara al filtro de arriba, igual no queda escrito nada.
  # (La garantía principal es el usuario de solo lectura del servidor.)
  $tx = $cn.BeginTransaction()
  $cmd = $cn.CreateCommand()
  $cmd.Transaction = $tx
  $cmd.CommandText = $q.TrimEnd(';')
  $cmd.CommandTimeout = 120
  $da = New-Object System.Data.SqlClient.SqlDataAdapter $cmd
  $tabla = New-Object System.Data.DataTable
  [void]$da.Fill($tabla)
  $tx.Rollback()
} catch {
  Salir ("ERROR EN LA CONSULTA: " + $_.Exception.Message) 6
} finally {
  $cn.Close()
}

$dir = Split-Path -Parent $Salida
if ($dir -and -not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
if (Test-Path -LiteralPath $Salida) {
  Salir "FRENADO: '$Salida' ya existe. No piso archivos: elegi otro nombre (por ejemplo _v02)." 7
}

# Formato neutro para que el CSV no dependa de la configuración regional de la PC:
# números con punto decimal y fechas AAAA-MM-DD (csv_a_excel.py las pasa a dd/mm/aaaa).
$cultura = [System.Globalization.CultureInfo]::InvariantCulture.Clone()
$cultura.DateTimeFormat.ShortDatePattern = 'yyyy-MM-dd'
$cultura.DateTimeFormat.LongTimePattern = 'HH:mm:ss'
[System.Threading.Thread]::CurrentThread.CurrentCulture = $cultura
$nombres = @($tabla.Columns | ForEach-Object { $_.ColumnName })
$tabla.Rows | Select-Object -Property $nombres |
  Export-Csv -LiteralPath $Salida -NoTypeInformation -Delimiter ';' -Encoding UTF8
if ($tabla.Rows.Count -eq 0) {
  # Sin filas, Export-Csv no escribe nada: dejamos al menos el encabezado.
  Set-Content -LiteralPath $Salida -Value (($nombres | ForEach-Object { '"' + $_ + '"' }) -join ';') -Encoding UTF8
}

$cols = ($tabla.Columns | ForEach-Object { $_.ColumnName + ' (' + $_.DataType.Name + ')' }) -join ', '
Write-Output "OK"
Write-Output "Filas: $($tabla.Rows.Count)"
Write-Output "Columnas ($($tabla.Columns.Count)): $cols"
Write-Output "Archivo: $Salida"
exit 0
