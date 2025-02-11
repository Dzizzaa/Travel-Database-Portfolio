INSERT INTO Trips (City, Country, Start_Date, End_Date, Duration_Days, Accommodation_Type, Accommodation_Cost, Transportation_Type, Transportation_Cost)
SELECT [City], [Country], [Start date], [End date], [Duration (days)], [Accommodation type], [Accommodation cost], [Transportation type], [Transportation cost]
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 
                'Excel 12.0; Database=C:\Users\dzizz\OneDrive\Pulpit\cv iza\projekt\cleaned_file_travel_excel.xlsx; HDR=YES', 
                'SELECT * FROM [a$]')

INSERT INTO Travelers (Name, Age, Gender, Nationality)
SELECT  [Traveler name], [Traveler age] , [Traveler gender], [Traveler nationality]
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 
                'Excel 12.0; Database=C:\Users\dzizz\OneDrive\Pulpit\cv iza\projekt\cleaned_file_travel_excel.xlsx; HDR=YES', 
                'SELECT * FROM [a$]')
