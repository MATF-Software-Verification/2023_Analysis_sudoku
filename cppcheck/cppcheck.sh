#!/usr/bin/bash

set -e

echo "Pokrecem cppcheck staticku analizu..."

# Putanja do projekta
PROJECT_DIR="../sudoku"

# Proveri opcionalne argumente
HTML_MODE=false
for arg in "$@"; do
    if [ "$arg" = "-html" ]; then
        HTML_MODE=true
    fi
done

if [ "$HTML_MODE" = true ]; then
    echo "Pokrecem cppcheck sa XML izlazom za HTML izvestaj..."

    # Generisanje XML fajla
    XML_FILE="cppcheck_output.xml"
    if cppcheck --quiet --enable=all --suppress=missingInclude --force --output-file="$XML_FILE" --xml $PROJECT_DIR; then
        echo "Cppcheck analiza uspesno zavrsena!"
        echo "Generise se HTML izvestaj..."

        # Kreiranje HTML izvestaja
        REPORT_DIR="html-report"
        mkdir -p $REPORT_DIR

        if cppcheck-htmlreport --file="$XML_FILE" --report-dir="$REPORT_DIR"; then
            echo "HTML izvestaj je generisan, otvaramo $REPORT_DIR/index.html"
            firefox "$REPORT_DIR/index.html"
        else
            echo "Greska pri generisanju HTML izvestaja."
        fi
    else
        echo "Greska pri statickoj analizi."
    fi
else
    # Tekstualni izvestaj
    OUTPUT_FILE="cppcheck_$(date +%s).txt"
    
    if cppcheck --quiet --enable=all --suppress=missingInclude --force --output-file="$OUTPUT_FILE" $PROJECT_DIR; then
        echo "Analiza je uspesno zavrsena! Za pregled rezultata otvorite $OUTPUT_FILE"
    else
        echo "Greska pri statickoj analizi."
    fi
fi

