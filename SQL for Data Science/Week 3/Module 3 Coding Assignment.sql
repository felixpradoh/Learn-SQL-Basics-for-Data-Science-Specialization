
-- Question 1
-- Using a subquery, find the names of all the tracks for the album "Californication".

SELECT Name, Albumid
FROM Tracks
WHERE Albumid IN (
    SELECT AlbumId
    FROM Albums
    WHERE Title = 'Californication')

-- What is the title of the 8th track?
-- Answer: Porcelain

-------------------------------------------------------------------------------

-- Question 2
-- Find the total number of invoices for each customer along with the customer's full name, city and email.

SELECT FirstName, LastName, City, Email, COUNT(I.CustomerId) AS Invoices
FROM Customers AS C
INNER JOIN Invoices AS I
ON C.CustomerId = I.CustomerId
GROUP BY C.CustomerId

-- After running the query described above, what is the email address of the 5th person, František Wichterlová? Enter the answer below (feel free to copy and paste).
-- Answer: frantisekw@jetbrains.com

-------------------------------------------------------------------------------

-- Question 3
-- Retrieve the track name, album, artistID, and trackID for all the albums.

SELECT Tracks.Name, Artists.Name AS Artist, Albums.Title AS Album, Tracks.TrackId
FROM (
     (Tracks INNER JOIN Albums ON Tracks.AlbumId = Albums.AlbumId)
     INNER JOIN Artists ON Artists.ArtistId = Albums.AlbumId
)

-- What is the song title of trackID 12 from the "For Those About to Rock We Salute You" album? Enter the answer below.
-- Answer: Breaking The Rules

-------------------------------------------------------------------------------

-- Question 4
-- Retrieve a list with the managers last name, and the last name of the employees who report to him or her.


SELECT M.LastName AS Manager, E.LastName AS Employee
FROM Employees AS E INNER JOIN Employees AS M
ON E.ReportsTo = M.EmployeeID

-- After running the query described above, who are the reports for the manager named Mitchell (select all that apply)?
-- [ ] Edwards
-- [x] Callahan
-- [ ] Johnson
-- [x] King
-- [ ] Park

-------------------------------------------------------------------------------

-- Question 5
-- Find the name and ID of the artists who do not have albums. 

SELECT 
    Artists.Name,
    Artists.ArtistId, 
    Albums.Title
FROM Artists LEFT JOIN Albums ON Artists.ArtistId = Albums.ArtistId
WHERE Albums.Title IS NULL

-- After running the query described above, two of the records returned have the same last name. Enter that name below.
-- Answer: Gilberto

-------------------------------------------------------------------------------

-- Question 6
-- Use a UNION to create a list of all the employee's and customer's first names and last names ordered by the last name in descending order.

SELECT FirstName, LastName
FROM Employees
UNION
SELECT FirstName, LastName
FROM Customers
ORDER BY LastName DESC

-- After running the query described above, determine what is the last name of the 6th record? Enter it below. Remember to order things in descending order to be sure to get the correct answer.
-- Answer: Taylor

-------------------------------------------------------------------------------

-- Question 7
-- See if there are any customers who have a different city listed in their billing city versus their customer city.


SELECT 
    C.FirstName,
    C.LastName,
    C.City AS CustomerCity,
    I.BillingCity
FROM Customers AS C
INNER JOIN Invoices AS I
ON C.CustomerId = I.CustomerId
WHERE CustomerCity != BillingCity

-- Indicate your answer below.
-- [x] No customers have a different city listed in their billing city versus customer city.
-- [ ] 3 customers have a different city listed in their billing city versus customer city.
-- [ ] 8 customers have a different city listed in their billing city versus customer city.
-- [ ] 17 customers have a different city listed in their billing city versus customer city.


