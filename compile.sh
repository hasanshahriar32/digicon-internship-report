#!/usr/bin/env bash
# Compilation script for the Internship Report (HSTU ECE Format)
# Supports Tectonic (primary offline LaTeX engine) and native Typst

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "=========================================================="
echo "Compiling Internship Report: Digicon Technologies PLC"
echo "Directory: $DIR"
echo "=========================================================="

TECTONIC_BIN="$(command -v tectonic 2>/dev/null || echo '/home/hs32/.local/bin/tectonic')"
TYPST_BIN="$(command -v typst 2>/dev/null || echo '/home/hs32/.local/bin/typst')"

# 1. Compile LaTeX monograph
if [ -x "$TECTONIC_BIN" ]; then
    echo "[+] Found Tectonic ($TECTONIC_BIN)."
    echo "[+] Compiling full LaTeX monograph from main.tex..."
    "$TECTONIC_BIN" main.tex
    cp -f main.pdf internship_report.pdf
    PAGES_TEX=$(pdfinfo main.pdf 2>/dev/null | grep -i 'Pages:' | awk '{print $2}')
    echo "[✓] LaTeX compilation successful: main.pdf / internship_report.pdf ($PAGES_TEX pages)"
elif command -v latexmk &> /dev/null; then
    echo "[+] Found latexmk. Compiling LaTeX via latexmk..."
    latexmk -pdf -interaction=nonstopmode -shell-escape main.tex
    cp -f main.pdf internship_report.pdf
    PAGES_TEX=$(pdfinfo main.pdf 2>/dev/null | grep -i 'Pages:' | awk '{print $2}')
    echo "[✓] LaTeX compilation successful: main.pdf / internship_report.pdf ($PAGES_TEX pages)"
fi

# 2. Compile native Typst monograph
if [ -x "$TYPST_BIN" ]; then
    echo "[+] Found Typst ($TYPST_BIN)."
    echo "[+] Compiling native Typst monograph from internship_report.typ..."
    "$TYPST_BIN" compile internship_report.typ typst_internship_report.pdf
    PAGES_TYP=$(pdfinfo typst_internship_report.pdf 2>/dev/null | grep -i 'Pages:' | awk '{print $2}')
    echo "[✓] Typst compilation successful: typst_internship_report.pdf ($PAGES_TYP pages)"
fi

echo "=========================================================="
echo "All compilation targets completed successfully!"
echo "=========================================================="
