# Modelowanie bazy danych – Serwis aukcyjny

Projekt polegający na zaprojektowaniu bazy danych dla systemu aukcyjnego. Zawiera diagram ERD, diagram relacyjny (RM), definicje tabel w SQL oraz przykładowe zapytania, wraz z optymalizacjami. Projekt miał na celu praktyczne zastosowanie zasad modelowania danych, relacji i normalizacji.

## Założenia
- Tworzenie modelu koncepcyjnego (ERD) i logicznego (RM)
- Projektowanie struktury bazy z kluczami głównymi i obcymi
- Normalizacja tabel i relacji wiele-do-wielu
- Optymalizacja zapytań SQL 

## Technologie
- SQL (MSSQL)
- Canva 

## Opis modelu
Baza danych obsługuje użytkowników, przedmioty, licytacje, oferty oraz opcje dostawy.

- **Użytkownicy** mogą wystawiać przedmioty i składać oferty w licytacjach. Identyfikowani są za pomocą loginu. Przechowywane są ich dane kontaktowe oraz dodatkowe informacje.
- **Przedmioty** mają nazwę, kategorię, cenę wyjściową i opcjonalnie cenę kupna oraz opis. Przedmiot musi być związany z przynajmniej jedną licytacją.
- **Licytacje** są przypisane do przedmiotów (w momencie ich wystawienia) i mają określoną datę rozpoczęcia, zakończenia i status. Pamiętany jest również login ewentualnego zwycięzcy.
- **Oferty** zawierają kwotę, czas złożenia i identyfikują użytkownika, który je złożył w ramach danej licytacji.
- **Dostawy** – każdemu przedmiotowi przypisane są dostępne opcje dostawy, opisane nazwą, firmą i ceną.
