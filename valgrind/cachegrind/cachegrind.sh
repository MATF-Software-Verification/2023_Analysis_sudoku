#!/usr/bin/bash

set -e

# Default options
ANNOTATE=false
KCACHEGRIND=false

OUTPUT_FILE="cachegrind_$(date +%s).out"

SUDOKU_BIN="../../sudoku/sudoku"

if [ $# -lt 0 ]; then
    echo "Greška: Nedovoljan broj argumenata. Upotreba: $0 [-a] [-k]"
    exit 1
fi

if { [ "$1" = "-a" ] && [ "$2" = "-k" ]; } || { [ "$1" = "-k" ] && [ "$2" = "-a" ]; }; then
    ANNOTATE=true
    KCACHEGRIND=true
elif [ "$1" = "-k" ]; then
    KCACHEGRIND=true
elif [ "$1" = "-a" ]; then
    ANNOTATE=true
else
    echo "Pokrećem samo alat Cachegrind."
fi

echo "Pokrećem Cachegrind analizu..."

valgrind --tool=cachegrind --quiet --cachegrind-out-file="$OUTPUT_FILE" "$SUDOKU_BIN"

# Ako je opcija -a zadata, koristi cg_annotate
if [ "$ANNOTATE" = true ]; then
    echo "Pokrećem cg_annotate..."
    cg_annotate "$OUTPUT_FILE" > "annotate_$OUTPUT_FILE"
    echo "Rezultat sačuvan u annotate_$OUTPUT_FILE"
fi

# Ako je opcija -k zadata, koristi KCacheGrind
if [ "$KCACHEGRIND" = true ]; then
    echo "Pokrećem KCacheGrind..."
    kcachegrind "$OUTPUT_FILE"
fi
