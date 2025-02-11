# SQL Portfolio - Traveler Trip Data

## Opis projektu 
Projekt zawiera bazę danych do zarządzania informacjami o podróżach. Baza danych zawiera informacje o podróżach (`Trips`), podróżnikach (`Travelers`) oraz relację między nimi (`Trip_Travelers`). Celem projektu jest analiza danych podróży, w tym kosztów zakwaterowania i transportu oraz generowanie raportów na temat kosztów podróży w różnych krajach i miastach.

Ten projekt przedstawia analizę danych podróżniczych z wykorzystaniem SQL. Dane pochodzą z publicznie dostępnego zbioru na Kaggle:Traveler Trip Data - Kaggle

##  Struktura bazy danych
W projekcie utworzono trzy tabele:

### **Trips** (Informacje o podróżach)
| Kolumna               | Typ danych      | Opis                           |
|----------------------|---------------|--------------------------------|
| TripID              | INT (PK)       | Unikalny identyfikator podróży |
| City                | VARCHAR(255)   | Miasto                        |
| Country             | VARCHAR(255)   | Kraj                          |
| Start_Date          | DATE           | Data rozpoczęcia podróży      |
| End_Date            | DATE           | Data zakończenia podróży      |
| Duration_Days       | INT            | Długość podróży w dniach      |
| Accommodation_Type  | VARCHAR(255)   | Rodzaj zakwaterowania         |
| Accommodation_Cost  | FLOAT          | Koszt zakwaterowania          |
| Transportation_Type | VARCHAR(255)   | Rodzaj transportu             |
| Transportation_Cost | FLOAT          | Koszt transportu              |

---

### **Travelers** (Informacje o podróżujących)
| Kolumna     | Typ danych      | Opis                          |
|------------|---------------|-------------------------------|
| TravelerID | INT (PK)       | Unikalny identyfikator podróżnika |
| Name       | VARCHAR(255)   | Imię podróżnika               |
| Age        | FLOAT          | Wiek podróżnika               |
| Gender     | VARCHAR(20)    | Płeć                          |
| Nationality| VARCHAR(255)   | Narodowość                    |

---

### **Trip_Travelers** (Relacja między podróżami a podróżnikami)
| Kolumna    | Typ danych  | Opis |
|------------|------------|------|
| TripID     | INT (FK)   | Identyfikator podróży |
| TravelerID | INT (FK)   | Identyfikator podróżnika |

## Źródło danych

Dane, które są wstawiane do tabel `Trips` oraz `Travelers`, pochodzą z pliku Excel o nazwie `cleaned_file_travel_excel.xlsx`. Plik zawiera informacje o podróżach oraz podróżnikach i jest wykorzystywany w projekcie do załadowania danych do bazy danych.

## Import danych do bazy danych

Dane są importowane do bazy danych SQL Server przy użyciu zapytań SQL z pliku Excel `cleaned_file_travel_excel.xlsx`. Plik Excel zawiera dane o podróżach oraz podróżnikach, które następnie są wstawiane do odpowiednich tabel w bazie danych.

### Struktura pliku Excel:

Plik `cleaned_file_travel_excel.xlsx` ma następującą strukturę:

- **Arkusz**: `a$`
- **Kolumny** w pliku Excel:
  - **Trips**:
    - `City`, `Country`, `Start date`, `End date`, `Duration (days)`, `Accommodation type`, `Accommodation cost`, `Transportation type`, `Transportation cost`
  - **Travelers**:
    - `Traveler name`, `Traveler age`, `Traveler gender`, `Traveler nationality`

### Zapytania SQL do importu danych

Dane z pliku Excel są importowane do bazy danych przy użyciu poniższych zapytań SQL:

1. **Załaduj dane do tabeli `Trips`**:
   ```sql
   INSERT INTO Trips (City, Country, Start_Date, End_Date, Duration_Days, Accommodation_Type, Accommodation_Cost, Transportation_Type, Transportation_Cost)
   SELECT 
       [City], 
       [Country], 
       [Start date], 
       [End date], 
       [Duration (days)], 
       [Accommodation type], 
       [Accommodation cost], 
       [Transportation type], 
       [Transportation cost]
   FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 
                   'Excel 12.0; Database=C:\Users\your_username\Documents\cleaned_file_travel_excel.xlsx; HDR=YES', 
                   'SELECT * FROM [a$]');
2. **Załaduj dane do tabeli `Travelers`**:
 ```sql
INSERT INTO Travelers (Name, Age, Gender, Nationality)
SELECT  
    [Traveler name], 
    [Traveler age], 
    [Traveler gender], 
    [Traveler nationality]
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 
                'Excel 12.0; Database=C:\Users\your_username\Documents\cleaned_file_travel_excel.xlsx; HDR=YES', 
                'SELECT * FROM [a$]');

-- ========================
-- Zapytania do tabeli Trips
-- ========================

-- 1. Liczba podróży według typu zakwaterowania
-- To zapytanie zlicza liczbę podróży dla każdego typu zakwaterowania
SELECT 
    Accommodation_Type,
    COUNT(*) AS Number_of_Trips
FROM Trips
GROUP BY Accommodation_Type
ORDER BY Number_of_Trips DESC;

-- ========================
-- Koszty podróży
-- ========================

-- 2. Całkowity koszt (zakwaterowanie + transport) dla każdej podróży
-- To zapytanie wylicza całkowity koszt podróży, sumując koszty zakwaterowania i transportu
SELECT 
    TripID,
    City,
    Country,
    Start_Date,
    End_Date,
    (Accommodation_Cost + Transportation_Cost) AS Total_Cost
FROM Trips;

-- ========================
-- Średni koszt podróży na podstawie kraju
-- ========================

-- 3. Średni koszt podróży w każdym kraju (z zaokrągleniem do 2 miejsc po przecinku)
-- To zapytanie oblicza średni koszt podróży w danym kraju
SELECT 
    Country,
    AVG(ROUND(Accommodation_Cost + Transportation_Cost, 2)) AS Average_Cost
FROM Trips
GROUP BY Country;

-- ========================
-- Średni koszt podróży na podstawie kraju (z konwersją na liczbę całkowitą)
-- ========================

-- 4. Średni koszt podróży w każdym kraju z konwersją wyniku na liczbę całkowitą
-- To zapytanie oblicza średni koszt podróży w danym kraju i zaokrągla wynik do liczby całkowitej
SELECT 
    Country,
    CAST(AVG(ROUND(Accommodation_Cost + Transportation_Cost, 2)) AS INT) AS Average_Cost
FROM Trips
GROUP BY Country;

