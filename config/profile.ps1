Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Helper function to change directory to my development workspace
# Change c:\ws to your usual workspace and everytime you type
# in cws from PowerShell it will take you directly there.
function cws { Set-Location ~\workspace }

# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

# Helper function to show Unicode character
function U
{
  param
  (
    [int] $Code
  )
  if ((0 -le $Code) -and ($Code -le 0xFFFF))
  {
    return [char] $Code
  }

  if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
  {
    return [char]::ConvertFromUtf32($Code)
  }
  throw "Invalid character code $Code"
}


Import-Module posh-git

# Start SshAgent if not already
# Need this if you are using github as your remote git repository
if (! (ps | ? { $_.Name -eq 'ssh-agent'})) {
    Start-SshAgent
}

Import-Module oh-my-posh
Set-Theme sorin

# We do this for Powershell as Admin Sessions because CMDER_ROOT is not beng set.
if (! $ENV:CMDER_ROOT ) {
    if ( $ENV:ConEmuDir ) {
        $ENV:CMDER_ROOT = resolve-path( $ENV:ConEmuDir + "\..\.." )
    } else {
        $ENV:CMDER_ROOT = resolve-path( $PSScriptRoot + "\.." )
    }
}

# Remove trailing '\'
$ENV:CMDER_ROOT = (($ENV:CMDER_ROOT).trimend("\"))

$CmderModulePath = Join-path $PSScriptRoot "psmodules/"

Invoke-CmdScript.ps1 "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" "x64"
$env:path += ";C:/ProgramData/chocolatey/lib/lua53/tools"
$env:path += ";C:/Strawberry/perl/bin"
$env:path += ";C:/tools/ruby26/bin"
$env:path += ";C:\tools\vim81-kaoriya-win64"
