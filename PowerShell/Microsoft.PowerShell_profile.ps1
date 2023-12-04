# Import-Module Terminal-Icons

# One Dark Pro color scheme for Windows Termianl done right
# Shows list View of history commands
Set-PSReadLineOption `
  -PredictionSource History `
  -PredictionViewStyle ListView `
  -HistorySearchCursorMovesToEnd `
  -ShowToolTips `
  -Colors @{
  Command            = '#32a89e' 
  Number             = '#e5c07b'
  Member             = '#c678dd'
  Operator           = '#56b6c2'
  Type               = '#abb2bf'
  Variable           = '#e06c75'
  Parameter          = '#61afef'
  InlinePrediction   = '#223344'
  ContinuationPrompt = '#282c34'
  Default            = '#98c379'
  Error              = 'Red'
}

# Close terminal with control+d like on unix/linux
Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit 

# Shows navigable menu of all options when hitting Tab
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

$ENV:STARSHIP_CONFIG = "$HOME\Documents\PowerShell\starship.toml"

Invoke-Expression (&starship init powershell) 

function Invoke-Starship-TransientFunction {
  $ENV:STARSHIP_CONFIG = "$HOME\Documents\PowerShell\transient.toml" 
  &starship prompt
  $ENV:STARSHIP_CONFIG = "$HOME\Documents\PowerShell\starship.toml"
}

Enable-TransientPrompt

$ENV:EDITOR = "nvim"
$ENV:VISUAL = "nvim"

Set-Alias -Name v -Value vim

# client emacs gui
function emacs {
  & $HOME\scoop\apps\emacs\29.1\bin\emacsclientw.exe -c -a "$HOME\scoop\apps\emacs\29.1\bin\emacs.exe"
}

# terminal emacs editor
function em {
  & $HOME\scoop\apps\emacs\29.1\bin\emacs.exe -nw
}

Remove-Item alias:nv -Force # Remapped alias to nvim
Set-Alias -Name nv -Value nvim
Set-Alias -Name e -Value nvim

Set-Alias touch new-item

Set-Alias lg lazygit
Set-Alias g git
Set-Alias gf gfold

Set-Alias Mark MarkText

# Powershell keeps giving warnings when trying to create variables and not use them
# So we use a set-alias to create a variable and use it in the set-alias

# The following commands are macros used to run or compile multiple languages
#TODO: get a snigle files to run instead of multiple files

<#
$files = New-Object System.IO.FileInfo('files.type')
$files.BaseName, $files.Extension

$filepath = Get-ChildItem -Path *.cpp -Recurse -Force
$files = $filepath.name
#>

function make
{
  if (Test-Path 'CMakeLists.txt')
  {
    cmake -S . -B .\bin\ -G 'MinGW Makefiles' ; if ($?)
    { mingw32-make -s -C .\bin 
    }
    # Alternative method to compile
    # $filepath = Get-Item .\build\*.sln
    # $files = $filepath.name
    # "cmake -S . -B .\build\ -G 'Visual Studio 17 2022' ; if (`$?) { msbuild.exe -m -nologo -verbosity:Quiet .\build\$files }"
    # https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild?view=vs-2022
    # https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-command-line-reference?view=vs-2022
    # https://docs.microsoft.com/en-us/visualstudio/msbuild/obtaining-build-logs-with-msbuild?view=vs-2022
  }
}

function start-cmake
{
  if (!(Test-Path 'CMakeLists.txt'))
  {
    New-Item 'CMakeLists.txt'
    Write-Output "cmake_minimum_required(VERSION 3.0)`n`nproject(test)`n`ninclude_directories(inc)`n`nadd_executable(`${PROJECT_NAME} ./src/main.cpp )`n`nlink_libraries(`${PROJECT_NAME} inc)" > 'CMakeLists.txt'
  }
  make
}

function build
{
  if (Test-Path 'CMakeLists.txt')
  {
    make
  } elseif (Test-Path *.cpp)
  {
    $filepath = Get-Item *.cpp
    $files = $filepath.name
    g++ $files -o app
  } elseif (Test-Path *.c)
  {
    $filepath = Get-Item *.c
    $files = $filepath.name
    gcc $files -o app
  } else
  {
    Write-Output 'No files to build'
  }
}

function run
{
  if (Test-Path *.cpp)
  {
    build
    if ($?)
    {
      .\app
    }
  } elseif (Test-Path *.c)
  {
    build
    if ($?)
    {
      .\app
    }
  } elseif (Test-Path *.py)
  {
    # Python: run
    $filepath = Get-Item *.py
    $files = $filepath.name
    # If there is multiple files with in the same directory they will all get executed
    # Current solution is to use a main function with in each module :3
    python $files
  } elseif (Test-Path *.js)
  {
    # JavaScript: run
    $filepath = Get-Item *.js
    $files = $filepath.name
    node $files
  }
}

# C/C++: Build
Set-PSReadLineKeyHandler `
  -Key Ctrl+Shift+b `
  -BriefDescription BuildCurrentDirectory `
  -LongDescription 'Build the current directory' `
  -ScriptBlock {
  # if (Test-Path 'CMakeLists.txt') {
  #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('build')
  #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  # }
  # elseif (Test-Path '*.cpp') {
  #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('build')
  #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  # }
  # elseif (Test-Path '*.c') {
  #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('build')
  #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  # }
  # else {
  #     Write-Error 'No C/C++ files found'
  # }
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('build')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# Run or build-and-run any language
Set-PSReadLineKeyHandler `
  -Key Ctrl+b `
  -BriefDescription BuildCurrentDirectory `
  -LongDescription 'Build the current directory' `
  -ScriptBlock {
  if (Test-Path 'CMakeLists.txt')
  {
    # Alternative method to compile and run used with method on line 100
    # "make ; if(`$?) { .\build\debug\$exe }"
    # $exepath = Get-Item .\build\debug\*.exe
    $exepath = Get-Item .\bin\*.exe
    $exe = $exepath.name
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("build ; if (`$?) { .\bin\$exe }")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  } else
  {
    # Write-Error 'No supported files found'
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('run')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }
  # elseif (Test-Path '*.cpp') {
  #     # C++: Build and run
  #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('run')
  #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  # }
  # elseif (Test-Path '*.c') {
  #     # C: Build and run
  #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('run')
  #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  # }
  # elseif (Test-Path '*.py') {
  #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('run')
  #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  # }
  # elseif (Test-Path '*.js') {
  #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert('run')
  #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  # }

}

<#
 # For Windows PowerShell
 # set-alias -name <alias_name> -value <command>
 <alias_name> is the new alias name you want to set.
 <command> is the command you want to alias.
 NB: this is temporal and will not work when powershell is reboot.
 To make it permanent, add it to PowerShell Profile.ps1 files.
#>

<#
 For Windows PowerShell
 function <alias_name> {cd "C:\Users..."}
 We use `function` and not
 set-alias -name <new_alias> -value <command>
 because cmdlets(cd) don't work in set-alias -value.
 NB: this is temporal and will not work when powershell is rebooted.
 To make it permanent, add it to PowerShell Profile.ps1 files.
#>

function Study
{
  # [alias('Studing-Projects')]

  Set-Location '~\\Studies'
  code .
  # Start-Process .
}
Set-Alias Studies Study

function Project
{
  Set-Location '~\\Projects'
  code .
  # Start-Process .
}
Set-Alias Projects Project

function devenv
{
  # param {
  #     [string[]]$location
  # }
  # Set-Location '~\\source\\repos'
  Start-Process 'devenv'
}
Set-Alias -Name visual-studio -Value devenv

function pycharm
{
  # Set-Location '~\\PycharmProjects'
  Start-Process pycharm
  # just "pycharm" works as well,
  # but it graps hold of the terminal and you can't use it.
}
