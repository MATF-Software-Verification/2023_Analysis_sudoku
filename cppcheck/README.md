# Cppcheck statička analiza

U ovom direktorijumu nalazi se uputstvo i skripta za pokretanje **Cppcheck** statičke analize projekta *Sudoku*.  
Više detalja o analizi koda i interpretaciji rezultata možete pronaći u dokumentu [ProjectAnalysisReport.md](../ProjectAnalysisReport.md).

## Preduslovi

Za pokretanje analize je potrebno da na mašini imate instaliran **cppcheck** i **cppcheck-htmlreport** (za HTML izveštaje):

```bash
sudo apt-get install cppcheck
sudo apt-get install cppcheck-htmlreport
```

Preporučuje se i da imate instaliran **Firefox** ako želite da se HTML izveštaj automatski otvara.


## Pokretanje

Nakon kloniranja repozitorijuma, potrebno je pozicionirati se u folder `/cppcheck`.  
Pre pokretanja skripti, obavezno podesite prava pristupa:

```bash
cd cppcheck
chmod +x cppcheck.sh
```

### 1. Tekstualni izveštaj

Pokretanje analize i generisanje tekstualnog izveštaja:

```bash
./cppcheck.sh
```

- Generiše fajl `cppcheck_<timestamp>.txt`  
- Izveštaj se nalazi u istom direktorijumu gde je skripta pokrenuta  

### 2. HTML izveštaj

Pokretanje analize sa HTML izveštajem:

```bash
./cppcheck.sh -html
```

- Kreira folder `html-report`  
- Generiše fajl `index.html` u `html-report` folderu  
- Automatski otvara izveštaj u Firefox-u  

### 3. Rezultati

- Tekstualni izveštaj (`.txt`) sadrži sve poruke i upozorenja pronađene od strane Cppcheck-a  
- HTML izveštaj (`index.html`) je pregledniji i formatiran za lakšu analizu  
- Oba izveštaja se čuvaju lokalno i mogu se arhivirati ili deliti  

### 4. Cleanup

Ako želite da obrišete prethodne izveštaje:

```bash
rm cppcheck_*.txt
rm cppcheck_*.xml
rm -r html-report
```
