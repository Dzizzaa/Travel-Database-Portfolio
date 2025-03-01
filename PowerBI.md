# Power BI - Travel Data Analysis

## Project Description

This project presents an interactive analysis of travel data using Power BI. The main goal was to create a report that allows a detailed analysis of travel data, such as the number of cities and countries visited, transportation costs, accommodation expenses, and days spent in different locations. The project uses a variety of visualizations that enable dynamic interaction with the data, allowing filtering by year, country, and accommodation type. In this project, I connected to a SQL Server database to retrieve data and import it into Power BI. This allowed me to perform the analysis and visualization of the data, which was then used in the Power BI report.

## Report Elements

- **Country Slicer**: Allows the selection of a country, enabling dynamic data filtering.
- **Card with the number of cities and countries and number of trips**: Displays the total number of visited places and completed trips.
- **Year Slicer**: Allows the selection of a year, enabling data analysis for specific periods.
- **Pie Chart - Gender Distribution**: Visualizes the gender distribution of travelers.
- **Grouped Bar Chart - Days Spent in Different Countries**: Shows the number of days travelers spent in various countries.
- **Pie Chart - Transportation Costs**: Displays the proportion of transportation costs in the overall trip expenses.
- **Pie Chart - Accommodation Costs**: Visualizes the distribution of accommodation costs.
- **Bar Chart - Total Cost for Each Country**: Displays the total cost of trips in different countries.
- **Tree Map - Nationality and Accommodation Type**: Visualizes data about travelers' nationalities and accommodation preferences.
- **World Map with Labels**: Displays data on a map, where hovering over a country shows information: country name, total cost, transportation cost, average days, and accommodation cost (using a tooltip).

## Data Source

The data for the analysis was obtained from the public dataset "Traveler Trip Data" available on Kaggle. It contains information about trips and travelers, including their nationality, trip duration, and costs related to transportation and accommodation.

## Project Scope

The report allows for a detailed analysis of travel data, enabling dynamic filtering and interaction with the data. Thanks to the use of various types of visualizations, such as pie charts, bar charts, and maps, users can easily obtain information about expenses, travel time, and other key aspects of trips in different countries.

## Created Measures

- **Number of Countries** – Number of visited countries
- **Number of City** – Number of cities visited during the trips
- **AVG days** – Average number of days spent in a given country or city
- **Total_Cost** – Total cost of the trip

### Time Measures

- **Year_Start** – A measure calculating the year the trip started based on the start date:
  ```sql
  Year_Start = YEAR('Trips'[Start_Date])

- **Total_Travel_Days** – miara sumująca liczbę dni podróż:
  ```DAX
  Total_Travel_Days = SUM('Trips'[Duration_Days]) 








# Power BI - Analiza danych podróży

## Opis projektu
Projekt przedstawia interaktywną analizę danych podróży z wykorzystaniem Power BI. Głównym celem było stworzenie raportu, który umożliwia szczegółową analizę danych podróżniczych, takich jak liczba odwiedzonych miast i krajów, koszty transportu, zakwaterowania oraz dni spędzonych w różnych miejscach. W projekcie zastosowano szereg wizualizacji, które pozwalają na dynamiczną interakcję z danymi, umożliwiając filtrację według roku, kraju i typu zakwaterowania. W ramach projektu połączyłam się z bazą danych SQL Server, aby pobrać dane i zaimportować je do Power BI. Dzięki temu mogłam przeprowadzić analizę i wizualizację danych, które następnie wykorzystałam w raporcie w Power BI.



## Elementy raportu

- **Fragmentator z krajami**: Umożliwia wybór kraju, co pozwala na dynamiczne filtrowanie danych.
- **Karta z liczbą miast i krajów oraz liczba podróży**: Prezentuje ogólną liczbę odwiedzonych miejsc i odbytych podróży.
- **Fragmentator roku**: Pozwala na wybór roku, umożliwiając analizę danych w zależności od okresu.
- **Wykres kołowy - Podział płci**: Wizualizuje rozkład płci podróżników.
- **Wykres słupkowy grupowy - Dni spędzone w poszczególnych krajach**: Przedstawia liczbę dni spędzonych przez podróżników w różnych krajach.
- **Wykres kołowy - Koszty transportu**: Pokazuje udział kosztów transportu w ogólnych wydatkach podróży.
- **Wykres kołowy - Koszty zakwaterowania**: Wizualizuje podział kosztów zakwaterowania.
- **Wykres słupkowy - Całkowity koszt dla poszczególnych krajów**: Prezentuje łączny koszt podróży w różnych krajach.
- **Mapa drzewa - Narodowość i typ zakwaterowania**: Wizualizuje dane dotyczące narodowości podróżników oraz preferencje dotyczące zakwaterowania.
- **Mapa świata z etykietami**: Prezentuje dane w postaci mapy, gdzie po najechaniu na dany kraj wyświetlają się informacje: kraj, całkowity koszt, suma kosztów transportu, średnia liczba dni oraz suma kosztów zakwaterowania (przy użyciu tooltipu).

## Źródło danych
Dane do analizy zostały pobrane z publicznego zbioru danych "Traveler Trip Data" dostępnego na platformie Kaggle. Zawierają one informacje o podróżach oraz o podróżnikach, w tym ich narodowości, czas podróży oraz koszty związane z transportem i zakwaterowaniem.

## Zakres projektu
Raport pozwala na szczegółową analizę danych podróży, umożliwiając dynamiczne filtrowanie i interakcję z danymi. Dzięki zastosowaniu różnych typów wizualizacji, takich jak wykresy kołowe, słupkowe i mapy, użytkownik może łatwo uzyskać informacje na temat wydatków, czasu podróży i innych istotnych aspektów podróży w różnych krajach.

## Utworzone miary

- **LiczbaKrajow** – liczba odwiedzonych krajów,
- **LiczbaMiast** – liczba miast odwiedzonych w ramach podróży,
- **ŚredniaLiczbaDni** – średnia liczba dni spędzonych w danym kraju lub mieście,
- **TotalCost** – całkowity koszt podróży.

## Miary czasowe

- **Year_Start** – miara obliczająca rok rozpoczęcia podróży na podstawie daty początkowej:
  ```DAX
  Year_Start = YEAR('Trips'[Start_Date])
- **Total_Travel_Days** – miara sumująca liczbę dni podróż:
  ```DAX
  Total_Travel_Days = SUM('Trips'[Duration_Days]) 

## Strona 1 - Mapa Świata z etykietami

Na pierwszej stronie raportu znajduje się Mapa świata z etykietami, która prezentuje dane w postaci interaktywnej mapy. Po najechaniu na dany kraj, wyświetlają się następujące informacje:

- Country – nazwa kraju
- Total_Cost – całkowity koszt podróży w tym kraju
- Transporartion_Cost – całkowity koszt transportu
- AVG days – tooltip -średnia liczba dni spędzonych w tym kraju
- Accommodation_Cost – całkowity koszt zakwaterowania

![image](https://github.com/user-attachments/assets/5b037173-df90-4aa1-9aee-d0783698c62d)

![image](https://github.com/user-attachments/assets/ebd61c7f-c55c-4d94-b86e-4c4b918285c5)


## Strona 2 - Raport


Na drugiej stronie raportu znajdują się następujące wizualizacje:

- **Fragmentator z krajami**: Umożliwia wybór kraju, co pozwala na dynamiczne filtrowanie danych.
- **Karta z liczbą miast i krajów oraz liczbą podróży**: Prezentuje ogólną liczbę odwiedzonych miejsc oraz odbytych podróży.
- **Fragmentator roku**: Pozwala na wybór roku, umożliwiając analizę danych w zależności od okresu.
- **Wykres kołowy - Podział płci**: Wizualizuje procentowy rozkład płci podróżników.
- **Wykres słupkowy grupowy - Dni spędzone w poszczególnych krajach**: Przedstawia liczbę dni spędzonych przez podróżników w różnych krajach.
- **Wykres kołowy - Koszty transportu**: Pokazuje udział kosztów transportu w ogólnych wydatkach podróży.
- **Wykres kołowy - Koszty zakwaterowania**: Wizualizuje podział kosztów zakwaterowania.
- **Wykres słupkowy - Całkowity koszt dla poszczególnych krajów**: Prezentuje łączny koszt podróży w różnych krajach.
- **Mapa drzewa - Narodowość i typ zakwaterowania**: Wizualizuje dane dotyczące narodowości podróżników oraz preferencje dotyczące zakwaterowania.
  




![Zrzut ekranu 2025-03-01 132801](https://github.com/user-attachments/assets/523e4189-801f-478e-ac33-d579ebf47abc)




