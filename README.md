# Zeugwerk Scoop Bucket

A [Scoop](https://scoop.sh) bucket for Zeugwerk DevTools.

## Setup

Run this once on each Windows machine. It installs Scoop when needed, registers the token, and adds this bucket. Install the tools you need afterwards. Replace `<YOUR_TOKEN>` with the token provided by Zeugwerk.

```powershell
$env:ZEUGWERK_TOKEN = "<YOUR_TOKEN>"
irm https://zeugwerk.dev/scoop/bootstrap.ps1 | iex
```

Then install what you need, for example `scoop install zkmake`. If you have cloned this repo, [`scripts/setup.ps1 -Token "<YOUR_TOKEN>"`](scripts/setup.ps1) runs the same script.

`main` only tracks DevTools `release/*`. Builds from DevTools `main` are on the `unstable` branch:

```powershell
scoop bucket add zeugwerk-unstable https://github.com/Zeugwerk/scoop-bucket unstable
scoop install zeugwerk-unstable/zkmake
```

## Available Tools

| Tool | Description |
|------|-------------|
| zkmake | Zeugwerk build tool for TwinCAT PLC projects |
| zkdoc | Zeugwerk documentation tool for TwinCAT PLC projects |
| zkinstall | Zeugwerk installer tool for TwinCAT PLC projects |
<<<<<<< Updated upstream
||||||| Stash base
| zkplaincat | Zeugwerk converter for TwinCAT PLC projects to plain Structured Text and back |
| purrmit | Zeugwerk tool for TwinCAT trial licence activation and licence status |
=======
| zkplaincat | Zeugwerk converter for TwinCAT PLC projects to plain Structured Text and back |
| purrmit | Zeugwerk tool for TwinCAT trial licence activation and licence status |
| psexec | PsExec (Sysinternals) for interactive session tools on CI agents |
| autologon | Sysinternals Autologon for CI desktop AutoAdminLogon |
>>>>>>> Stashed changes
| twinpack | Twinpack package manager for TwinCAT PLC libraries |
| docfx | DocFX static site generator used to build the Zeus documentation |

`zkplaincat` is published from DevTools `main` only. Install it from `zeugwerk-unstable`.

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
