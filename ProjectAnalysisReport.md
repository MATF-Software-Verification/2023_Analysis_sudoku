# Izveštaj sprovedene analize

Korišćeni alati:
- [Clang-format](#clang-format)
- [Cppcheck](#cppcheck)
- [Valgrind alati](#valgrind)
    - [Cachegrind](#cachegrind)
    - [Callgrind](#callgrind)
- [Lcov](#lcov)


## Clang-format
**Clang-format** je alat koji automatski formatira izvorni kod C, C++ i srodnih jezika prema zadatim stilskim pravilima (style guides).   
Njegova primarna svrha nije analiza funkcionalnosti, nego osiguranje konzistentnog i čitljivog koda, što indirektno pomaže u verifikaciji softvera jer olakšava pregled i smanjuje mogućnost grešaka u čitanju ili održavanju koda.

###  Rezultati primene na projekat
**1. Uniformnost i preglednost koda**
- Clang-format je automatski izjednačio stil indentacije, razmake oko operatora i razmake između komentara i koda. Kod sada ima konzistentan raspored što olakšava čitanje i održavanje.

**2. Redosled include fajlova**
- Primetno je da je alat promenio redosled #include direktiva, prvo stavljajući standardne biblioteke (\<iostream\>, \<regex\>, \<sstream\>), a zatim lokalne fajlove ("solver.hpp", "altproj.hpp", "game.hpp", "tests.hpp"). Ovo je u skladu sa preporučenim praksama i olakšava vizuelnu organizaciju fajlova.

**3. Smanjenje vizuelne buke**
- Duži if uslovi i blokovi su sada razbijeni i lepo poravnati, što smanjuje rizik od grešaka i olakšava brzo skeniranje koda prilikom debugovanja ili verifikacije.

**4. Standardizacija komentara i razmaka**
- Razmak između komentara i koda je sada konzistentan (// comment), što doprinosi profesionalnijem i čitljivijem izgledu projekta.
   
**5. Nema promene logike**
- Važno je istaći da clang-format ne menja funkcionalnost koda, samo stil. Kod radi identično kao pre, ali je sada stilistički uniforman, što je posebno korisno kada se radi verifikacija softvera ili kada više developera radi na istom projektu.

![Clang-Format_AfterBefore.png](clang-format/Clang-Format_AfterBefore.png)

### Zaključak
Iako je deo koda već dobro organizovan, veći deo fajlova još uvek nije uniforman i stil nije konzistentan. Primena `clang-format` na ceo projekat će značajno poboljšati preglednost, olakšati održavanje i smanjiti mogućnost grešaka prilikom verifikacije softvera. Ovo je posebno važno kada više developera radi na istom projektu ili kada se priprema kod za dalju analizu i testiranje.

## Cppcheck

Cppcheck je statički analizator koda za C i C++ koji pronalazi greške u kodu, potencijalne bugove i sigurnosne probleme **bez pokretanja programa**. Za razliku od kompajlera, Cppcheck se fokusira na **logičke i stilističke greške**, uključujući nedefinisano ponašanje, curenje memorije i lošu praksu kodiranja.

### Rezultati primene na projekat

![Cppcheck_report.png](cppcheck/Cppcheck_report.png)

**1. Variable 'method' is assigned a value that is never used**
- Promenljiva `method` dobija vrednost koja se nigde dalje ne koristi.  
- Ova situacija može ukazivati na nepotreban kod ili grešku u logici, pa je preporučljivo ukloniti ili koristiti promenljivu.

**2. Local variable 'solve' shadows outer function**
- Lokalna promenljiva `solve` ima isto ime kao spoljašnja funkcija ili promenljiva u višem opsegu.  
- To može dovesti do zabune i neočekivanih rezultata, preporučuje se da se promeni ime lokalne promenljive.

**3. Variable 'val' is assigned a value that is never used**
- Promenljiva `val` dobija vrednost koja se nikada ne koristi.  
- Ovaj problem je indikator mrtvog koda koji može biti uklonjen ili revidiran.

**4. The scope of the variable 'x' can be reduced**
- Promenljiva `x` je definisana u širem opsegu nego što je potrebno.  
- Preporučuje se da se njen opseg smanji na minimum kako bi kod bio čitljiviji i smanjio mogućnost grešaka.

**5. Class 'Board' has a constructor with 1 argument that is not explicit**  
- Konstruktor klase `Board` sa jednim argumentom nije označen kao `explicit`.  
- To može dovesti do implicitnih konverzija i neočekivanog ponašanja.  
- Rešenje: dodati `explicit` ispred konstruktora:

**6. Class 'Board' does not have a copy constructor which is recommended since it has dynamic memory/resource allocation(s)**  
- Klasa `Board` koristi dinamičku memoriju ili resurse, ali nema definisan copy constructor.  
- Bez copy konstruktora kopiranje objekata može dovesti do **deep copy** problema ili curenja memorije.  
- Rešenje: implementirati copy constructor i, po potrebi, operator dodele (`operator=`).

### Zaključak     
Analiza pomoću Cppcheck-a nam je omogućila da identifikujemo **mrtvi kod, potencijalne greške u logici, problematične opsege promenljivih i rizike vezane za upravljanje memorijom**. Popravljanje ovih problema povećava kvalitet i stabilnost koda i smanjuje rizik od runtime grešaka.

## Valgrind
Valgrind je alat za **dinamičku analizu** C i C++ programa koji pomaže u otkrivanju grešaka u memoriji, curenja memorije i drugih runtime problema. Za razliku od statičkih analizatora kao što je Cppcheck, Valgrind **pokreće program** i prati njegovo ponašanje u stvarnom vremenu.

**Kako pomaže u verifikaciji softvera:**

**1. Detekcija curenja memorije (Memory Leaks)**  
- Prati sve alokacije i dealokacije memorije i upozorava na zaboravljene `delete` ili `free` pozive.

**2. Detekcija neinicijalizovane memorije**
- Pronalazi korišćenje promenljivih ili blokova memorije pre nego što su inicijalizovani.

**3. Detekcija pristupa nevažećim adresama**  
- Prati pokazivače i upozorava na out-of-bounds pristup ili dereferenciranje slobodnih memorijskih lokacija.

**4. Poboljšanje stabilnosti i sigurnosti**  
- Eliminisanjem runtime grešaka i curenja memorije, program postaje stabilniji i sigurniji za upotrebu.

## Cachegrind 
Cachegrind je alat za profilisanje performansi C/C++ programa, deo Valgrind paketa. On meri koliko CPU instrukcija i memorijskih pristupa se izvršava tokom rada programa, kao i koliko puta dođe do promašaja keša (cache misses). Ovi podaci pomažu da se identifikuju kritične tačke u programu gde dolazi do usporenja zbog neefikasnog pristupa memoriji ili prekomerne rekurzije.

###  Rezultati primene na projekat

![cachegrind_kcachegrind.png](/valgrind/cachegrind/cachegrind_kcachegrind.png)
**1. Visok broj instrukcionih promašaja i memorijskih pristupa**
- Funkcije `Board::operator()(int, int)` i `feasible(Board&, int, int, int)` imaju veliki broj pristupa memoriji. Svaka provera ili pristup elementu table generiše višestruke memorijske operacije, posebno u rekurzivnom pretraživanju svih mogućnosti.  

**2. STL funkcije i rad sa stringovima/vektorima**
- Funkcije poput `std::vector<char>::data()`, `_M_range_initialize` i `_M_append` takođe generišu mnogo promašaja. Često se kreiraju privremeni objekti ili proširuju kapaciteti, što izaziva nepredvidive pristupe memoriji.  

**3. Standardne C funkcije i sistemske operacije**
- Funkcije iz `glibc` kao što su `_dl_lookup_symbol_x`, `do_lookup_x` i `malloc`/`free` su takođe značajno korišćene. Dinamička alokacija i dealokacija memorije tokom rekurzije i kreiranja STL objekata povećava broj memorijskih pristupa.  

**4. Matematičke funkcije (`pow`, `sqrt`)**
- Intenzivna upotreba ovih funkcija u petljama doprinosi ukupnom opterećenju CPU-a i keša.  

**5. Slaba lokalnost podataka**
- Pristup tablici i STL vektorima je nelinearan, što smanjuje efikasnost L1/L2 keša. CPU mora da čeka dok se podaci učitaju iz spoljnih nivoa memorije, što dodatno usporava izvršavanje.

### Zaključak

Analiza pokazuje da su glavni problemi Sudoku solver-a vezani za **Rekurzivni pristup i intenzivnu proveru svih mogućnosti**, što dovodi do velikog broja memorijskih promašaja, **Intenzivno korišćenje STL funkcija** i privremenih objekata, što povećava broj alokacija i neefikasno koristi keš,**Slabu lokalnost podataka** pri pristupu tablici i vektorima, **Korišćenje standardnih matematičkih i sistemskih funkcija** u kritičnim petljama.

## Callgrind
Callgrind je alat iz skupa Valgrind alata namenjen **profilisanju programa**, odnosno merenju performansi kroz broj izvršenih instrukcija, poziva funkcija i pristupa memoriji. Koristi se za **analizu efikasnosti koda** i identifikaciju delova koji najviše troše resurse. Rezultati se obično pregledaju u **KCachegrind** interfejsu, koji omogućava vizuelni prikaz poziva funkcija i njihovog učešća u ukupnom izvršavanju programa.

###  Rezultati primene na projekat

![callgrind_kcachegrind.png](/valgrind/callgrind/callgrind_kcachegrind.png)
**1. Analiza dobijenih rezultata**  
- Funkcija `main()` zauzima **57.23% ukupnih instrukcija**, što znači da se u njoj odvija značajan deo izvršavanja logike programa.  
- Unutar `main()` funkcije, najveći deo instrukcija odlazi na poziv funkcije `playGame(int, int)` iz fajla `game.cpp`, sa čak **56.83% instrukcija**.  
- Ostale funkcije poput `solve(Board&, int, int)` i `generatePuzzle(int, int)` takođe doprinose ukupnom broju instrukcija, ali u manjoj meri.  
- Veći deo vremena program provodi u **petljama i rekurzivnim pozivima** unutar funkcija koje sadrže algoritme za rešavanje Sudoku igre (`solver.cpp`, `game.cpp`).  
- Uključene su i sistemske funkcije (`_start`, `__libc_start_call_main`, `ld`, `libstdc++`), koje se ne analiziraju direktno, ali čine osnovu izvršnog okruženja.

**2. Tumačenje metrika**  
- **Incl (Inclusive)** prikazuje ukupan procenat instrukcija koji uključuje i sve funkcije koje se pozivaju iz te funkcije.  
- **Self** označava procenat instrukcija izvršenih isključivo u toj funkciji.  
- **Ir (Instruction Read)** pokazuje koliko je instrukcija pročitano tokom izvršavanja.  
- Korišćenjem ovih metrika moguće je identifikovati **uska grla (bottlenecks)** u kodu, delove koji najviše troše resurse i najviše utiču na performanse.

## Zaključak

Na osnovu analize u Callgrind alatu, uočeno je da se najveći deo vremena izvršavanja troši u funkciji `playGame(int, int)`, što ukazuje da se tu nalaze najintenzivniji delovi logike igre. Ovi podaci pomažu da se optimizuje kod identifikovanjem funkcija koje najviše opterećuju procesor i usporavaju rad programa.


## Lcov
LCOV je alat za merenje i vizualizaciju pokrivenosti koda (code coverage) u C i C++ projektima. Koristi se u kombinaciji sa GCC instrumentacijom `--coverage flag` i `gcov` fajlovima, kako bi se prikazalo koji delovi koda su izvršeni tokom testiranja.

###  Rezultati primene na projekat

**1. Ukupna pokrivenost koda**  
- Rezultati LCOV analize pokazuju da je prosečna **pokrivenost linija koda 54.5%**, dok je **pokrivenost funkcija 63.3%** u okviru Sudoku projekta.  
- Na nivou celog projekta (uključujući biblioteke), ukupna pokrivenost linija je **43.8%**, a funkcija **44.5%**.  
- Ovi rezultati ukazuju da je značajan deo logike obuhvaćen testovima, ali da postoji prostor za poboljšanje, naročito u delovima koda koji se ređe izvršavaju tokom testiranja.
![Full-coverage.png](/lcov/full_coverage.png)

**2. Pokrivenost po fajlovima**  
- `solver.cpp` pokazuje **najveći stepen pokrivenosti** (83.2% linija, 88.9% funkcija), što znači da su testovi najviše fokusirani na deo koda zadužen za rešavanje Sudoku problema.  
- `game.cpp` ima **solidnu pokrivenost (69.8%)**, što sugeriše da su osnovne funkcionalnosti igre testirane, ali ne i sve grane logike.  
- `main.cpp`, `altproj.cpp` i `tests.cpp` imaju **niske vrednosti pokrivenosti (0–28%)**, što ukazuje da deo koda za inicijalizaciju i test harness nije bio obuhvaćen aktivnim testovima.  
- Header fajlovi (`.hpp`) logično nemaju direktnu pokrivenost, jer sadrže deklaracije, ali njihova funkcionalnost se meri indirektno kroz implementacije u `.cpp` fajlovima.
![Sudoku-coverage.png](/lcov/sudoku_coverage.png)

**3. Analiza po direktorijumima**  
- U poređenju direktorijuma, samo projektni folder (`/sudoku`) ima značajnu pokrivenost, dok sistemski direktorijumi (`armadillo_bits`, `c++/9/bits`, itd.) imaju veoma nisku pokrivenost (<10%), što je očekivano jer predstavljaju biblioteke standardne implementacije, a ne deo projekta.

**4. Vizuelni pregled i interpretacija boja**  
- **Zelena** boja označava potpuno pokrivene delove koda.  
- **Žuta** označava delimičnu pokrivenost.  
- **Crvena** pokazuje delove koda koji nisu pokriveni testovima.  
Većina fajlova sadrži kombinaciju žutih i crvenih delova, što vizuelno potvrđuje da testovi još nisu sveobuhvatni.

### Zaključak
Analiza LCOV alata pokazuje da su testovi projekta ostvarili solidan nivo pokrivenosti, ali da postoji prostor za dalji napredak. Najbolje rezultate postižu fajlovi koji sadrže ključnu logiku, poput `solver.cpp`, dok su delovi odgovorni za ulazno-izlazne operacije i kontrolu toka igre slabije obuhvaćeni testovima. Ovakav rezultat ukazuje na potrebu za proširenjem test skupa, naročito u oblastima koje obuhvataju rubne slučajeve i alternativne grane izvršavanja koda.  
