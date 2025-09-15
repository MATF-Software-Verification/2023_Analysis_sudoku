#!/usr/bin/bash
set -e

PROJECT_DIR="$(dirname "$0")/../../sudoku"

CLEAN=false

if [ "$1" = "clean" ]; then
    CLEAN=true
fi

if [ "$CLEAN" = true ]; then
    echo "Čistim stari build..."
    make -C "$PROJECT_DIR" clean
fi

echo "Pokrecem sudoku projekat..."
make -C "$PROJECT_DIR"

echo "Build završen. Executable je u: $PROJECT_DIR/sudoku"
