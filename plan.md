# Plan: Aplikacja "Zachcianki" (Flutter, iOS/Android/Windows)

## Cel
Aplikacja mobilna/desktopowa dla zakupoholików: odsuwanie zakupów w czasie, świadomy wybór 2–3 rzeczy miesięcznie w ramach budżetu.

## Cykl użycia
1. Zapisz zachciankę — link/zdjęcie/wpis, orientacyjna cena, pytanie „Co ten zakup miałby mi dać?”
2. Okres oczekiwania 7/30 dni (per wpis)
3. Ocena — „Nadal chcę” / „Mam podobne” / „Nie potrzebuję” + pokaz pierwotnego uzasadnienia
4. Wybór 2–3 rzeczy w ramach budżetu, z opcją „zero zakupów”

## Fazy

### Faza 0 — Fundamenty
- Setup Flutter project (iOS, Android, Windows)
- Architektura: feature-first, Riverpod, go_router
- Local DB: drift (SQLite) + szyfrowanie (sqlcipher) opcjonalnie
- Temat UI (Material 3), dark/light

### Faza 1 — MVP: Zapis i lista
- Formularz zachcianki: tytuł, opis, typ (link/zdjęcie/wpis), URL, zdjęcie, cena, powód („Co da?”), okres oczekiwania (7/30/custom)
- Lista aktywnych z odliczaniem dni
- Szczegóły wpisu + edycja/usuwanie
- Lokalne przechowywanie

### Faza 2 — Cykl oceny
- Automatyczne oznaczanie wpisów „gotowych do oceny” po upływie okresu
- Ekran oceny z pierwotnym uzasadnieniem i statusem
- Akcje: Nadal chcę / Mam podobne / Nie potrzebuję
- Historia decyzji

### Faza 3 — Miesięczny wybór
- Ekran „Miesiąc” z budżetem i limitem 2–3 pozycji
- Wybór z kandydatów („Nadal chcę”)
- Podsumowanie wydatków vs budżet
- Zakończenie miesiąca bez zakupu
- Archiwum zakupów

### Faza 4 — Powiadomienia i synchronizacja
- Lokalne powiadomienia o gotowych do oceny
- Przypomnienia miesięczne
- Opcjonalny sync (Firebase/Supabase) — konto, backup

### Faza 5 — Polish
- Widgety/statystyki (ile zaoszczędzono)
- Eksport CSV/JSON
- Testy (unit/widget/integration)
- Publikacja (App Store, Play, MS Store)

## Modele danych (szkic)
- WishItem: id, title, type, url?, imagePath?, price, reason, waitDays, createdAt, readyAt, status (pending/ready/kept/skipped/bought), monthBucket
- MonthlyBudget: month, amount, spent
- Settings: defaultWaitDays, monthlyLimit, currency

## Ryzyka
- Motywacja do regularnego wracania — powiadomienia + gamifikacja (streak)
- Zdjęcia/linki offline — cache + placeholder
- Windows: uprawnienia do plików, bild

## Walidacja
- Testy logiki (okresy, budżet)
- Manualne E2E na 3 platformach