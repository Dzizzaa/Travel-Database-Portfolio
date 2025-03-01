# SQL Portfolio - Traveler Trip Data
## Project Description
This project contains a database for managing travel information. The database includes data on trips (Trips), travelers (Travelers), and the relationship between them (Trip_Travelers). The goal of the project is to analyze travel data, including accommodation and transportation costs, and generate reports on travel expenses across different countries and cities.

The project demonstrates the analysis of travel data using SQL. The data is sourced from a publicly available dataset on Kaggle: Traveler Trip Data.

I used Microsoft SQL Server Management Studio to create the database named TRIP. I imported a cleaned data file from Kaggle and created the necessary tables, along with database diagrams. I then began writing SQL queries.

![image](https://github.com/user-attachments/assets/937ba0b1-7335-4115-ad79-d8f7d8751f6b)

## Database Structure
The project consists of three tables:

### **Trips** (Travel Information)
| Column              | Data Type      | Description                    |
|----------------------|---------------|--------------------------------|
| TripID              | INT (PK)       | Unique identifier for the trip|
| City                | VARCHAR(255)   | City of the trips             |
| Country             | VARCHAR(255)   | Country of the trip           |
| Start_Date          | DATE           | Start date of the trip        |
| End_Date            | DATE           | End date of the trip          |
| Duration_Days       | INT            | Duration of the trip in days  |
| Accommodation_Type  | VARCHAR(255)   | Type of accommodation         |
| Accommodation_Cost  | FLOAT          | Accommodation cost            |
| Transportation_Type | VARCHAR(255)   | Type of transportation        |
| Transportation_Cost | FLOAT          | Transportation cost           |

### **Travelers** (Traveler Information)
| Column     | Data Type      | Description                         |
|------------|---------------|-------------------------------|
| TravelerID | INT (PK)       | Unique identifier for the traveler |
| Name       | VARCHAR(255)   | Traveler's name           |
| Age        | FLOAT          | Traveler's age            |
| Gender     | VARCHAR(20)    | Traveler's gender         |
| Nationality| VARCHAR(255)   | Traveler's nationality    |


### **Trip_Travelers** (Relationship between Trips and Travelers)
| Kolumna    | Typ danych  | Opis |
|------------|------------|------|
| TripID     | INT (FK)   | Trip identifier |
| TravelerID | INT (FK)   | Traveler identifier |



## Data Source
The data inserted into the Trips and Travelers tables comes from the Excel file cleaned_file_travel_excel.xlsx. The file contains information about trips and travelers and is used in this project to load data into the database.

## Data Import into the Database
Data is imported into the SQL Server database using SQL queries from the Excel file cleaned_file_travel_excel.xlsx. The Excel file contains trip and traveler data, which are inserted into the appropriate tables in the database.

## Excel File Structure:
The file cleaned_file_travel_excel.xlsx has the following structure:

Sheet: a$
Columns in the Excel file:
Trips:
City, Country, Start date, End date, Duration (days), Accommodation type, Accommodation cost, Transportation type, Transportation cost
Travelers:
Traveler name, Traveler age, Traveler gender, Traveler nationality

![image](https://github.com/user-attachments/assets/9cf42291-326d-4856-86d2-7314cca47fd1)

```

# SQL Queries for Data Import
Data from the Excel file is imported into the database using the following SQL queries:

1. **Loading data into the `Trips` table**:
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
   
2. **Loading data into the `Travelers` table**:
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
   
3. **Queries**:

  ```sql
 -- 1.Number of trips by accommodation type
 
   -- This query counts the number of trips for each accommodation type
   
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

-- 2. Total cost (accommodation + transportation) for trips
   
 -- This query calculates the total cost of trips by summing accommodation and transportation costs

SELECT TOP 10
    TripID,
    City,
    (Accommodation_Cost + Transportation_Cost) AS Total_Cost
FROM Trips
ORDER BY Total_Cost DESC;

| TripID | City            | Total Cost |
|--------|-----------------|------------|
| 131    | New York        | 10500      |
| 136    | Auckland        | 9500       |
| 129    | Sydney          | 9000       |
| 127    | Tokyo           | 8500       |
| 135    | Barcelona       | 8500       |
| 133    | Vancouver       | 8000       |
| 126    | Paris           | 7500       |
| 130    | Rome            | 5500       |
| 128    | Cape Town       | 5000       |
| 132    | Rio de Janeiro  | 4500       |

-- 3. **Average trip cost in each country (rounded to 0 decimal places)**

SELECT 
    TOP 10 Country,
    ROUND(AVG(Accommodation_Cost + Transportation_Cost), 0) AS Average_Cost
FROM Trips
GROUP BY Country
ORDER BY Average_Cost DESC;

| Country               | Total Cost |
|-----------------------|------------|
| New Zealand           | 9500       |
| Hawaii                | 3500       |
| Canada                | 2992       |
| USA                   | 2509       |
| United Arab Emirates  | 2300       |
| Spain                 | 2243       |
| South Africa          | 2175       |
| Australia             | 2142       |
| Germany               | 2100       |
| Indonesia             | 2000       |

-- ========================
-- 2. **Traveler queries**
-- ========================

-- 4. **Travelers by age**
-- This query counts the number of travelers by age

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

-- 5. **Travelers by gender**
-- Counts the number of travelers by gender

SELECT t.Gender, COUNT(*) AS Number_of_Travelers
FROM Travelers t
GROUP BY t.Gender;

| Gender | Number of Travelers |
|--------|---------------------|
| Female | 70                  |
| Male   | 66                  |

-- 6. **Average age of American travelers**
-- This query calculates the average age of American travelers
SELECT ROUND(AVG(Age), 0) AS average_age
FROM Travelers
WHERE Nationality = 'American';

-- ========================
-- 3. **Trip queries**
-- ========================

-- 7. **Most visited cities**
-- This query counts the number of trips to each city
SELECT City, COUNT(*) AS Number_of_Trips
FROM Trips
GROUP BY City
ORDER BY Number_of_Trips DESC;

| City            | Number of Trips |
|-----------------|-----------------|
| Paris           | 15              |
| Sydney          | 13              |
| Tokyo           | 13              |
| Bali            | 12              |
| New York        | 10              |
| Bangkok         | 9               |
| Rome            | 9               |
| Barcelona       | 7               |
| London          | 7               |
| Rio de Janeiro  | 6               |
| Cancun          | 5               |
| Cape Town       | 4               |
| Dubai           | 3               |
| Amsterdam       | 3               |
| Athens          | 3               |
| Phuket          | 3               |
| Vancouver       | 3               |
| Seoul           | 2               |
| Honolulu        | 2               |
| Phnom Penh      | 1               |
| Auckland        | 1               |
| Los Angeles     | 1               |
| Marrakech       | 1               |
| Edinburgh       | 1               |
| Berlin          | 1               |
| Cairo           | 1               |

-- 8. **Trips in 2023**
-- This query displays trips made in 2023 for all travelers
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

-- 9. **Longest trip**
-- This query finds the longest trips based on the number of days
SELECT City, Country, MAX(Duration_Days) AS max_duration_days
FROM Trips
GROUP BY City, Country
ORDER BY max_duration_days DESC;

| City            | Country               | Max Duration (Days) |
|-----------------|-----------------------|---------------------|
| New York        | USA                   | 14                  |
| Sydney          | Australia             | 13                  |
| Bali            | Indonesia             | 11                  |
| Rome            | Italy                 | 11                  |
| London          | UK                    | 11                  |
| Tokyo           | Japan                 | 10                  |
| Cancun          | Mexico                | 10                  |
| Seoul           | South Korea           | 10                  |
| Athens          | Greece                | 10                  |
| Honolulu        | Hawaii                | 9                   |
| Paris           | France                | 9                   |
| Berlin          | Germany               | 9                   |
| Rio de Janeiro  | Brazil                | 9                   |
| Cape Town       | South Africa          | 9                   |
| Dubai           | United Arab Emirates  | 8                   |
| Amsterdam       | Netherlands           | 8                   |
| Barcelona       | Spain                 | 8                   |
| Bangkok         | Thailand              | 8                   |
| Phuket          | Thailand              | 7                   |
| Marrakech       | Morocco               | 7                   |
| Vancouver       | Canada                | 7                   |
| Cairo           | Egypt                 | 7                   |
| Auckland        | New Zealand           | 7                   |
| Edinburgh       | Scotland              | 7                   |
| Los Angeles     | USA                   | 7                   |
| Phnom Penh      | Cambodia              | 5                   |

-- ========================
-- 4. **Advanced queries with WITH and JOIN**
-- ========================

-- 10. **Trips longer than the average duration in the same city**
WITH trips AS (
    SELECT city, country, AVG(duration_days) AS average
    FROM trips
    GROUP BY city, country 
)
SELECT t.city, t.country, t.Duration_Days, p.average
FROM trips t 
JOIN trips p ON p.City = t.City AND p.Country = t.Country
WHERE t.Duration_Days > p.average;






