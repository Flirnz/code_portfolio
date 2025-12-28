@echo off
echo Compiling main.cpp...
clang++ main.cpp -o main.exe
if %ERRORLEVEL% NEQ 0 (
    echo Compilation failed!
    exit /b %ERRORLEVEL%
)
echo Compilation successful. Running main.exe...
echo ------------------------------------------
.\main.exe
echo.
echo ------------------------------------------
