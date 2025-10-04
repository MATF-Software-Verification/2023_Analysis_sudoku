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

### Efekti primene na projekat
1. **Uniformnost i preglednost koda**  
   - clang-format je automatski izjednačio stil indentacije, razmake oko operatora i razmake između komentara i koda. Kod sada ima konzistentan raspored što olakšava čitanje i održavanje.

2. **Redosled include fajlova**  
   - Primetno je da je alat promenio redosled #include direktiva, prvo stavljajući standardne biblioteke (\<iostream\>, \<regex\>, \<sstream\>), a zatim lokalne fajlove ("solver.hpp", "altproj.hpp", "game.hpp", "tests.hpp"). Ovo je u skladu sa preporučenim praksama i olakšava vizuelnu organizaciju fajlova.

3. **Smanjenje vizuelne buke**  
   - Duži if uslovi i blokovi su sada razbijeni i lepo poravnati, što smanjuje rizik od grešaka i olakšava brzo skeniranje koda prilikom debugovanja ili verifikacije.

4. **Standardizacija komentara i razmaka**  
   - Razmak između komentara i koda je sada konzistentan (// comment), što doprinosi profesionalnijem i čitljivijem izgledu projekta.

5. **Nema promene logike**  
   - Važno je istaći da clang-format ne menja funkcionalnost koda, samo stil. Kod radi identično kao pre, ali je sada stilistički uniforman, što je posebno korisno kada se radi verifikacija softvera ili kada više developera radi na istom projektu.

![Clang-Format_AfterBefore.png](clang-format/Clang-Format_AfterBefore.png)

### Zaključak
Iako je deo koda već dobro organizovan, veći deo fajlova još uvek nije uniforman i stil nije konzistentan. Primena `clang-format` na ceo projekat će značajno poboljšati preglednost, olakšati održavanje i smanjiti mogućnost grešaka prilikom verifikacije softvera. Ovo je posebno važno kada više developera radi na istom projektu ili kada se priprema kod za dalju analizu i testiranje.

## Cppcheck

Cppcheck je statički analizator koda za C i C++ koji pronalazi greške u kodu, potencijalne bugove i sigurnosne probleme **bez pokretanja programa**. Za razliku od kompajlera, Cppcheck se fokusira na **logičke i stilističke greške**, uključujući nedefinisano ponašanje, curenje memorije i lošu praksu kodiranja.

### Efekti primene na projekat

![Cppcheck_report.png](cppcheck/Cppcheck_report.png)

1. **Variable 'method' is assigned a value that is never used**  
   - Promenljiva `method` dobija vrednost koja se nigde dalje ne koristi.  
   - Ova situacija može ukazivati na nepotreban kod ili grešku u logici, pa je preporučljivo ukloniti ili koristiti promenljivu.

2. **Local variable 'solve' shadows outer function**  
   - Lokalna promenljiva `solve` ima isto ime kao spoljašnja funkcija ili promenljiva u višem opsegu.  
   - To može dovesti do zabune i neočekivanih rezultata, preporučuje se da se promeni ime lokalne promenljive.

3. **Variable 'val' is assigned a value that is never used**  
   - Promenljiva `val` dobija vrednost koja se nikada ne koristi.  
   - Ovaj problem je indikator mrtvog koda koji može biti uklonjen ili revidiran.

4. **The scope of the variable 'x' can be reduced**  
   - Promenljiva `x` je definisana u širem opsegu nego što je potrebno.  
   - Preporučuje se da se njen opseg smanji na minimum kako bi kod bio čitljiviji i smanjio mogućnost grešaka.

5. **Class 'Board' has a constructor with 1 argument that is not explicit**  
   - Konstruktor klase `Board` sa jednim argumentom nije označen kao `explicit`.  
   - To može dovesti do implicitnih konverzija i neočekivanog ponašanja.  
   - Rešenje: dodati `explicit` ispred konstruktora:

6. **Class 'Board' does not have a copy constructor which is recommended since it has dynamic memory/resource allocation(s)**  
   - Klasa `Board` koristi dinamičku memoriju ili resurse, ali nema definisan copy constructor.  
   - Bez copy konstruktora kopiranje objekata može dovesti do **deep copy** problema ili curenja memorije.  
   - Rešenje: implementirati copy constructor i, po potrebi, operator dodele (`operator=`).

### Zakljucak     
Analiza pomoću Cppcheck-a nam je omogućila da identifikujemo **mrtvi kod, potencijalne greške u logici, problematične opsege promenljivih i rizike vezane za upravljanje memorijom**. Popravljanje ovih problema povećava kvalitet i stabilnost koda i smanjuje rizik od runtime grešaka.

## Valgrind

## Cachegrind 

## Callgrind

## Lcov
