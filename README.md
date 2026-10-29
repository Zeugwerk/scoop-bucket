# Zeugwerk Scoop Bucket

A [Scoop](https://scoop.sh) bucket for Zeugwerk DevTools.

## Setup

Run this once on each Windows machine. It installs Scoop when needed, registers the token, and adds this bucket. Install the tools you need afterwards. Replace `<YOUR_TOKEN>` with the token provided by Zeugwerk.

```powershell
$env:ZEUGWERK_TOKEN = "<YOUR_TOKEN>"
$env:ZEUGWERK_SCOOP_UNSTABLE = '1'
irm https://zeugwerk.dev/scoop/bootstrap.ps1 | iex
```

Then install what you need, for example

```powershell
scoop install plcsense twinpack
scoop install zeugwerk-unstable/zkmake
```

The tools available to you depend on the privileges set on `<YOUR_TOKEN>`.

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
