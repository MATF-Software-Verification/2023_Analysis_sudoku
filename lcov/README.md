# LCOV

U ovom direktorijumu nalazi se uputstvo i skripte za pokretanje LCOV alata nad projektom Sudoku.  
LCOV omogućava merenje pokrivenosti koda testovima (code coverage) i generisanje HTML izveštaja koji prikazuju koje linije, funkcije i grane su izvršene tokom testiranja.  
Više informacija o alatu i detaljima analize možete naći u [ProjectAnalysisReport.md](../ProjectAnalysisReport.md).

## Preduslovi

Na Ubuntu/Linux mašini potrebno je imati instalirane sledeće alate:

```bash
sudo apt update
sudo apt install lcov
```

Projekat Sudoku treba da se kompajlira sa uključenim opcijama za merenje pokrivenosti:

```text
-fprofile-arcs -ftest-coverage -O0 -g
```

## Pokretanje

Skripte u ovom direktorijumu omogućavaju sledeće korake:

### 1. Čišćenje prethodnih podataka o pokrivenosti

Pokretanjem skripte `lcov_clean.sh` se brise `/coverage_html` folder, `coverage.info` fajl, i svi `.gcno` fajlovi i resetuju svi brojači u `.gcda` fajlovima (brojači izvršenja). 

### 2. Opcionalno filtriranje fajlova

Možete izuzeti fajlove koje ne želite u izveštaju, npr:

```bash
lcov --remove coverage.info '*/tests.cpp' '*/main.cpp' -o coverage_filtered.info
```

### 3. Upotreba skripti

U ovom direktorijumu nalaze se sledece skripte:

- `build_with_coverage.sh` – kompajlira Sudoku projekat sa opcijama za pokrivenost i pokrece testove 
- `collect_and_generate_report.sh` – prikuplja podatke u `coverage.info` i generise coverage_html folder

Pre pokretanja skripti, postavite dozvole:

```bash
chmod +x scripts/*.sh
```

Redosled pokretanja:

```bash
./scripts/build_with_coverage.sh
./scripts/collect_and_generate_report.sh
```

## Rezultati

- `coverage.info` – sirovi podaci o pokrivenosti  
- `coverage_html/` – direktorijum sa HTML izveštajem  

Pregledom `index.html` možete videti pokrivenost po fajlovima i linijama, identifikovati neispunjene delove koda i poboljšati testove.
