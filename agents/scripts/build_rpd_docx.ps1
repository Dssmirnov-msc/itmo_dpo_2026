param(
    [string]$Source = "target\RPD.md",
    [string]$Output = "target\RPD.docx"
)

$ErrorActionPreference = "Stop"
$ProjectRoot = Split-Path -Parent $PSScriptRoot

if (-not [System.IO.Path]::IsPathRooted($Source)) {
    $Source = Join-Path $ProjectRoot $Source
}

if (-not [System.IO.Path]::IsPathRooted($Output)) {
    $Output = Join-Path $ProjectRoot $Output
}

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    throw "pandoc is not installed or is not available in PATH"
}

if (-not (Test-Path -LiteralPath $Source)) {
    throw "Source file not found: $Source"
}

pandoc $Source -o $Output --from markdown --to docx
if ($LASTEXITCODE -ne 0) {
    throw "pandoc failed with exit code $LASTEXITCODE"
}

Write-Host "DOCX created: $Output"
