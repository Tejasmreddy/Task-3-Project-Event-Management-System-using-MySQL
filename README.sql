# Task-3-Project-Event-Management-System-using-MySQL

Task 3
Project: Event Management System using PostgreSQL.
Objective: To develop the application that allows users to create and manage events, track
attendees, and handle event registrations efficiently. The project will include the following
tasks:

1.Database Creation
Create a database named "EventsManagement."
Create tables for Events, Attendees, and Registrations.
Events- Event_Id, Event_Name, Event_Date, Event_Location, Event_Description
Attendees- Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City
Registrations-Registration_id, Event_Id, Attendee_Id,Registration_Date,Registration_Amount.
The FOREIGN KEY constraint in the Registrations table references the Event_Id column in the
Events table and the Attendee_Id column in the Attendees table.

-- Create the database
CREATE DATABASE EventsManagement;

-- Use the database
USE EventsManagement;

-- Create Events table
CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location VARCHAR(200) NOT NULL,
    Event_Description TEXT
);

-- Create Attendees table
CREATE TABLE Attendees (
    Attendee_Id INT PRIMARY KEY,
    Attendee_Name VARCHAR(100) NOT NULL,
    Attendee_Phone VARCHAR(20) NOT NULL,
    Attendee_Email VARCHAR(100) NOT NULL,
    Attendee_City VARCHAR(50) NOT NULL
);

-- Create Registrations table with foreign key constraints
CREATE TABLE Registrations (
    Registration_Id INT PRIMARY KEY,
    Event_Id INT NOT NULL,
    Attendee_Id INT NOT NULL,
    Registration_Date DATE NOT NULL,
    Registration_Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);



2.Data Creation
Insert some sample data for Events, Attendees, and Registrations tables with respective fields.

-- Insert data into Events table
INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) VALUES
(1, 'Tech Conference 2025', '2025-08-15', 'Silicon Valley Convention Center', 'Annual technology conference featuring AI and ML'),
(2, 'Music Festival', '2025-09-20', 'Central Park', 'Summer music festival with international artists'),
(3, 'Business Summit', '2025-10-05', 'Grand Hotel', 'Leadership and entrepreneurship summit'),
(4, 'Food & Wine Expo', '2025-07-30', 'City Convention Hall', 'International food and wine tasting event'),
(5, 'Art Exhibition', '2025-08-25', 'National Art Gallery', 'Modern art showcase featuring local artists');

-- Insert data into Attendees table
INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) VALUES
(101, 'John Smith', '555-0101', 'john.smith@email.com', 'New York'),
(102, 'Sarah Johnson', '555-0102', 'sarah.j@email.com', 'Los Angeles'),
(103, 'Michael Brown', '555-0103', 'michael.b@email.com', 'Chicago'),
(104, 'Emma Davis', '555-0104', 'emma.d@email.com', 'San Francisco'),
(105, 'James Wilson', '555-0105', 'james.w@email.com', 'Boston'),
(106, 'Lisa Anderson', '555-0106', 'lisa.a@email.com', 'Seattle'),
(107, 'Robert Taylor', '555-0107', 'robert.t@email.com', 'Miami');

-- Insert data into Registrations table
INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount) VALUES
(1001, 1, 101, '2025-06-15', 299.99),
(1002, 1, 102, '2025-06-16', 299.99),
(1003, 2, 103, '2025-07-01', 149.50),
(1004, 2, 104, '2025-07-02', 149.50),
(1005, 3, 105, '2025-08-10', 499.99),
(1006, 4, 106, '2025-06-25', 75.00),
(1007, 4, 107, '2025-06-26', 75.00),
(1008, 5, 102, '2025-07-15', 25.00),
(1009, 3, 101, '2025-08-11', 499.99),
(1010, 5, 104, '2025-07-16', 25.00);



3. Manage Event Details
a) Inserting a new event.

INSERT INTO EVENTS 
VALUES (6, 'Yoga session', '2025-09-25' , ' Central Park ' , ' Beginner Yoga session');


b) Updating an event's information.

UPDATE EVENTS
SET EVENT_LOCATION = 'City Dome',
    EVENT_DATE = '2025-09-28' 
WHERE EVENT_ID = '2'


c) Deleting an event.

-- First delete registrations for Event_Id = 1

DELETE FROM Registrations 
WHERE Event_Id = 1;

-- Then delete the event
DELETE FROM Events 
WHERE Event_Id = 1;

DELETE FROM EVENTS 
WHERE EVENT_ID = 1;


4) Manage Track Attendees & Handle Events
a)Inserting a new attendee.

INSERT INTO ATTENDEES
VALUES (108,'FORD CLIFF','555-0133','ford.c@email.com','LOS VEGAS') ;

b)Registering an attendee for an event.

INSERT INTO Registrations 
VALUES (1011, 6, 108, '2025-06-15', 25.99) ; 

5.Develop queries to retrieve event information, generate attendee lists, and calculate event
attendance statistics.


SELECT 
    -- Event Information
    E.Event_Id,
    E.Event_Name,
    E.Event_Date,
    E.Event_Location,
    
      -- Attendance Statistics
    COUNT(DISTINCT A.Attendee_Id) as Total_Attendees,
    COUNT(DISTINCT R.Attendee_Id) as Total_Registrations,
    
    -- Attendee Names List
    GROUP_CONCAT(
        DISTINCT A.Attendee_Name 
        ORDER BY A.Attendee_Name 
        SEPARATOR ', '
    ) as Attendee_List
    
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
LEFT JOIN Attendees A ON R.Attendee_Id = A.Attendee_Id

GROUP BY 
    E.Event_Id,
    E.Event_Name,
    E.Event_Date,
    E.Event_Location

ORDER BY E.Event_Date;




