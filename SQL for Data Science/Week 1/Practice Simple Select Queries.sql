-- ========================================================================================================
-- To prepare for the graded coding quiz, you will be asked to execute a query, read the results, 
-- and select the  answer you found in the results. This question is for you to practice executing queries.
-- I have provided you the script for this query, a simple select statement. 
-- Think of this as a sandbox for you to practice. As you practice executing queries, 
-- take time to read the results in order to prepare for the quiz and get comfortable writing a basic
-- select statement. 
-- ========================================================================================================


-- Question 1

-- Run query: Retrieve all the data from the tracks table. Who is the composer for track 18?

SELECT *
FROM Tracks;

-- Answer: Bad Boy Boogie

-------------------------------------------------------------------------------

-- Question 2

-- Run Query: Retrieve all data from the artists table. Look at the list of artists, 
-- how many artists are you familiar with (there is no wrong answer here)?

SELECT *
FROM Artists;

-- Answer: 5

-------------------------------------------------------------------------------

-- Question 3

-- Run Query: Retrieve all data from the invoices table. What is the billing address for customer 31?

SELECT *
FROM Invoices;

-- Answer: 194A Chain Lake Drive

--------------------------------------------------------------------------------

-- Question 4

-- Run Query: Return the playlist id, and name from the playlists table.
--  How many playlists are there? Which would you classify is your favorite from this list?

SELECT Playlistid, Name
FROM Playlists;

-- Answer: 15. Movies

--------------------------------------------------------------------------------

-- Question 5

-- Run Query: Return the Customer Id, Invoice Date, and Billing City from the Invoices table. 
-- What city is associated with Customer ID number 42? What was the invoice date for the customer in Santiago?

SELECT CustomerId,InvoiceDate, BillingCity 
FROM Invoices;

-- Answer: Bordeaux

--------------------------------------------------------------------------------

-- Question 6

-- Run Query: Return the First Name, Last Name, Email, and Phone, from the Customers table. 
-- What is the telephone number for Jennifer Peterson?

SELECT FirstName, LastName, Email, Phone
FROM Customers;

-- Answer: +1 (604) 688-2255

-------------------------------------------------------------------------------
-- Question 7

-- Run Query: Return the Track Id, Genre Id, Composer, Unit Price from the Tracks table. 
-- How much do these tracks cost?

SELECT TrackId, GenreId,Composer, UnitPrice 
FROM Tracks;

-- Answer: 0.99

-------------------------------------------------------------------------------

-- Question 8

-- Run Query: SELECT all the columns from the Playlist Track table and limit the results to 10 records. 
-- How might this information be used?


SELECT *
FROM Playlist_track 
LIMIT 10;

-- Answer: Somehow

-------------------------------------------------------------------------------

-- Question 9

-- Run Query: SELECT all the columns from the Media Types table and limit the results to 50 records.
-- What happened when you ran this query? Were you able to get all 50 records?


SELECT *
FROM Media_types
LIMIT 50;

-- Answer: There are not 50 records, so it just shows the maximum of them up to 50

-------------------------------------------------------------------------------

-- Question 10

-- Run Query: SELECT all the columns from the Albums table and limit the results to 5 records. 
-- How many columns are in the albums table? 
-- What is the name of the 9th album in this list?

SELECT *
FROM Albums
LIMIT 5;

-- Answer: 3

-------------------------------------------------------------------------------