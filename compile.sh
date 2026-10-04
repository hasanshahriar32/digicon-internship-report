#!/usr/bin/env bash
# Compilation script for the Internship Report (HSTU ECE/CSE Format)
# Supports Tectonic (primary offline LaTeX engine), Typst, and latexmk

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "=========================================================="
echo "Compiling Internship Report: Digicon Technologies PLC"
echo "Directory: $DIR"
echo "=========================================================="

TECTONIC_BIN="$(command -v tectonic 2>/dev/null || echo '/home/hs32/.local/bin/tectonic')"
TYPST_BIN="$(command -v typst 2>/dev/null || echo '/home/hs32/.local/bin/typst')"

if [ -x "$TECTONIC_BIN" ]; then
    echo "[+] Found Tectonic ($TECTONIC_BIN)."
    echo "[+] Compiling full monograph from main.tex..."
    "$TECTONIC_BIN" main.tex
    cp -f main.pdf internship_report.pdf
    echo "[✓] Compilation successful!"
    PAGES=$(pdfinfo main.pdf 2>/dev/null | grep -i 'Pages:' | awk '{print $2}')
    echo "    Output files:"
    echo "    - main.pdf ($PAGES pages)"
    echo "    - internship_report.pdf ($PAGES pages)"
elif command -v latexmk &> /dev/null; then
    echo "[+] Found latexmk. Compiling LaTeX via latexmk..."
    latexmk -pdf -interaction=nonstopmode -shell-escape main.tex
    cp -f main.pdf internship_report.pdf
    echo "[✓] Compilation successful! Output: main.pdf and internship_report.pdf"
elif [ -x "$TYPST_BIN" ]; then
    echo "[+] Found Typst ($TYPST_BIN). Compiling Typst document..."
    "$TYPST_BIN" compile internship_report.typ internship_report.pdf
    echo "[✓] Compilation successful! Output: internship_report.pdf"
else
    echo "[-] No local compiler found."
    echo "    To compile on Overleaf: Zip the entire directory and upload to overleaf.com"
fi
