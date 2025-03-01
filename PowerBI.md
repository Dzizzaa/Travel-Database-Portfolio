# Power BI - Analiza danych podróży

## Opis projektu
Projekt przedstawia interaktywną analizę danych podróży z wykorzystaniem Power BI. Głównym celem było stworzenie raportu, który umożliwia szczegółową analizę danych podróżniczych, takich jak liczba odwiedzonych miast i krajów, koszty transportu, zakwaterowania oraz dni spędzonych w różnych miejscach. W projekcie zastosowano szereg wizualizacji, które pozwalają na dynamiczną interakcję z danymi, umożliwiając filtrację według roku, kraju i typu zakwaterowania. W ramach projektu połączyłam się z bazą danych SQL Server, aby pobrać dane i zaimportować je do Power BI. Dzięki temu mogłam przeprowadzić analizę i wizualizację danych, które następnie wykorzystałam w raporcie w Power BI.



## Elementy raportu

- **Fragmentator z krajami**: Umożliwia wybór kraju, co pozwala na dynamiczne filtrowanie danych.
- **Karta z liczbą miast i krajów oraz liczba podróży**: Prezentuje ogólną liczbę odwiedzonych miejsc i odbytych podróży.
- **Fragmentator roku**: Pozwala na wybór roku, umożliwiając analizę danych w zależności od okresu.
- **Wykres kołowy - Podział płci**: Wizualizuje procentowy rozkład płci podróżników.
- **Wykres słupkowy grupowy - Dni spędzone w poszczególnych krajach**: Przedstawia liczbę dni spędzonych przez podróżników w różnych krajach.
- **Wykres kołowy - Koszty transportu**: Pokazuje udział kosztów transportu w ogólnych wydatkach podróży.
- **Wykres kołowy - Koszty zakwaterowania**: Wizualizuje podział kosztów zakwaterowania.
- **Wykres słupkowy - Całkowity koszt dla poszczególnych krajów**: Prezentuje łączny koszt podróży w różnych krajach.
- **Mapa drzewa - Narodowość i typ zakwaterowania**: Wizualizuje dane dotyczące narodowości podróżników oraz preferencje dotyczące zakwaterowania.
- **Mapa świata z bąbelkami**: Prezentuje dane w postaci mapy, gdzie po najechaniu na bąbelek w danym kraju wyświetlają się informacje: kraj, całkowity koszt, suma kosztów transportu, średnia liczba dni oraz suma kosztów zakwaterowania (przy użyciu tooltipu).

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

## Strona 1 - Mapa Świata z Bąbelkami

Na pierwszej stronie raportu znajduje się Mapa świata z bąbelkami, która prezentuje dane w postaci interaktywnej mapy. Po najechaniu na bąbelek w danym kraju, wyświetlają się następujące informacje:

- Kraj – nazwa kraju
- Całkowity koszt – całkowity koszt podróży w tym kraju
- Suma kosztów transportu – całkowity koszt transportu
- Średnia liczba dni – średnia liczba dni spędzonych w tym kraju
- Suma kosztów zakwaterowania – całkowity koszt zakwaterowania

Informacje te są wyświetlane za pomocą **tooltipu**, który pojawiają się po najechaniu na bąbelek.

![image](https://github.com/user-attachments/assets/e9832148-7228-4a35-83d5-74e1465a8e56)
![image](https://github.com/user-attachments/assets/3a8d4653-b73c-48d6-82e5-a735eae9bfdd)

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
  

![Zrzut ekranu 2025-03-01 132815](https://github.com/user-attachments/assets/3ec4eb16-43d7-47e0-a179-656d601d958f)





