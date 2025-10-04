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
- *Uniformnost i preglednost koda*  
clang-format je automatski izjednačio stil indentacije, razmake oko operatora i razmake između komentara i koda. Kod sada ima konzistentan raspored što olakšava čitanje i održavanje.

- *Redosled include fajlova*  
Primetno je da je alat promenio redosled #include direktiva, prvo stavljajući standardne biblioteke (\<iostream\>, \<regex\>, \<sstream\>), a zatim lokalne fajlove ("solver.hpp", "altproj.hpp", "game.hpp", "tests.hpp"). Ovo je u skladu sa preporučenim praksama i olakšava vizuelnu organizaciju fajlova.

- *Smanjenje vizuelne buke*  
Duži if uslovi i blokovi su sada razbijeni i lepo poravnati, što smanjuje rizik od grešaka i olakšava brzo skeniranje koda prilikom debugovanja ili verifikacije.

- *Standardizacija komentara i razmaka*  
Razmak između komentara i koda je sada konzistentan (// comment), što doprinosi profesionalnijem i čitljivijem izgledu projekta.

- *Nema promene logike*  
Važno je istaći da clang-format ne menja funkcionalnost koda, samo stil. Kod radi identično kao pre, ali je sada stilistički uniforman, što je posebno korisno kada se radi verifikacija softvera ili kada više developera radi na istom projektu.

![Clang-Format_AfterBefore.png](clang-format/Clang-Format_AfterBefore.png)

### Zaključak
Iako je deo koda već dobro organizovan, veći deo fajlova još uvek nije uniforman i stil nije konzistentan. Primena `clang-format` na ceo projekat će značajno poboljšati preglednost, olakšati održavanje i smanjiti mogućnost grešaka prilikom verifikacije softvera. Ovo je posebno važno kada više developera radi na istom projektu ili kada se priprema kod za dalju analizu i testiranje.

## Cppcheck

## Valgrind

## Cachegrind 

## Callgrind

## Lcov
