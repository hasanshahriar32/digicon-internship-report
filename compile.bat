@echo off
REM Compilation script for Windows environments
echo ==========================================================
echo Compiling Internship Report: Digicon Technologies PLC
echo ==========================================================

where tectonic >nul 2>nul
if %errorlevel% equ 0 (
    echo [+] Compiling with Tectonic...
    tectonic main.tex
    copy /y main.pdf internship_report.pdf >nul
    echo [✓] Compilation successful! Output: internship_report.pdf
    goto end
)

where typst >nul 2>nul
if %errorlevel% equ 0 (
    echo [+] Compiling with Typst...
    typst compile internship_report.typ internship_report.pdf
    echo [✓] Compilation successful! Output: internship_report.pdf
    goto end
)

where latexmk >nul 2>nul
if %errorlevel% equ 0 (
    echo [+] Compiling with latexmk...
    latexmk -pdf -interaction=nonstopmode main.tex
    copy /y main.pdf internship_report.pdf >nul
    echo [✓] Compilation successful! Output: internship_report.pdf
    goto end
)

echo [-] No local compiler detected. You can upload this directory to Overleaf.com.

:end
pause
