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
  [Parameter(Mandatory = $true)][string]$Conexion,
  [Parameter(Mandatory = $true)][string]$Consulta,
  [Parameter(Mandatory = $true)][string]$Salida,
  [int]$Espera = 8,
  [switch]$SoloProbar
)

$ErrorActionPreference = 'Stop'

function Salir([string]$mensaje, [int]$codigo) {
  Write-Output $mensaje
  exit $codigo
}

# --- 1. Solo lectura: un solo SELECT -------------------------------------
$q = $Consulta.Trim()
$sinComentarios = ($q -replace '(?s)/\*.*?\*/', ' ') -replace '--[^\r\n]*', ' '
$plano = ($sinComentarios -replace "'[^']*'", "''").Trim().TrimEnd(';').Trim()

if ($plano -notmatch '^(?i)(SELECT|WITH)\b') {
  Salir "FRENADO: la consulta tiene que empezar con SELECT (o WITH). Este kit solo lee." 2
}
if ($plano.Contains(';')) {
  Salir "FRENADO: hay mas de una instruccion (punto y coma en el medio). Va una sola consulta." 2
}
$prohibidas = 'INSERT','UPDATE','DELETE','MERGE','DROP','ALTER','CREATE','TRUNCATE','EXEC','EXECUTE','GRANT','REVOKE','DENY','BACKUP','RESTORE','INTO','OPENROWSET','OPENDATASOURCE','OPENQUERY','SHUTDOWN','DBCC','RECONFIGURE','WAITFOR'
foreach ($p in $prohibidas) {
  if ($plano -match "(?i)\b$p\b") {
    Salir "FRENADO: la consulta usa '$p'. Este kit solo hace SELECT de lectura." 2
  }
}
if ($plano -match '(?i)\b(sp_|xp_)\w*') {
  Salir "FRENADO: la consulta llama a un procedimiento del sistema. Este kit solo hace SELECT de lectura." 2
}

# --- 2. Conexión --------------------------------------------------------
if (-not (Test-Path -LiteralPath $Conexion)) {
  Salir "FALTA CONEXION: no encuentro '$Conexion'. Lo copia la skill 'configurar' desde la carpeta compartida." 3
}
$c = Get-Content -LiteralPath $Conexion -Raw -Encoding UTF8 | ConvertFrom-Json
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
  $cmd = $cn.CreateCommand()
  $cmd.CommandText = $q.TrimEnd(';')
  $cmd.CommandTimeout = 120
  $da = New-Object System.Data.SqlClient.SqlDataAdapter $cmd
  $tabla = New-Object System.Data.DataTable
  [void]$da.Fill($tabla)
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
