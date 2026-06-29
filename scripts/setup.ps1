param(
    [Parameter(Mandatory)][string]$Token
)

$f = "$HOME\.config\scoop\config.json"
New-Item (Split-Path $f) -ItemType Directory -Force | Out-Null
$c = if (Test-Path $f) { Get-Content $f -Raw | ConvertFrom-Json } else { [PSCustomObject]@{} }
$e = [PSCustomObject]@{ match = "https://api.zeugwerk.dev/*"; headers = "Authorization=Bearer $Token" }
$c.private_hosts = @(@($c.private_hosts) | Where-Object { $_ -and $_.match -ne $e.match }) + $e
$c | ConvertTo-Json -Depth 10 | Set-Content $f

scoop bucket add zeugwerk https://github.com/Zeugwerk/scoop-bucket
