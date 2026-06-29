# Zeugwerk Scoop Bucket

A [Scoop](https://scoop.sh) bucket for Zeugwerk DevTools.

## Setup

Run the following once on each machine. Replace `<YOUR_TOKEN>` with the token provided by Zeugwerk.

```powershell
$Token = "<YOUR_TOKEN>"
$f = "$HOME\.config\scoop\config.json"
New-Item (Split-Path $f) -ItemType Directory -Force | Out-Null
$c = if (Test-Path $f) { Get-Content $f -Raw | ConvertFrom-Json } else { [PSCustomObject]@{} }
$e = [PSCustomObject]@{ match = "https://api.zeugwerk.dev/*"; headers = "Authorization=Bearer $Token" }
$c.private_hosts = @(@($c.private_hosts) | Where-Object { $_ -and $_.match -ne $e.match }) + $e
$c | ConvertTo-Json -Depth 10 | Set-Content $f
scoop bucket add zeugwerk https://github.com/Zeugwerk/scoop-bucket
```

If you have cloned this repo, you can also run [`scripts/setup.ps1 -Token "<YOUR_TOKEN>"`](scripts/setup.ps1) directly.

## Available Tools

| Tool | Description |
|------|-------------|
| zkmake | Zeugwerk build tool for TwinCAT PLC projects |
| zkdoc | Zeugwerk documentation tool for TwinCAT PLC projects |
| zkinstall | Zeugwerk installer tool for TwinCAT PLC projects |
| twinpack | Twinpack package manager for TwinCAT PLC libraries |

## Using in a CI/CD pipeline

Once the node is set up, tools are available directly in your pipeline scripts. A minimal GitLab CI example:

```
build:
  tags: [windows]
  script:
    - scoop update zkmake zkdoc
    - zkmake build --update-snapshots --kill-all
    - zkdoc --docfx reference --output documentation .
  artifacts:
    paths: ["*.library", "documentation/"]
```

No download logic, no credential handling in the pipeline. Scoop handles authentication and caching transparently.

## Updating

```powershell
scoop update *
```

## Pinning a specific version

```powershell
scoop install zkmake@1.9.0
scoop hold zkmake
```

## Uninstalling

```powershell
scoop uninstall zkmake
```

## Background

For more on why we chose Scoop for on-prem TwinCAT CI/CD tool distribution and how the authentication layer works, see our [blog post](https://zeugwerk.dev/blog/distributing-devtools-with-scoop/).
