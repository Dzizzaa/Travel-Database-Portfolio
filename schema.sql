---Dodano strukturę bazy danych (schema.sql)

CREATE TABLE Trips (
    TripID INT PRIMARY KEY IDENTITY(1,1),
    City VARCHAR(255),
    Country VARCHAR(255),
    Start_Date DATE,
    End_Date DATE,
    Duration_Days INT,
    Accommodation_Type VARCHAR(255),
    Accommodation_Cost FLOAT,
    Transportation_Type VARCHAR(255),
    Transportation_Cost FLOAT 
);



CREATE TABLE Travelers (
    TravelerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255),
    Age FLOAT,
    Gender VARCHAR(20),
    Nationality VARCHAR(255)

);

CREATE TABLE Trip_Travelers (
    TripID INT,
    TravelerID INT,
    PRIMARY KEY (TripID, TravelerID),
    FOREIGN KEY (TripID) REFERENCES Trips(TripID),
    FOREIGN KEY (TravelerID) REFERENCES Travelers(TravelerID)
);
