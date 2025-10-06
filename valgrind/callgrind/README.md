# Callgrind profajler

U ovom direktorijumu nalazi se uputstvo i skripte za pokretanje **Callgrind** profajliranja projekta *Sudoku*.  
Više detalja o samom profajleru, kao i analizi rezultata, možete pronaći u dokumentu [ProjectAnalysisReport.md](../../ProjectAnalysisReport.md).

## Preduslovi

Za profajliranje je potrebno da na mašini imate instalirane sledeće alate:

sudo apt-get install valgrind  
sudo apt-get install kcachegrind

## Pokretanje

Nakon kloniranja repozitorijuma, potrebno je pozicionirati se u folder `/valgrind/callgrind`.  
Pre pokretanja skripti, obavezno podesite prava pristupa:

cd valgrind   
cd callgrind  
chmod +x build.sh  
chmod +x callgrind.sh

### 1. Izgradnja projekta

Skripta `build.sh` kompajlira projekat i priprema izvršni fajl Sudoku igre:

./build.sh

### 2. Profajliranje

Skripta `callgrind.sh` pokreće profajliranje nad Sudoku izvršnom datotekom.  
Opcije:

- `-a` → pokreće `callgrind_annotate` i generiše čitljiviji tekstualni izveštaj.  
- `-k` → otvara rezultate u KCachegrind grafičkom interfejsu.

Primer pokretanja:

./callgrind.sh -a -k

### 3. Rezultati

Rezultati profajliranja biće sačuvani u `.out` fajlovima u istom direktorijumu.  
Ako koristite `-a`, dobićete anotirani izveštaj u tekstualnom obliku preko `callgrind_annotate`.  
Ako koristite `-k`, otvoriće se KCachegrind GUI za vizuelnu analizu.

### 4. Cleanup

Kada ste zavrsili sa analizom projekta pokrenite:

./build.sh clean

Ako želite da obrišete prethodne izveštaje:

```bash
rm *.out
```