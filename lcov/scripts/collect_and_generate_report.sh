#!/usr/bin/env bash
set -e

# Pretpostavka: .gcda/.gcno su u ../../sudoku direktorijumu
cd ../../sudoku
lcov --directory . --capture --output-file coverage.info
cd - > /dev/null

# Kopiraj coverage.info u folder lcov za generisanje
cp ../../sudoku/coverage.info .

genhtml coverage.info --output-directory coverage_html
