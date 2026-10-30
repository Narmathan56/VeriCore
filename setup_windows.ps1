$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$launcher = Get-Command py -ErrorAction SilentlyContinue
if ($launcher) {
    $python = $launcher.Source
    $pythonArgs = @("-3")
} else {
    $pythonCommand = Get-Command python -ErrorAction SilentlyContinue
    if (-not $pythonCommand) {
        throw "Python 3 is required. Install Python for Windows and rerun this script."
    }

    $python = $pythonCommand.Source
    $pythonArgs = @()
}

& $python @pythonArgs -c "import sys; raise SystemExit(sys.version_info < (3, 10))"
if ($LASTEXITCODE -ne 0) {
    throw "Python 3.10 or newer is required."
}

& $python @pythonArgs -m venv .venv
if ($LASTEXITCODE -ne 0) {
    throw "Could not create .venv."
}

$venvPython = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"
& $venvPython -m pip install -r (Join-Path $PSScriptRoot "requirements.txt")
if ($LASTEXITCODE -ne 0) {
    throw "Could not install project requirements in .venv."
}

& $venvPython -c "import groq, dotenv, sympy; print('Verified imports: groq, python-dotenv (dotenv), sympy')"
if ($LASTEXITCODE -ne 0) {
    throw "Could not import all project dependencies from .venv."
}

Write-Host "Local environment ready. Select .venv\Scripts\python.exe in VS Code."
