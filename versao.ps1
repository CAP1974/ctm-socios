$ErrorActionPreference = 'Stop'
$dir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$html  = Join-Path $dir 'index.html'
$vjson = Join-Path $dir 'version.json'
$utf8  = New-Object System.Text.UTF8Encoding $false

$hoje = Get-Date -Format 'yyyy.MM.dd'
$txt  = [System.IO.File]::ReadAllText($html, [System.Text.Encoding]::UTF8)

$m = [regex]::Match($txt, "APP_VER='([^']+)'")
if (-not $m.Success) {
  Write-Output "ERRO: nao encontrei APP_VER dentro do index.html"
  exit 1
}
$atual = $m.Groups[1].Value

if ($atual.StartsWith($hoje)) {
  $partes = $atual.Split('.')
  if ($partes.Length -ge 4) { $n = [int]$partes[3] + 1 } else { $n = 1 }
  $nova = "$hoje.$n"
} else {
  $nova = $hoje
}

$txt = [regex]::Replace($txt, "APP_VER='[^']+'", "APP_VER='$nova'")
[System.IO.File]::WriteAllText($html, $txt, $utf8)

$notas = ''
$nf = Join-Path $dir 'NOTAS.txt'
if (Test-Path $nf) {
  $linha = Get-Content -Path $nf -Encoding UTF8 | Where-Object { $_.Trim() -ne '' -and -not $_.StartsWith('#') } | Select-Object -First 1
  if ($linha) { $notas = $linha.Trim() }
}
if (-not $notas) { $notas = 'atualizacao' }

$obj = [ordered]@{
  version   = $nova
  notas     = $notas
  publicado = (Get-Date -Format 'yyyy-MM-dd HH:mm')
}
[System.IO.File]::WriteAllText($vjson, ($obj | ConvertTo-Json), $utf8)

Write-Output "Versao anterior: $atual"
Write-Output "Versao nova....: $nova"
Write-Output "Notas..........: $notas"
