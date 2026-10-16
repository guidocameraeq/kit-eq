<#
  probar_consultar.ps1 - prueba el filtro de consultar.ps1 SIN conectarse a ningun servidor.
  Cada consulta se manda con una conexion que no existe:
    - si el filtro la deja pasar, el script llega a "FALTA CONEXION" (codigo 3);
    - si el filtro la frena, termina con "FRENADO" (codigo 2).
  Uso:  powershell -NoProfile -ExecutionPolicy Bypass -File herramientas\probar_consultar.ps1
#>
$raiz = Split-Path -Parent $PSScriptRoot
$script = Join-Path $raiz 'plugins\kit-eq-code\skills\reportes\scripts\consultar.ps1'

# Los nombres de las vistas se leen del catalogo (vistas.md): este archivo no lleva ninguno.
$v = @()
$enTabla = $false
foreach ($linea in (Get-Content -LiteralPath (Join-Path $raiz 'plugins\kit-eq-code\skills\reportes\vistas.md') -Encoding UTF8)) {
  if ($linea -match '^##\s+Las\s+\d+\s+vistas') { $enTabla = $true; continue }
  if ($enTabla -and $linea -match '^##\s') { break }
  if ($enTabla -and $linea -match '^\|\s*`([A-Za-z_][A-Za-z0-9_]*)`\s*\|') { $v += $Matches[1] }
}
if ($v.Count -lt 5) { throw 'El catalogo tiene menos de 5 vistas: no alcanza para las pruebas.' }

# 'PASA' o 'FRENA', y la consulta
$casos = @(
  @('PASA',  "SELECT 1"),
  @('PASA',  "SELECT TOP 5 * FROM dbo.$($v[1])"),
  @('PASA',  "SELECT * FROM [dbo].[$($v[0])] e WHERE e.Fecha >= '20261001' AND e.Fecha < '20261101'"),
  @('PASA',  "select e.ClienteCodigo from dbo.$($v[0]) e join dbo.$($v[3]) c on c.Codigo = e.ClienteCodigo"),
  @('PASA',  "WITH v AS (SELECT ClienteCodigo FROM dbo.$($v[2])) SELECT * FROM v"),
  @('PASA',  "SELECT * FROM dbo.$($v[4]) WHERE Detalle = 'FROM dbo.TablaSecreta'"),
  @('FRENA', "SELECT * FROM dbo.TablaInterna"),
  @('FRENA', "SELECT * FROM $($v[1]), dbo.TablaInterna"),
  @('FRENA', "SELECT * FROM dbo.$($v[1]) p, dbo.TablaInterna t"),
  @('FRENA', "SELECT * FROM dbo.$($v[1]) p JOIN dbo.TablaInterna t ON t.ID = p.ID"),
  @('FRENA', "SELECT * FROM [dbo].[TablaInterna]"),
  @('FRENA', "SELECT * FROM otra.dbo.$($v[1])"),
  @('FRENA', "SELECT * FROM sys.tables"),
  @('FRENA', "SELECT * FROM INFORMATION_SCHEMA.COLUMNS"),
  @('FRENA', "SELECT * FROM dbo.$($v[1]) WHERE ID IN (SELECT ID FROM dbo.TablaInterna)"),
  @('FRENA', "SELECT * FROM (SELECT * FROM dbo.TablaInterna) x"),
  @('FRENA', "SELECT * FROM dbo.$($v[1]) p CROSS APPLY dbo.fnLoQueSea(p.ID)"),
  @('FRENA', "SELECT * FROM dbo.$($v[1]); DROP TABLE dbo.x"),
  @('FRENA', "DELETE FROM dbo.$($v[1])")
)

$mal = 0
foreach ($c in $casos) {
  $salida = & powershell -NoProfile -ExecutionPolicy Bypass -File $script -Conexion 'no-existe.json' -Consulta $c[1] -Salida 'no-existe.csv' 2>&1
  $codigo = $LASTEXITCODE
  $real = if ($codigo -eq 2) { 'FRENA' } elseif ($codigo -eq 3) { 'PASA' } else { "?($codigo)" }
  $ok = ($real -eq $c[0])
  if (-not $ok) { $mal++ }
  '{0}  esperado={1} real={2}  {3}' -f $(if ($ok) { 'OK ' } else { 'MAL' }), $c[0], $real, $c[1]
}
''
# La conexion y los resultados se buscan siempre en la carpeta Reportes, sin importar desde donde se corra.
$tmp = Join-Path $env:TEMP ('prueba-reportes-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $tmp | Out-Null
$env:KIT_EQ_REPORTES = $tmp
$sinConexion = (& powershell -NoProfile -ExecutionPolicy Bypass -File $script -Consulta 'SELECT 1' -Salida 'resultados\x.csv' 2>&1) -join ' '
Remove-Item Env:KIT_EQ_REPORTES
Remove-Item $tmp -Recurse -Force
if ($sinConexion -like "*FALTA CONEXION*" -and $sinConexion -like "*$tmp*conexion-eq.json*") { 'OK   sin -Conexion busca conexion-eq.json en la carpeta Reportes' }
else { $mal++; "MAL  sin -Conexion no busco en la carpeta Reportes: $sinConexion" }
''
if ($mal -eq 0) { "Todas las pruebas dieron lo esperado ($($casos.Count))." } else { "HAY $mal PRUEBA(S) CON RESULTADO DISTINTO."; exit 1 }
