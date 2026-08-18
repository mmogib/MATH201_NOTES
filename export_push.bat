@echo off
setlocal

if "%~1"=="" (
  echo Usage: %~nx0 ^<commit-message^> [export-args...]
  exit /b 1
)

set "SCRIPT_DIR=%~dp0"
pushd "%SCRIPT_DIR%" >nul || goto :fail

rem %~1 = %1 with surrounding quotes removed
set "MESSAGE=%~1"
shift

set "EXPORT_ARGS="
:collect_args
if "%~1"=="" goto run_export
if defined EXPORT_ARGS (
  set "EXPORT_ARGS=%EXPORT_ARGS% "%~1""
) else (
  set "EXPORT_ARGS="%~1""
)
shift
goto collect_args

:run_export
if defined EXPORT_ARGS (
  julia --project=. src\export.jl %EXPORT_ARGS% || goto :fail
) else (
  julia --project=. src\export.jl || goto :fail
)
git add docs || goto :fail
git commit -m "%MESSAGE%" || goto :fail
git push || goto :fail
popd >nul
goto :eof

:fail
popd >nul
echo Failed with error %errorlevel%.
exit /b %errorlevel%
