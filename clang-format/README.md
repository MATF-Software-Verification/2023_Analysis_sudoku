# Clang-Format

U ovom direktorijumu nalazi se uputstvo i skripte za pokretanje clang-format nad projektom Sudoku.  
Clang-Format automatski formatira C/C++ kod prema definisanom stilu, sto pomaže u odrzavanju konzistentnog i preglednog koda.

Vise informacija o alatu i detaljima analize mozete naci u [ProjectAnalysisReport.md](../ProjectAnalysisReport.md).

## Preduslovi

Na Ubuntu/Linux mašini je potrebno imati instaliran clang-format:

sudo apt update
sudo apt install clang-format

Opcionalno: u root direktorijumu projekta možete dodati `.clang-format` fajl da definišete stil formatiranja. Primer:

BasedOnStyle: LLVM  
IndentWidth: 4  
ColumnLimit: 100  
BreakBeforeBraces: Allman

## Pokretanje

Skripta `clang-format.sh` omogucava interaktivno formatiranje fajlova projekta Sudoku.

Pre pokretanja, podesite prava pristupa:

chmod +x clang-format.sh

### 1.Izbor fajlova i formatiranje

Pokretanjem skripte:

./clang-format.sh

- Skripta ispisuje listu svih `.cpp`, `.hpp`, `.h` i `.c` fajlova u `../sudoku`.
- Korisnik bira fajl(ove) za formatiranje:
  - jedan broj (npr. 2)
  - više brojeva razdvojeno razmakom (npr. 1 3 5)
  - ili `all` za sve fajlove
- Skripta prikazuje diff između originalnog i formatiranog fajla.
- Nakon prikaza, fajl se formatira u mestu (in-place).

### 2.Primer korišćenja

- Formatiranje jednog fajla: 2  
- Formatiranje više fajlova: 1 3 5  
- Formatiranje svih fajlova: all

### 3.Rezultati

- Originalni fajlovi u `../sudoku` biće formatirani prema stilu definisanom u `.clang-format` ili po default stilu.
- Diff prikazuje promene pre nego što se primene, tako da možete videti razlike.
- Ovim procesom kod postaje konzistentan i pregledan, sto olakšava dalji razvoj i analizu.

