#!/usr/bin/bash
set -e

rm -rf coverage_html
rm -f coverage.info
rm -f ../../sudoku/coverage.info
rm -f ../../sudoku/sudoku_tests
rm -f ../../sudoku/*.gcno

lcov --directory ../../sudoku --zerocounters