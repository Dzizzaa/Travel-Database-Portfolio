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
-- 1. Zapytania dotyczące kosztów
-- ========================

-- 1. Liczba podróży według typu zakwaterowania
-- To zapytanie zlicza liczbę podróży dla każdego typu zakwaterowania
SELECT 
    Accommodation_Type,
    COUNT(*) AS Number_of_Trips
FROM Trips
GROUP BY Accommodation_Type
ORDER BY Number_of_Trips DESC;

| Accommodation_Type | Number_of_Trips |
|--------------------|-----------------|
| Hotel              | 120             |
| Hostel             | 80              |
| Apartment          | 45              |
| Guesthouse         | 30              |


-- 2. Całkowity koszt (zakwaterowanie + transport) dla podróży
-- To zapytanie wylicza całkowity koszt podróży, sumując koszty zakwaterowania i transportu
SELECT TOP 10
    TripID,
    City,
    (Accommodation_Cost + Transportation_Cost) AS Total_Cost
FROM Trips
ORDER BY Total_Cost desc

| TripID | City            | Total Cost |
|--------|---------------|------------|
| 131    | New York       | 10500      |
| 136    | Auckland       | 9500       |
| 129    | Sydney         | 9000       |
| 127    | Tokyo          | 8500       |
| 135    | Barcelona      | 8500       |
| 133    | Vancouver      | 8000       |
| 126    | Paris          | 7500       |
| 130    | Rome           | 5500       |
| 128    | Cape Town      | 5000       |
| 132    | Rio de Janeiro | 4500       |




-- 3. Średni koszt podróży w każdym kraju (z zaokrągleniem do 0 miejsc po przecinku)
SELECT 
    TOP 10 Country,
    ROUND(AVG(Accommodation_Cost + Transportation_Cost), 0) AS Average_Cost
FROM Trips
GROUP BY Country
ORDER BY AVERAGE_COST  DESC;

| Country               | Total Cost |
|-----------------------|------------|
| New Zealand          | 9500       |
| Hawaii               | 3500       |
| Canada               | 2992       |
| USA                  | 2509       |
| United Arab Emirates | 2300       |
| Spain                | 2243       |
| South Africa         | 2175       |
| Australia            | 2142       |
| Germany              | 2100       |
| Indonesia            | 2000       |


-- ========================
-- 2. Zapytania dotyczące podróżników
-- ========================

-- 4. Podróżnicy według wieku
-- To zapytanie zlicza liczbę podróżników w zależności od wieku
SELECT t.Age, COUNT(*) AS Number_of_Travelers
FROM Travelers t
GROUP BY t.Age
ORDER BY Number_of_Travelers DESC;
| Age | Number of Travelers |
|-----|---------------------|
| 27  | 12                 |
| 29  | 12                 |
| 28  | 11                 |
| 31  | 11                 |
| 35  | 10                 |
| 33  | 9                  |
| 45  | 8                  |
| 42  | 7                  |
| 30  | 7                  |
| 25  | 7                  |
| 26  | 6                  |
| 32  | 4                  |
| 37  | 4                  |
| 38  | 4                  |
| 24  | 4                  |
| 41  | 4                  |
| 39  | 3                  |
| 34  | 2                  |
| 40  | 1                  |
| 20  | 1                  |
| 23  | 1                  |
| 36  | 1                  |
| 46  | 1                  |
| 47  | 1                  |
| 48  | 1                  |
| 50  | 1                  |
| 55  | 1                  |
| 60  | 1                  |
| 43  | 1                  |


-- 5. Podróżnicy według płci
-- Zlicza liczbę podróżników w zależności od płci
SELECT t.Gender, COUNT(*) AS Number_of_Travelers
FROM Travelers t
GROUP BY t.Gender;
| Gender | Number of Travelers |
|--------|---------------------|
| Female | 70                  |
| Male   | 66                  |

-- 6. Średni wiek amerykańskich podróżników
-- To zapytanie oblicza średni wiek amerykańskich podróżników
SELECT ROUND(AVG(Age), 0) AS sredni_wiek
FROM Travelers
WHERE Nationality = 'American';

-- ========================
-- 3. Zapytania o podróże
-- ========================

-- 7. Najczęściej odwiedzane miasta
-- To zapytanie zlicza liczbę podróży do każdego miasta
SELECT City, COUNT(*) AS Number_of_Trips
FROM Trips
GROUP BY City
ORDER BY Number_of_Trips DESC;

| City            | Number of Trips |
|----------------|----------------|
| Paris          | 15             |
| Sydney         | 13             |
| Tokyo          | 13             |
| Bali           | 12             |
| New York       | 10             |
| Bangkok        | 9              |
| Rome           | 9              |
| Barcelona      | 7              |
| London         | 7              |
| Rio de Janeiro | 6              |
| Cancun         | 5              |
| Cape Town      | 4              |
| Dubai          | 3              |
| Amsterdam      | 3              |
| Athens         | 3              |
| Phuket         | 3              |
| Vancouver      | 3              |
| Seoul          | 2              |
| Honolulu       | 2              |
| Phnom Penh     | 1              |
| Auckland       | 1              |
| Los Angeles    | 1              |
| Marrakech      | 1              |
| Edinburgh      | 1              |
| Berlin         | 1              |
| Cairo          | 1              |


-- 8. Podróże w 2023 roku
-- To zapytanie wyświetla podróże w roku 2023 dla wszystkich podróżników
SELECT 
    t.Name AS Traveler_Name,
    tr.City,
    tr.Country,
    tr.Start_Date,
    tr.End_Date
FROM Travelers t
JOIN Trip_Travelers tt ON t.TravelerID = tt.TravelerID
JOIN Trips tr ON tt.TripID = tr.TripID
WHERE tr.Start_Date BETWEEN '2023-01-01' AND '2023-12-31';

-- 9. Najdłuższa podróż
-- To zapytanie znajduje najdłuższe podróże na podstawie liczby dni
SELECT City, Country, MAX(Duration_Days) AS max_duration_days
FROM Trips
GROUP BY City, Country
ORDER BY max_duration_days DESC;

| City            | Country               | Max Duration (Days) |
|----------------|----------------------|---------------------|
| New York       | USA                   | 14                  |
| Sydney         | Australia             | 13                  |
| Bali           | Indonesia             | 11                  |
| Rome           | Italy                 | 11                  |
| London         | UK                    | 11                  |
| Tokyo          | Japan                 | 10                  |
| Cancun         | Mexico                | 10                  |
| Seoul          | South Korea           | 10                  |
| Athens         | Greece                | 10                  |
| Honolulu       | Hawaii                | 9                   |
| Paris          | France                | 9                   |
| Berlin         | Germany               | 9                   |
| Rio de Janeiro | Brazil                | 9                   |
| Cape Town      | South Africa          | 9                   |
| Dubai          | United Arab Emirates  | 8                   |
| Amsterdam      | Netherlands           | 8                   |
| Barcelona      | Spain                 | 8                   |
| Bangkok        | Thailand              | 8                   |
| Phuket         | Thailand              | 7                   |
| Marrakech      | Morocco               | 7                   |
| Vancouver      | Canada                | 7                   |
| Cairo          | Egypt                 | 7                   |
| Auckland       | New Zealand           | 7                   |
| Edinburgh      | Scotland              | 7                   |
| Los Angeles    | USA                   | 7                   |
| Phnom Penh     | Cambodia              | 5                   |


-- ========================
-- 4. Zaawansowane zapytania z WITH i JOIN
-- ========================

-- 10. Podróże, które trwały dłużej niż średni czas trwania w danym mieście
WITH podroze AS (
    SELECT city, country, AVG(duration_days) AS srednia
    FROM trips
    GROUP BY city, country 
)
SELECT t.city, t.country, t.Duration_Days, p.srednia
FROM trips t 
JOIN podroze p ON p.City = t.City AND p.Country = t.Country
WHERE t.Duration_Days > p.srednia
ORDER BY p.srednia DESC;

-- 11. Podróżnicy podróżujący samolotem
SELECT tra.TravelerID, tra.Name
FROM Trip_Travelers t
JOIN trips AS tr ON t.TripID = tr.TripID
JOIN Travelers as tra on tra.TravelerID = t.TravelerID
WHERE tr.Transportation_Type = 'Flight';

| TravelerID | Name            |
|------------|----------------|
| 1          | John Smith     |
| 2          | Jane Doe       |
| 3          | David Lee      |
| 4          | Sarah Johnson  |
| 6          | Michael Brown  |
| 7          | Emily Davis    |
| 8          | Lucas Santos   |
| 10         | Mohammed Ali   |
| 11         | Ana Hernandez  |
| 13         | Lily Wong      |
| 14         | Hans Mueller   |
| 15         | Fatima Khouri  |
| 53         | Jessica Wong   |



-- ========================
-- 5. Koszty i inne analizy
-- ========================

-- 12. Miasta z najwyższym kosztem zakwaterowania (poza USA)
SELECT TOP 10 City, Country, MAX(Accommodation_Cost) AS max
FROM Trips
WHERE Country != 'USA'
GROUP BY City, Country
ORDER BY max DESC;



| City            | Country         | Max Cost |
|----------------|----------------|----------|
| Tokyo          | Japan           | 7000     |
| Auckland       | New Zealand     | 7000     |
| Sydney         | Australia       | 6000     |
| Barcelona      | Spain           | 6000     |
| Vancouver      | Canada          | 5000     |
| Paris          | France          | 5000     |
| Rome           | Italy           | 4000     |
| Honolulu       | Hawaii          | 3000     |
| Cape Town      | South Africa    | 3000     |
| Rio de Janeiro | Brazil          | 2500     |


