# MVP Roadmap - Poczatkowa Wyspa

Data utworzenia: 2026-06-06

Ten plik opisuje MVP ograniczone wylacznie do poczatkowej wyspy. Wszystkie
ponizsze kroki traktuja gameplay startowej wyspy jako osobny, swiadomie
zaprojektowany fundament.

Systemy po poczatkowej wyspie, dlugoterminowa ekonomia i pozniejsze petle
progresji sa poza zakresem tego MVP. Do tych tematow wracamy dopiero po
domknieciu poczatkowej wyspy.

## Jak Uzywac Tej Checklisty Z Goals

Kazdy checkbox jest kandydatem na osobny goal. Jesli punkt jest bardzo maly,
mozna polaczyc go z sasiednim punktem z tej samej fazy, ale domyslnie jeden
checkbox powinien oznaczac jedna zamykalna prace.

Minimalny wzor goalu:

```text
Goal: [I2.04] Dodac pierwsze zadanie zbierania drewna na poczatkowej wyspie.

Done when:
- Mentor albo objective tracker wskazuje zadanie.
- Gracz moze wykonac zadanie solo.
- Nagroda jest przyznawana tylko raz.
- Output log nie pokazuje bledow runtime.
```

Zasady pracy:

1. Wybieramy najwczesniejszy nieukonczony punkt, ktory odblokowuje kolejne.
2. Zakres goalu nie wychodzi poza poczatkowa wyspe.
3. Kod gameplay zmieniamy w plikach zarzadzanych przez Rojo.
4. Studio sluzy do mapy, modeli, pozycji, promptow, efektow, dzwiekow i testow.
5. Goal jest skonczony dopiero po spelnieniu kryteriow `Done`.

## Definicja MVP

MVP poczatkowej wyspy ma udowodnic pierwsze 20-30 minut gry:

> Nowy gracz pojawia sie na wspolnej poczatkowej wyspie, poznaje mentora,
> wykonuje kilka krotkich zadan, zbiera podstawowe surowce, pomaga uruchomic
> lokalny tartak, dostaje pierwsze planki, probuje kilka sciezek aktywnosci i
> konczy etap decyzja o przyszlym stylu gry.

Koniec MVP to gotowosc gracza do opuszczenia poczatkowej wyspy w przyszlej
wersji, bez uruchamiania dalszych systemow progresji.

## Granice MVP

MVP obejmuje:

- Poczatkowa wyspe jako zamknieta, grywalna lokacje.
- Arrival flow dla nowego gracza.
- Mentor NPC.
- Proste zadania osobiste.
- Shared worksite, ktory reaguje na wklad graczy.
- Starter forest.
- Loose stone area.
- Loose ore albo mineral sample area jako zapowiedz gornictwa.
- Shared sawmill jako pierwszy moment przetwarzania.
- Job board albo objective board.
- Nagrody co 1-3 minuty.
- Minimalny HUD zasobow i celow.
- Zapis postepu na poczatkowej wyspie.
- Pelna grywalnosc solo.
- Czytelna obecnosc innych graczy bez wymuszonej kooperacji.

MVP nie obejmuje:

- Systemow progresji po poczatkowej wyspie.
- Systemow konstrukcyjnych poza wspolnymi obiektami startowej wyspy.
- Produkcji poza wspolnym tartakiem startowej wyspy.
- Handlu miedzy graczami.
- Dlugoterminowej tozsamosci producenta.
- Kontraktow i zamowien.
- Offline workers.
- Dlugoterminowego balansu ekonomii.
- Endgame.
- Monetyzacji.

## Must Have

- Nowy gracz wie w ciagu 10 sekund, gdzie ma isc.
- Pierwsza interakcja jest dostepna bez szukania UI.
- Pierwsza nagroda pojawia sie w mniej niz 60 sekund.
- Pierwsze 10 minut zawiera co najmniej 4 reward moments.
- Gracz moze zbierac drewno.
- Gracz moze zbierac kamien.
- Gracz moze zobaczyc zapowiedz gornictwa przez loose ore/mineral samples.
- Gracz moze pomoc w shared worksite.
- Gracz moze uruchomic albo wspoluruchomic shared sawmill.
- Gracz dostaje planki przed koncem MVP.
- Gracz probuje co najmniej 3 role: logging, mining, carpentry/worksite.
- Gracz moze przejsc calosc solo na pustym serwerze.
- Wielu graczy moze robic zadania obok siebie bez kradziezy postepu.
- Postep milestone'ow zapisuje sie miedzy sesjami.
- Koniec MVP daje jasny sygnal: "jestes gotowy na kolejny etap", ale nie
      uruchamia jeszcze kolejnego etapu.

## Nice To Have

- Krotkie komentarze NPC reagujace na postep gracza.
- Widoczna zmiana worksite po ukonczeniu etapow.
- Prosty wybor przyszlego stylu gry na koniec wyspy.
- Lokalny tytul albo odznaka za ukonczenie wyspy.
- Mini tablica pokazujaca wklad wszystkich graczy online.
- Efekt dzwiekowy i wizualny przy uruchomieniu tartaku.
- Powtarzalne drobne zadania po ukonczeniu glownego flow.

## Definition Of Done Dla Kazdego Kroku

- Zakres kroku dotyczy tylko poczatkowej wyspy.
- Gracz moze ukonczyc krok solo.
- Inny gracz nie moze zabrac nagrody ani zablokowac postepu.
- Serwer przyznaje zasoby, nagrody i milestone'y.
- Klient wysyla tylko intencje.
- UI/feedback mowi graczowi, co sie stalo.
- Reconnect nie psuje aktualnego milestone'u.
- Output log nie pokazuje nowych bledow runtime.
- Kryteria `Done` konkretnego punktu sa spelnione.

## I0 - Decyzje Zakresu I Dokument Bazowy

Cel fazy: zamknac scope poczatkowej wyspy, zanim powstanie wiecej systemow.

- [ ] `I0.01` Zapisac jednozdaniowy cel poczatkowej wyspy.
      Done: cel jasno mowi, czego gracz ma doswiadczyc w pierwszych 20-30
      minutach.

- [ ] `I0.02` Zapisac warunek konca MVP.
      Done: wiadomo, jaki ekran, dialog albo milestone oznacza ukonczenie
      poczatkowej wyspy.

- [ ] `I0.03` Zapisac, ze dalsze systemy progresji sa post-MVP.
      Done: roadmapa nie ma zadan wymagajacych wyjscia poza poczatkowa wyspe.

- [ ] `I0.04` Ustalic docelowy czas przejscia wyspy.
      Done: przyjeta wartosc, np. 20-30 minut, jest zapisana jako cel balansu.

- [ ] `I0.05` Ustalic liste zasobow MVP.
      Minimum: `Wood`, `Stone`, `Planks`, `SettlementTokens`.
      Done: wiadomo, ktore zasoby sa realne, a ktore sa tylko zapowiedzia.

- [ ] `I0.06` Ustalic liste aktywnosci MVP.
      Minimum: rozmowa z mentorem, zbieranie drewna, zbieranie kamienia, worksite
      contribution, shared sawmill.
      Done: kazda aktywnosc ma role w onboardingu.

- [ ] `I0.07` Ustalic slownik nazw.
      Done: te same nazwy sa uzywane w UI, danych i dokumentach.

- [ ] `I0.08` Ustalic, czy koniec wyspy daje wybor przyszlego stylu gry.
      Done: decyzja jest jawna: wybor jest w MVP albo odlozony.

## I1 - Mapa Poczatkowej Wyspy

Cel fazy: stworzyc czytelna, mala przestrzen, w ktorej gracz nie bladzi.

- [ ] `I1.01` Zaprojektowac layout wyspy na papierze albo w dokumencie.
      Done: mapa ma spawn, mentora, starter forest, stone area, worksite, sawmill
      i job board.

- [ ] `I1.02` Ustalic sciezke gracza przez wyspe.
      Done: gracz naturalnie widzi kolejne punkty bez potrzeby mapy.

- [ ] `I1.03` Przygotowac spawn point.
      Done: gracz pojawia sie twarza w strone mentora albo pierwszego landmarku.

- [ ] `I1.04` Przygotowac mentor area.
      Done: mentor jest widoczny od razu po spawnie.

- [ ] `I1.05` Przygotowac starter forest.
      Done: drzewa sa blisko startu i wystarczaja dla kilku graczy.

- [ ] `I1.06` Przygotowac loose stone area.
      Done: kamienie sa wizualnie inne niz drzewa i latwe do znalezienia.

- [ ] `I1.07` Przygotowac mineral sample area.
      Done: gracz widzi zapowiedz przyszlego mining bez pelnego systemu kopalni.

- [ ] `I1.08` Przygotowac shared worksite.
      Done: miejsce wyglada jak cos, co gracze wspolnie naprawiaja/buduja.

- [ ] `I1.09` Przygotowac shared sawmill.
      Done: tartak jest widoczny jako wazny obiekt wyspy.

- [ ] `I1.10` Przygotowac job board albo objective board.
      Done: tablica ma czytelna pozycje i nie konkuruje z mentorem.

- [ ] `I1.11` Dodac landmark konca wyspy.
      Done: istnieje miejsce rytualu/odprawy/podsumowania, ale nie prowadzi
      jeszcze poza zakres MVP.

- [ ] `I1.12` Dodac bariery lub naturalne granice wyspy.
      Done: gracz rozumie, ze MVP dzieje sie na tej jednej wyspie.

- [ ] `I1.13` Test czytelnosci mapy.
      Done: tester po spawnie znajduje mentora i pierwsza aktywnosc bez instrukcji
      poza gra.

## I2 - Arrival I Mentor

Cel fazy: pierwsza minuta ma byc jasna, szybka i nagradzajaca.

- [ ] `I2.01` Zdefiniowac role mentora.
      Done: mentor wie, co tlumaczy: podstawy wyspy, pierwsza praca, nagrody,
      dalszy etap.

- [ ] `I2.02` Napisac pierwszy dialog mentora.
      Done: dialog ma maksymalnie kilka krotkich linijek i nie zalewa gracza
      lore.

- [ ] `I2.03` Dodac pierwsza interakcje z mentorem.
      Done: gracz moze porozmawiac natychmiast po spawnie.

- [ ] `I2.04` Dodac pierwszy objective po rozmowie.
      Done: gracz dostaje prosty cel, np. zebrac/dostarczyc drewno.

- [ ] `I2.05` Dodac pierwsza nagrode mentora.
      Done: nagroda pojawia sie w mniej niz 60 sekund normalnej gry.

- [ ] `I2.06` Dodac blokade wielokrotnego odbioru pierwszej nagrody.
      Done: reconnect albo spam interakcji nie duplikuje rewardu.

- [ ] `I2.07` Dodac krotki feedback po nagrodzie.
      Done: gracz wie, co dostal i dlaczego.

- [ ] `I2.08` Dodac drugi cel prowadzacy poza mentora.
      Done: gracz po pierwszej nagrodzie jest kierowany do lasu, kamieni albo
      worksite.

- [ ] `I2.09` Test pierwszej minuty.
      Done: tester od spawnu do pierwszej nagrody miesci sie w 60 sekundach.

## I3 - Dane Gracza Na Poczatkowej Wyspie

Cel fazy: zapisac tylko to, co potrzebne dla startowej wyspy.

- [ ] `I3.01` Zdefiniowac IslandProgress.
      Done: stan zawiera milestone ID, odebrane nagrody, zasoby MVP i status
      konca wyspy.

- [ ] `I3.02` Zdefiniowac inventory startowej wyspy.
      Minimum: `Wood`, `Stone`, `Planks`, `SettlementTokens`.
      Done: system zawiera tylko zasoby potrzebne na poczatkowej wyspie.

- [ ] `I3.03` Dodac helper dodawania zasobow.
      Done: zasoby nie moga spasc ponizej zera i nie moga byc NaN.

- [ ] `I3.04` Dodac helper sprawdzania kosztow/wkladu.
      Done: worksite i sawmill moga bezpiecznie pobierac zasoby.

- [ ] `I3.05` Dodac zapis milestone'ow.
      Done: po reconnect gracz wraca do poprawnego kroku wyspy.

- [ ] `I3.06` Dodac zapis odebranych rewardow.
      Done: nagrody jednorazowe nie duplikuja sie.

- [ ] `I3.07` Dodac zapis zasobow wyspy.
      Done: reconnect nie zeruje drewna, kamienia, plankow i tokenow.

- [ ] `I3.08` Dodac dev reset tylko dla poczatkowej wyspy.
      Done: tester moze zaczac flow od nowa bez dotykania przyszlych systemow.

- [ ] `I3.09` Test zapisu solo.
      Done: gracz wychodzi, wraca i zachowuje milestone oraz zasoby.

- [ ] `I3.10` Test zapisu dwoch graczy.
      Done: postepy graczy nie mieszaja sie.

## I4 - Zbieranie Drewna

Cel fazy: pierwsza aktywnosc ma byc przyjemna, szybka i czytelna.

- [ ] `I4.01` Zdefiniowac starter tree.
      Done: drzewo ma ID, ilosc Wood, czas respawnu i typ interakcji.

- [ ] `I4.02` Dodac interakcje zbierania drewna.
      Done: gracz moze wykonac akcje i dostaje `Wood`.

- [ ] `I4.03` Dodac feedback zebrania drewna.
      Done: gracz widzi przyrost Wood i krotki efekt.

- [ ] `I4.04` Dodac cooldown albo zajecie drzewa.
      Done: spam interakcji nie duplikuje drewna.

- [ ] `I4.05` Dodac respawn drzew.
      Done: starter forest odnawia sie dla pustego i pelniejszego serwera.

- [ ] `I4.06` Dodac osobisty credit do zadania.
      Done: jesli gracz ma cel "zbierz drewno", postep liczy sie osobno dla
      niego.

- [ ] `I4.07` Dodac reward bundle za pierwsze drewno.
      Done: pierwsze zebranie albo pierwsza dostawa daje mala nagrode.

- [ ] `I4.08` Test dwoch graczy przy jednym drzewie.
      Done: nie ma duplikacji, kradziezy nagrod ani crasha.

## I5 - Zbieranie Kamienia I Mineral Samples

Cel fazy: pokazac, ze gra ma wiecej niz drewno, ale bez otwierania pelnego
systemu kopalni.

- [ ] `I5.01` Zdefiniowac loose stone node.
      Done: node ma ID, ilosc `Stone`, czas respawnu i typ interakcji.

- [ ] `I5.02` Dodac interakcje zbierania kamienia.
      Done: gracz moze zebrac `Stone`.

- [ ] `I5.03` Dodac feedback zebrania kamienia.
      Done: gracz widzi przyrost Stone i rozumie, ze to inny zasob.

- [ ] `I5.04` Dodac mineral sample node.
      Done: gracz moze zebrac albo obejrzec probke zapowiadajaca przyszle mining.

- [ ] `I5.05` Ustalic, czy mineral sample daje zasob.
      Done: decyzja jest jawna: daje maly item/token albo tylko milestone.

- [ ] `I5.06` Dodac zadanie "sprobuj mining".
      Done: gracz moze ukonczyc je bez dodatkowych systemow poza wyspa.

- [ ] `I5.07` Dodac respawn kamieni/probek.
      Done: wyspa nie blokuje kolejnych graczy.

- [ ] `I5.08` Test stone/mineral flow.
      Done: gracz znajduje obszar, zbiera zasob/probke i dostaje credit.

## I6 - Shared Worksite

Cel fazy: pokazac wspolny postep bez wymuszania kooperacji.

- [ ] `I6.01` Zdefiniowac projekt worksite.
      Przyklad: naprawa pomostu, wozka, stojaka z narzedziami albo fundamentu
      tartaku.
      Done: worksite ma jasny opis i widoczny efekt koncowy.

- [ ] `I6.02` Zdefiniowac wymagane wklady.
      Minimum: Wood i Stone.
      Done: progi sa male i pasuja do pierwszych 10-15 minut.

- [ ] `I6.03` Dodac osobisty progress contribution.
      Done: kazdy gracz ma osobisty prog, ktory moze ukonczyc solo.

- [ ] `I6.04` Dodac wspolny progress wizualny.
      Done: gracze widza, ze wyspa reaguje na laczny wklad.

- [ ] `I6.05` Dodac dostarczanie zasobow do worksite.
      Done: zasoby sa pobierane serwerowo i nie mozna oddac ujemnej ilosci.

- [ ] `I6.06` Dodac nagrode za osobisty wklad.
      Done: nagroda jest niezalezna od tego, czy inni gracze sa online.

- [ ] `I6.07` Dodac nagrode za pierwszy wspolny etap.
      Done: jesli projekt przechodzi etap, gracze w poblizu albo uczestnicy
      dostaja jasny feedback.

- [ ] `I6.08` Dodac stan wizualny worksite.
      Done: po ukonczeniu etapu obiekt wyglada inaczej.

- [ ] `I6.09` Dodac fallback solo.
      Done: jeden gracz moze sam doprowadzic worksite do stanu wymaganego przez
      MVP.

- [ ] `I6.10` Test multiplayer contribution.
      Done: dwoch graczy doklada zasoby i obaj zachowuja osobisty postep.

## I7 - Shared Sawmill Moment

Cel fazy: dac pierwszy moment przetwarzania w ramach wspolnego obiektu wyspy.

- [ ] `I7.01` Zdefiniowac role tartaku.
      Done: tartak jest wspolnym obiektem wyspy, nie budynkiem gracza.

- [ ] `I7.02` Zdefiniowac warunek uruchomienia tartaku.
      Done: warunek zalezy od milestone'u, worksite albo dostawy Wood.

- [ ] `I7.03` Dodac osobisty prog do sawmill reward.
      Done: gracz solo moze dostac planki po wykonaniu czytelnego celu.

- [ ] `I7.04` Dodac wspolny cykl tartaku.
      Done: wielu graczy moze przyspieszyc/podgladac cykl, ale nie blokuje to
      solo gracza.

- [ ] `I7.05` Dodac animacje albo prosty efekt pracy tartaku.
      Done: moment przetwarzania jest widoczny i satysfakcjonujacy.

- [ ] `I7.06` Przyznac pierwsze `Planks`.
      Done: gracz dostaje planki przed zakonczeniem poczatkowej wyspy.

- [ ] `I7.07` Zablokowac duplikacje plank reward.
      Done: reconnect i spam interakcji nie daja nieskonczonych plankow.

- [ ] `I7.08` Dodac komentarz mentora po tartaku.
      Done: gracz rozumie, ze przetwarzanie bedzie wazne pozniej.

- [ ] `I7.09` Test tartaku solo.
      Done: pusty serwer pozwala uruchomic flow i odebrac planki.

- [ ] `I7.10` Test tartaku multiplayer.
      Done: wielu graczy widzi moment i kazdy dostaje poprawne osobiste nagrody.

## I8 - Skill Sampler Bez Twardej Specjalizacji

Cel fazy: pokazac przyszle role bez blokowania gracza wyborem na zawsze.

- [ ] `I8.01` Zdefiniowac role do pokazania.
      Minimum: Logging, Mining, Carpentry/Builder Helper, Trading Helper jako
      zapowiedz.
      Done: kazda rola ma jedna krotka aktywnosc albo rozmowe.

- [ ] `I8.02` Dodac Logging sample.
      Done: gracz wykonuje akcje zwiazana z drewnem i dostaje credit.

- [ ] `I8.03` Dodac Mining sample.
      Done: gracz wykonuje akcje zwiazana z kamieniem/probka mineralu.

- [ ] `I8.04` Dodac Carpentry/Worksite sample.
      Done: gracz doklada zasob albo naprawia element worksite.

- [ ] `I8.05` Dodac Trading Helper sample jako zapowiedz.
      Done: gracz widzi lokalna tablice, skrzynke dostaw albo NPC proszacego o
      material, bez systemu rynku graczy.

- [ ] `I8.06` Dodac checklist sampler w UI.
      Done: gracz widzi, ktore role juz sprobowal.

- [ ] `I8.07` Dodac nagrode za ukonczenie 3 sample'i.
      Done: nagroda wzmacnia poczucie progresu, ale nie tworzy hard locka.

- [ ] `I8.08` Dodac krotkie podsumowanie roli.
      Done: po kazdym sample gracz dostaje jednozdaniowa informacje, po co ta
      rola bedzie pozniej wazna.

- [ ] `I8.09` Test sampler order.
      Done: role mozna wykonac w dowolnej kolejnosc bez popsucia milestone'u.

## I9 - Objective Tracker, HUD I Feedback

Cel fazy: gracz zawsze wie, co robi i co dostal.

- [ ] `I9.01` Dodac HUD zasobow wyspy.
      Minimum: Wood, Stone, Planks, SettlementTokens.
      Done: HUD aktualizuje sie po zmianie zasobow.

- [ ] `I9.02` Dodac objective tracker.
      Done: tracker pokazuje jeden glowny cel i opcjonalnie progress.

- [ ] `I9.03` Dodac reward toast.
      Done: kazda nagroda ma krotki komunikat.

- [ ] `I9.04` Dodac komunikat braku zasobow.
      Done: przy probie oddania zasobu gracz wie, czego brakuje.

- [ ] `I9.05` Dodac komunikat ukonczenia milestone'u.
      Done: przejscie do kolejnego kroku jest widoczne.

- [ ] `I9.06` Dodac prosty ekran/tablice postepu wyspy.
      Done: gracz moze sprawdzic, co juz zrobil na poczatkowej wyspie.

- [ ] `I9.07` Dodac oznaczenia waznych obiektow.
      Done: mentor, worksite i sawmill sa latwe do odnalezienia.

- [ ] `I9.08` Sprawdzic teksty na desktop.
      Done: teksty mieszcza sie w UI i nie nachodza na siebie.

- [ ] `I9.09` Sprawdzic podstawowa czytelnosc na mniejszym ekranie.
      Done: UI jest przynajmniej uzywalne, nawet jesli pelny mobile polish jest
      post-MVP.

## I10 - Reward Pacing I Ekonomia Wyspy

Cel fazy: poczatkowa wyspa ma dawac czeste, male zwyciestwa bez grindu.

- [ ] `I10.01` Ustalic reward moments 0-10 minut.
      Done: lista zawiera co najmniej 4 momenty nagrody.

- [ ] `I10.02` Ustalic reward moments 10-20 minut.
      Done: gracz ma kolejne 3-5 sensownych nagrod.

- [ ] `I10.03` Ustalic wartosc Wood.
      Done: wiadomo, ile drewna daje jedna akcja i ile potrzeba do pierwszych
      celow.

- [ ] `I10.04` Ustalic wartosc Stone.
      Done: kamien nie dominuje flow, ale jest potrzebny do worksite.

- [ ] `I10.05` Ustalic wartosc Planks.
      Done: planki sa nagroda specjalna, a nie zwykly spamowany zasob.

- [ ] `I10.06` Ustalic role SettlementTokens.
      Done: tokeny sluza do nagrod wyspy, kosmetycznego podsumowania albo
      przyszlego startu, bez uruchamiania dalszych systemow.

- [ ] `I10.07` Ustalic maksymalne progi zbierania.
      Done: zadne zadanie MVP nie wymaga dlugiego powtarzania tej samej akcji.

- [ ] `I10.08` Ustalic czas respawnu node'ow.
      Done: jeden gracz nie czeka, a kilku graczy nie czysci wyspy na stale.

- [ ] `I10.09` Playtest 0-10 minut.
      Done: pierwsze 10 minut nie ma martwych okresow dluzszych niz 2-3 minuty.

- [ ] `I10.10` Playtest pelnej wyspy.
      Done: normalne przejscie miesci sie w docelowym czasie MVP.

## I11 - Koniec Poczatkowej Wyspy

Cel fazy: zakonczyc MVP jasnym "gotowe na kolejny etap", bez wychodzenia poza
poczatkowa wyspe.

- [ ] `I11.01` Zdefiniowac final milestone.
      Done: wiadomo, co trzeba zrobic, aby ukonczyc poczatkowa wyspe.

- [ ] `I11.02` Dodac rozmowe podsumowujaca z mentorem.
      Done: mentor wymienia, czego gracz sie nauczyl.

- [ ] `I11.03` Dodac opcjonalny wybor przyszlego stylu gry.
      Done: wybor nie uruchamia kolejnego systemu; zapisuje tylko preferencje
      albo flavor.

- [ ] `I11.04` Dodac final reward.
      Done: gracz dostaje tytul, token, badge placeholder albo pakiet startowy do
      przyszlego etapu.

- [ ] `I11.05` Dodac ekran "next stage later".
      Done: gra jasno komunikuje, ze dalszy etap bedzie poza tym MVP.

- [ ] `I11.06` Zapisac status ukonczenia wyspy.
      Done: reconnect pokazuje, ze gracz juz ukonczyl startowa wyspe.

- [ ] `I11.07` Dodac mozliwosc powrotu do aktywnosci wyspy.
      Done: po ukonczeniu gracz nadal moze zbierac i pomagac, ale nie farmi
      jednorazowych nagrod.

- [ ] `I11.08` Test final milestone solo.
      Done: pusty serwer pozwala ukonczyc wyspe.

- [ ] `I11.09` Test final milestone multiplayer.
      Done: kilku graczy moze konczyc flow niezaleznie.

## I12 - Multiplayer Bez Wymuszonej Kooperacji

Cel fazy: inni gracze maja dodawac zycia wyspie, nie blokowac progression.

- [ ] `I12.01` Ustalic zasady osobistego creditu.
      Done: kazdy objective wie, czy liczy osobisty postep, wspolny postep, czy
      oba.

- [ ] `I12.02` Ustalic zasady wspolnego worksite.
      Done: wspolny progress jest wizualny, ale osobiste nagrody nie zaleza od
      ostatniego klikniecia innego gracza.

- [ ] `I12.03` Ustalic zasady shared sawmill.
      Done: wielu graczy moze zobaczyc wspolny moment, ale kazdy ma bezpieczne
      nagrody osobiste.

- [ ] `I12.04` Dodac ochrone przed node stealing.
      Done: przy zbieraniu zasobow nie ma frustrujacego zabierania creditu.

- [ ] `I12.05` Dodac limity antyspamowe.
      Done: szybkie powtarzanie interakcji nie psuje shared progress.

- [ ] `I12.06` Test 2 graczy.
      Done: obaj przechodza flow rownolegle.

- [ ] `I12.07` Test 4+ graczy.
      Done: wyspa nadal ma zasoby, czytelny UI i brak blokad progression.

## I13 - Bezpieczenstwo Serwera

Cel fazy: nawet MVP startowej wyspy nie ufa klientowi w sprawach nagrod.

- [ ] `I13.01` Spisac liste remote/interakcji.
      Done: wiadomo, jakie akcje klient moze wywolac.

- [ ] `I13.02` Walidowac mentor rewards.
      Done: serwer sprawdza milestone i odebrane nagrody.

- [ ] `I13.03` Walidowac gathering.
      Done: serwer sprawdza node, cooldown i dostepnosc nagrody.

- [ ] `I13.04` Walidowac worksite contribution.
      Done: serwer sprawdza zasoby i limity wkladu.

- [ ] `I13.05` Walidowac sawmill rewards.
      Done: serwer sprawdza, czy gracz spelnil warunki plank reward.

- [ ] `I13.06` Walidowac final milestone.
      Done: gracz nie moze oznaczyc wyspy jako ukonczonej bez wymaganych krokow.

- [ ] `I13.07` Dodac sanity checks danych wyspy.
      Done: ujemne wartosci i niepoprawne ID sa odrzucane albo naprawiane.

- [ ] `I13.08` Test zlych danych.
      Done: reczne zle requesty nie crashuja serwera i nie daja nagrod.

## I14 - Testy Wydania MVP Wyspy

Cel fazy: uznac MVP za gotowe dopiero po powtarzalnym przejsciu.

- [ ] `I14.01` Test pierwszych 60 sekund.
      Done: gracz dostaje pierwsza nagrode.

- [ ] `I14.02` Test 0-10 minut.
      Done: gracz ma co najmniej 4 reward moments.

- [ ] `I14.03` Test 0-30 minut solo.
      Done: gracz konczy cala poczatkowa wyspe na pustym serwerze.

- [ ] `I14.04` Test 0-30 minut z drugim graczem.
      Done: obaj gracze koncza flow bez blokowania siebie.

- [ ] `I14.05` Test reconnect w polowie wyspy.
      Done: gracz wraca do poprawnego objective.

- [ ] `I14.06` Test reconnect po ukonczeniu wyspy.
      Done: gra pamieta final milestone.

- [ ] `I14.07` Test respawnu zasobow.
      Done: wyspa nie zostaje pusta po kilku minutach aktywnosci.

- [ ] `I14.08` Test worksite.
      Done: osobisty i wspolny progress dzialaja zgodnie z zalozeniami.

- [ ] `I14.09` Test sawmill moment.
      Done: planki sa przyznawane poprawnie i tylko wtedy, kiedy trzeba.

- [ ] `I14.10` Test UI.
      Done: objective, rewardy i zasoby sa czytelne.

- [ ] `I14.11` Test output log.
      Done: normalne przejscie MVP nie generuje czerwonych runtime errorow.

- [ ] `I14.12` Spisac znane bugi.
      Done: lista bugow istnieje albo jest jawnie pusta.

- [ ] `I14.13` Oznaczyc MVP poczatkowej wyspy jako gotowe.
      Done: wszystkie Must Have sa zamkniete.

## Manual Test Checklist

- [ ] Gracz spawnuje na poczatkowej wyspie.
- [ ] Mentor jest widoczny od razu.
- [ ] Gracz dostaje pierwszy objective.
- [ ] Gracz dostaje pierwsza nagrode w mniej niz 60 sekund.
- [ ] Gracz zbiera Wood.
- [ ] Gracz zbiera Stone.
- [ ] Gracz widzi mineral sample albo zapowiedz mining.
- [ ] HUD pokazuje zasoby wyspy.
- [ ] Objective tracker pokazuje kolejny krok.
- [ ] Gracz doklada zasoby do worksite.
- [ ] Worksite pokazuje osobisty progress.
- [ ] Worksite pokazuje jakas reakcje wspolna.
- [ ] Gracz uruchamia albo wspoluruchamia tartak.
- [ ] Gracz dostaje Planks.
- [ ] Gracz probuje Logging sample.
- [ ] Gracz probuje Mining sample.
- [ ] Gracz probuje Carpentry/Worksite sample.
- [ ] Gracz widzi zapowiedz Trading Helper albo lokalnej wymiany.
- [ ] Gracz konczy final milestone wyspy.
- [ ] Gracz dostaje final reward.
- [ ] Gra nie uruchamia jeszcze kolejnego etapu progresji.
- [ ] Reconnect w polowie wyspy dziala.
- [ ] Reconnect po koncu wyspy dziala.
- [ ] Dwoch graczy moze grac obok siebie.
- [ ] Pusty serwer nie blokuje zadnego kroku.
- [ ] Output log jest czysty.

## Proponowana Kolejnosc Goals

1. `I0.01` Zapisac cel poczatkowej wyspy.
2. `I0.02` Zapisac warunek konca MVP.
3. `I0.05` Ustalic liste zasobow MVP.
4. `I1.01` Zaprojektowac layout wyspy.
5. `I1.03` Przygotowac spawn point.
6. `I1.04` Przygotowac mentor area.
7. `I2.01` Zdefiniowac role mentora.
8. `I2.03` Dodac pierwsza interakcje z mentorem.
9. `I3.01` Zdefiniowac IslandProgress.
10. `I3.02` Zdefiniowac inventory startowej wyspy.
11. `I4.01` Zdefiniowac starter tree.
12. `I4.02` Dodac interakcje zbierania drewna.
13. `I2.05` Dodac pierwsza nagrode mentora.
14. `I5.01` Zdefiniowac loose stone node.
15. `I5.02` Dodac interakcje zbierania kamienia.
16. `I6.01` Zdefiniowac projekt worksite.
17. `I6.05` Dodac dostarczanie zasobow do worksite.
18. `I7.01` Zdefiniowac role tartaku.
19. `I7.06` Przyznac pierwsze Planks.
20. `I8.01` Zdefiniowac role do pokazania.
21. `I9.01` Dodac HUD zasobow wyspy.
22. `I9.02` Dodac objective tracker.
23. `I10.01` Ustalic reward moments 0-10 minut.
24. `I11.01` Zdefiniowac final milestone.
25. `I11.04` Dodac final reward.
26. `I12.06` Test 2 graczy.
27. `I14.01`-`I14.13` Przejsc testy wydania.

## Najmniejszy Pionowy Slice

Jesli chcemy zbudowac absolutnie najmniejszy grywalny kawalek poczatkowej wyspy:

- [ ] Gracz spawnuje przed mentorem.
- [ ] Mentor daje cel: zdobadz Wood.
- [ ] Gracz zbiera Wood z drzewa.
- [ ] Gracz widzi Wood w HUD.
- [ ] Mentor daje mala nagrode.
- [ ] Gracz oddaje Wood do worksite.
- [ ] Worksite zmienia stan.
- [ ] Tartak daje graczowi Planks.
- [ ] Mentor podsumowuje etap.
- [ ] Gra zapisuje, ze gracz ukonczyl slice.

Ten slice udowadnia tylko pierwsza obietnice poczatkowej wyspy: wejscie do
swiata, szybka nagroda, zbieranie, wspolny obiekt i pierwszy przetworzony
material.

## Ryzyka MVP Poczatkowej Wyspy

- [ ] Wyspa moze byc zbyt szeroka jak na MVP.
      Mitigacja: trzymac sie flow mentor -> wood -> stone -> worksite -> sawmill
      -> final milestone.

- [ ] Shared progress moze blokowac solo gracza.
      Mitigacja: kazdy wspolny system musi miec osobisty prog solo.

- [ ] Gracz moze oczekiwac natychmiastowego kolejnego etapu po final milestone.
      Mitigacja: komunikowac, ze to zapowiedz przyszlej wersji, nie unlock w MVP.

- [ ] Za duzo zasobow moze stworzyc wrazenie grindu.
      Mitigacja: male progi, czeste rewardy, brak dlugiego farmienia.

- [ ] Multiplayer moze powodowac kradziez node'ow.
      Mitigacja: osobisty credit, szybki respawn, brak nagrod za ostatni hit.

- [ ] UI moze tlumaczyc za duzo naraz.
      Mitigacja: jeden glowny objective na raz, reszta jako ambient feedback.

## Decyzje Do Podjecia Przed Implementacja

- [ ] Czy final milestone ma byc rytualem, rozmowa, naprawa tartaku, czy
      podsumowaniem na job board?
- [ ] Czy `SettlementTokens` zostaja w MVP, czy wystarcza Wood, Stone i Planks?
- [ ] Czy mineral sample daje prawdziwy item, czy tylko milestone credit?
- [ ] Czy wybor przyszlego stylu gry jest w MVP, czy dopiero po wyspie?
- [ ] Czy shared worksite naprawia tartak, pomost, wozek, czy tablice zadan?
- [ ] Czy po ukonczeniu wyspy gracz moze powtarzac daily/local tasks?
- [ ] Czy MVP ma miec badge placeholder za ukonczenie wyspy?

## Kandydaci Na Post-MVP

- [ ] Kolejny etap progresji po poczatkowej wyspie.
- [ ] System konstrukcyjny po poczatkowej wyspie.
- [ ] Dedykowane miejsca produkcji po starcie.
- [ ] Pelny chain Wood and Planks po poczatkowej wyspie.
- [ ] Stone Furnace and Coal.
- [ ] Loose Iron Ore and Ingots.
- [ ] Forge and Basic Pickaxe.
- [ ] Storage Crates.
- [ ] Simple Components.
- [ ] Nails and Brackets.
- [ ] Grain, Flour, and Bread.
- [ ] Handel miedzy graczami.
- [ ] Buy offers i sell offers.
- [ ] Reputation i producer identity.
- [ ] NPC workers.
- [ ] Dlugoterminowa ekonomia serwera.
