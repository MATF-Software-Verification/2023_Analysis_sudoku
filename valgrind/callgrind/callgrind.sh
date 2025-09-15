#!/usr/bin/bash

set -e

ANNOTATE=false
KCACHEGRIND=false

OUTPUT_FILE="callgrind_$(date +%s).out"

SUDOKU_BIN="../../sudoku/sudoku"

if [ $# -eq 0 ]; then
    echo "Pokrećem samo alat callgrind."
fi

if { [ "$1" = "-a" ] && [ "$2" = "-k" ]; } || { [ "$1" = "-k" ] && [ "$2" = "-a" ]; };; then
    ANNOTATE=true
    KCACHEGRIND=true
elif [ "$1" = "-k" ]; then
    KCACHEGRIND=true
elif [ "$1" = "-a" ]; then
    ANNOTATE=true
fi

echo "Pokrećem callgrind analizu..."

valgrind --tool=callgrind --quiet --callgrind-out-file="$OUTPUT_FILE" "$SUDOKU_BIN"

# Ako je opcija -a zadata, koristi callgrind_annotate
if [ "$ANNOTATE" = true ]; then
    echo "Pokrećem callgrind_annotate..."
    callgrind_annotate "$OUTPUT_FILE" > "annotate_$OUTPUT_FILE"
    echo "Rezultat sačuvan u annotate_$OUTPUT_FILE"
fi

# Ako je opcija -k zadata, koristi KCacheGrind
if [ "$KCACHEGRIND" = true ]; then
    echo "Pokrećem KCacheGrind..."
    kcachegrind "$OUTPUT_FILE"
fi
