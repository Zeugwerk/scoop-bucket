# Zeugwerk Scoop Bucket

A [Scoop](https://scoop.sh) bucket for Zeugwerk DevTools.

## Setup

1. Obtain your access token from Zeugwerk
2. Set your token (run once as Administrator):

```powershell
[Environment]::SetEnvironmentVariable("ZEUGWERK_TOKEN", "your-token", "Machine")
```

3. Add the bucket and install tools:

```powershell
   scoop bucket add zeugwerk https://github.com/Zeugwerk/scoop-bucket
scoop install zeugwerk/zkmake
```

## Available Tools

| Tool | Description |
|------|-------------|
| zkmake | Zeugwerk build tool for TwinCAT PLC projects |
| zkdoc | Zeugwerk documentation tool for TwinCAT PLC projects |
| zkinstall | Zeugwerk installer tool for TwinCAT PLC projects |
| zklicpwn | Zeugwerk license activation tool for TwinCAT |
| twinpack | Twinpack package manager for TwinCAT PLC libraries |

## Updating

```powershell
scoop update *
```
