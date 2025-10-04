#!/usr/bin/env bash
set -e

# Pozicioniranje u direktorijum sudoku 
cd ../../sudoku

# Kompajliranje sa merenjem pokrivenosti
g++ -fprofile-arcs -ftest-coverage -O0 -g \
    game.cpp solver.cpp altproj.cpp tests.cpp main.cpp \
    -o sudoku_tests --coverage
# Pokeretanje testova
./sudoku_tests
# Vrati se nazad
cd - > /dev/null
