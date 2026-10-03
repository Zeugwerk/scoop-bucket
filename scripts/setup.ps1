<#
.SYNOPSIS
    Runs the Zeugwerk Scoop bootstrap (https://zeugwerk.dev/scoop/bootstrap.ps1).

.DESCRIPTION
    Forwards to the hosted script, which installs Scoop when needed, registers
    the download token, and adds the zeugwerk bucket. It does not install
    DevTools. The hosted script is the copy that stays current.
#>
param(
    [Parameter(Mandatory)][string] $Token,
    [switch] $RunAsAdmin,
    [switch] $SkipScoopInstall
)

$installer = [scriptblock]::Create((Invoke-RestMethod https://zeugwerk.dev/scoop/bootstrap.ps1))
& $installer -Token $Token -RunAsAdmin:$RunAsAdmin -SkipScoopInstall:$SkipScoopInstall
