# Analiza projekta 'Sudoku'

GitHub repozitorijum posvećen izradi samostalnog praktičnog seminarskog rada za potrebe kursa Verifikacija softvera na master studijama Matematičkog fakulteta u Beogradu.
Praktični seminarski rad podrazumeva primenu alata za statičku i dinamičku verifikaciju softvera na izabranom studentskom projektu.

Autor: *Aleksandar Stoiljković 1043/2023*

## Opis analiziranog projekta

Projekat Sudoku predstavlja implementaciju popularne logičke igre u kojoj je cilj popuniti mrežu brojevima od 1 do 9 tako da se svaki broj pojavljuje tačno jednom u svakom redu, koloni i svakom 3x3 kvadratu.
Program omogućava generisanje i rešavanje Sudoku tabli različitih težina, kao i interakciju korisnika putem komandne linije.

Projekat je rađen u programskom jeziku C++.

## Osnovne informacije o analizi

[GitHub repozitorijum projekta](https://github.com/AlexIzydorczyk/sudoku/tree/master)   
Commit SHA: `c29608afb36bdde499b468d271a9f82cf4b53eec`

Sama analiza biće izvršena nad master granom.

U analizi su korišćeni sledeći alati:

    Alati za statičku analizu:
        -Clang-Format
        -Cppcheck
    Alati za dinamičku analizu (Valgrind):
        -Callgrind
        -Cachegrind
        -Lcov

Detaljniji opis svakog alata nalazi se u dokumentu ProjectAnalysisReport.md.

## Uputstvo za reprodukciju analize

Alati će biti pokrenuti iz terminala koristeći unapred pripremljene skripte.
Postupak pokretanja alata može se naći u README.md fajlovima u okviru foldera posvećenog svakom korišćenom alatu.

## Zaključci

Detaljniji opis zaključaka nakon analize svakim od alata kao i sveukupan zaključak mogu se naći u dokumentu ProjectAnalysisReport.md.

