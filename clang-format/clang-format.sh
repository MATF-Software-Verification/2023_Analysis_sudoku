#!/usr/bin/env bash
set -e

# Putanja do sudoku projekta
TARGET_DIR="../sudoku"

# Pronadji sve fajlove sa ekstenzijama cpp, hpp, h i cc
mapfile -t FILES < <(find "$TARGET_DIR" -type f \( -name "*.cpp" -o -name "*.hpp" -o -name "*.h" -o -name "*.cc" \) | sort)

# Ako nema fajlova prekini
if [ ${#FILES[@]} -eq 0 ]; then
    echo "Nema C++ fajlova u $TARGET_DIR"
    exit 1
fi

# Ispisi listu fajlova
echo "Dostupni fajlovi:"
for i in "${!FILES[@]}"; do
    printf "%3d) %s\n" $((i+1)) "${FILES[$i]}"
done

# Korisnik bira fajlove ili all
read -p "Izaberi brojeve fajlova razdvojene razmakom (ili 'all' za sve): " choice

# Ako je korisnik uneo "all"
if [ "$choice" == "all" ]; then
    SELECTED=("${FILES[@]}")
else
    # Proveri da li su svi brojevi validni
    for num in $choice; do
        if ! [[ "$num" =~ ^[0-9]+$ ]] || [ "$num" -lt 1 ] || [ "$num" -gt "${#FILES[@]}" ]; then
            echo "Nevazeci izbor: $num"
            exit 1
        fi
    done

    # Dodaj izabrane fajlove u listu
    SELECTED=()
    for num in $choice; do
        SELECTED+=("${FILES[$((num-1))]}")
    done
fi

# Iteriraj kroz sve izabrane fajlove
for FILE in "${SELECTED[@]}"; do
    echo "-------------------------------"
    echo "Prikazujem razlike pre formatiranja za: $FILE"
    diff -u "$FILE" <(clang-format -style=file "$FILE") || true

    echo "Formatiram fajl..."
    clang-format -i -style=file "$FILE"
    echo "Zavrseno: $FILE"
done

echo "✅ Gotovo formatiranje svih izabranih fajlova"
