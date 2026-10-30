# Local Windows setup

This project does not currently include a web server or interactive app launcher.
Its Python modules provide math validation, and its scripts can test the Groq API
or generate benchmark responses. Docker is not required for local use.

## Create the local environment

Open the project folder from its Windows path in VS Code (use **File > Open Folder**,
not **Reopen in Container**), then open a PowerShell terminal at the project root.
Install or enable the Microsoft Python extension in the **Local** extension host.
With Python 3.10 or newer installed, run:

```powershell
.\setup_windows.ps1
```

If PowerShell blocks the script, allow scripts for this terminal only and retry:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup_windows.ps1
```

In VS Code, run **Python: Select Interpreter** and choose
`.venv\Scripts\python.exe`. The workspace setting defaults to that Windows
interpreter path; Linux sessions use `.venv/bin/python`. The setup script installs
only the packages listed in `requirements.txt` and verifies the `groq`, `dotenv`
(`python-dotenv`), and `sympy` imports. The `.venv` directory is ignored by Git
and is created on the Windows machine; a virtual environment created in Linux or
a container cannot be reused by Windows.

## Run locally

Check the math module without an API call:

```powershell
.\.venv\Scripts\python.exe -c "from Mathematical_Vericore import compute_ground_truth; print(compute_ground_truth('2 + 2'))"
```

Test a live Groq API request:

```powershell
.\.venv\Scripts\python.exe .\groq_smoke_test.py
```

The API test requires internet access and `GROQ_API_KEY` in the project-root
`.env` file. `GROQ_MODEL` is optional. Keep `.env` private; it is ignored by Git.

To generate responses for the small benchmark dataset:

```powershell
.\.venv\Scripts\python.exe .\benchmarks\run_benchMarks.py --cases cases.json
```

This makes Groq API requests and writes response records under `benchmarks`.
Use `--cases high_school_100.json` to run the larger dataset.

The existing Docker, dev-container, port, and remote-development configuration
is unchanged.
