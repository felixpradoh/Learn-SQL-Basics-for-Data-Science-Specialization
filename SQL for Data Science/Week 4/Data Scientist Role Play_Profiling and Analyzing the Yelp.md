# Data Scientist Role Play: Profiling and Analyzing the Yelp Dataset Coursera Worksheet

This is a 2-part assignment. In the first part, you are asked a series of questions that will help you profile and understand the data just like a data scientist would. For this first part of the assignment, you will be assessed both on the correctness of your findings, as well as the code you used to arrive at your answer. You will be graded on how easy your code is to read, so remember to use proper formatting and comments where necessary.

In the second part of the assignment, you are asked to come up with your own inferences and analysis of the data for a particular research question you want to answer. You will be required to prepare the dataset for the analysis you choose to do. As with the first part, you will be graded, in part, on how easy your code is to read, so use proper formatting and comments to illustrate and communicate your intent as required.

For both parts of this assignment, use this "worksheet." It provides all the questions you are being asked, and your job will be to transfer your answers and SQL coding where indicated into this worksheet so that your peers can review your work. You should be able to use any Text Editor (Windows Notepad, Apple TextEdit, Notepad ++, Sublime Text, etc.) to copy and paste your answers. If you are going to use Word or some other page layout application, just be careful to make sure your answers and code are lined appropriately.
In this case, you may want to save as a PDF to ensure your formatting remains intact for you reviewer.


__Part 1: Yelp Dataset Profiling and Understanding__

1. Profile the data by finding the total number of records for each of the tables below:

	i. Attribute table = 10000 

	ii. Business table = 10000
	
	iii. Category table = 10000
	
	iv. Checkin table = 10000

	v. elite_years table = 10000

	vi. friend table = 10000

	vii. hours table = 10000

	viii. photo table = 10000

	ix. review table = 10000

	x. tip table = 10000

	xi. user table = 10000
	

2. Find the total distinct records by either the foreign key or primary key for each table. If two foreign keys are listed in the table, please specify which foreign key.

	i. Business = id-10000

	ii. Hours = business_id-1562

	iii. Category = business_id-2643 

	iv. Attribute = business_id-1115

	v. Review = id-10000, user_id-9581, business_id-8090

	vi. Checkin = business_id-493 

	vii. Photo = id-10000, business_id-6493 

	viii. Tip = user_id-537, business_id-3979 

	ix. User = id-10000

	x. Friend = user_id-11 

	xi. Elite_years = user_id-2780


	*Note: Primary Keys are denoted in the ER-Diagram with a yellow key icon.*



3. Are there any columns with null values in the Users table? Indicate "yes," or "no."

	Answer: no
	
	SQL code used to arrive at answer:

	``` sql

	SELECT COUNT(*)
	FROM user
	WHERE id IS NULL
		OR name IS NULL
		OR review_count IS NULL
		OR yelping_since IS NULL
		OR useful IS NULL
		OR funny IS NULL
		OR cool IS NULL
		OR fans IS NULL
		OR average_stars IS NULL
		OR compliment_hot IS NULL
		OR compliment_more IS NULL
		OR compliment_profile IS NULL
		OR compliment_cute IS NULL
		OR compliment_list IS NULL
		OR compliment_note IS NULL
		OR compliment_plain IS NULL
		OR compliment_cool IS NULL
		OR compliment_funny IS NULL
		OR compliment_writer IS NULL
		OR compliment_photos IS NULL
	```
	
4. For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields:

	i. Table: Review, Column: Stars
	
		min:1		max:5		avg:3.7082
		
	
	ii. Table: Business, Column: Stars
	
		min:1.0		max:5.0		avg:3.6549
		
	
	iii. Table: Tip, Column: Likes
	
		min:0		max:2		avg:0.0144
		
	
	iv. Table: Checkin, Column: Count
	
		min:1		max:53		avg:1.9414
		
	
	v. Table: User, Column: Review_count
	
		min:0		max:2000		avg:24.2995
		


5. List the cities with the most reviews in descending order:

	SQL code used to arrive at answer:
	
	``` sql
	SELECT city, SUM(review_count) AS SumReviews
	FROM business
	GROUP BY city
	ORDER BY SumReviews DESC
	
	Copy and Paste the Result Below:
	+-----------------+------------+
	| city            | SumReviews |
	+-----------------+------------+
	| Las Vegas       |      82854 |
	| Phoenix         |      34503 |
	| Toronto         |      24113 |
	| Scottsdale      |      20614 |
	| Charlotte       |      12523 |
	| Henderson       |      10871 |
	| Tempe           |      10504 |
	| Pittsburgh      |       9798 |
	| Montréal        |       9448 |
	| Chandler        |       8112 |
	| Mesa            |       6875 |
	| Gilbert         |       6380 |
	| Cleveland       |       5593 |
	| Madison         |       5265 |
	| Glendale        |       4406 |
	| Mississauga     |       3814 |
	| Edinburgh       |       2792 |
	| Peoria          |       2624 |
	| North Las Vegas |       2438 |
	| Markham         |       2352 |
	| Champaign       |       2029 |
	| Stuttgart       |       1849 |
	| Surprise        |       1520 |
	| Lakewood        |       1465 |
	| Goodyear        |       1155 |
	+-----------------+------------+
	(Output limit exceeded, 25 of 362 total rows shown)
	```
	
6. Find the distribution of star ratings to the business in the following cities:

	i. Avon

	SQL code used to arrive at answer:

	``` sql
	SELECT stars, SUM(review_count) AS SumReview
	FROM business
	WHERE City = 'Avon'
	GROUP BY stars
	```

	Copy and Paste the Resulting Table Below (2 columns â€“ star rating and count):

		+-------+-----------+
		| stars | SumReview |
		+-------+-----------+
		|   1.5 |        10 |
		|   2.5 |         6 |
		|   3.5 |        88 |
		|   4.0 |        21 |
		|   4.5 |        31 |
		|   5.0 |         3 |
		+-------+-----------

	ii. Beachwood

	SQL code used to arrive at answer:

	```sql
	SELECT stars, SUM(review_count) AS SumReview
	FROM business
	WHERE City = 'Beachwood'
	GROUP BY stars
	```

	Copy and Paste the Resulting Table Below (2 columns â€“ star rating and count):
			
		+-------+-----------+
		| stars | SumReview |
		+-------+-----------+
		|   2.0 |         8 |
		|   2.5 |         3 |
		|   3.0 |        11 |
		|   3.5 |         6 |
		|   4.0 |        69 |
		|   4.5 |        17 |
		|   5.0 |        23 |
		+-------+-----------+

7. Find the top 3 users based on their total number of reviews:
		
	SQL code used to arrive at answer:
	
	```sql
	SELECT name, review_count
	FROM user
	ORDER BY review_count DESC
	LIMIT 3
	```

	Copy and Paste the Result Below:

		+--------+--------------+
		| name   | review_count |
		+--------+--------------+
		| Gerald |         2000 |
		| Sara   |         1629 |
		| Yuri   |         1339 |
		+--------+--------------+

8. Does posing more reviews correlate with more fans?

	Please explain your findings and interpretation of the results:
	No, it does not follow a correlation. Most probably the number of reviews depends also yelping_since, publicity and some other factors.

	
9. Are there more reviews with the word "love" or with the word "hate" in them?

	Answer:
	There are more 'love' words in text than 'hate'

	SQL code used to arrive at answer:
	```sql
	SELECT COUNT(*) AS LoveCounts
	FROM review
	WHERE text LIKE '%love%'
	-------------------------------
	SELECT COUNT(*) AS HateCounts
	FROM review
	WHERE text LIKE '%hate%'
	```
	
10. Find the top 10 users with the most fans:

	SQL code used to arrive at answer:

	```sql
	SELECT name, fans
	FROM user
	ORDER BY fans DESC
	LIMIT 10
	```

	Copy and Paste the Result Below:

		+-----------+------+
		| name      | fans |
		+-----------+------+
		| Amy       |  503 |
		| Mimi      |  497 |
		| Harald    |  311 |
		| Gerald    |  253 |
		| Christine |  173 |
		| Lisa      |  159 |
		| Cat       |  133 |
		| William   |  126 |
		| Fran      |  124 |
		| Lissa     |  120 |
		+-----------+------+
		

__Part 2: Inferences and Analysis__

1. Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.
	
	I have chosen the 'Phoenix' as city and 'Restaurants' as category.
	
	i. Do the two groups you chose to analyze have a different distribution of hours?

		Yes, they ahve different distributioni of hours. Those with stars between 2-3 stars have extreme opening hours from early in the morning to very late in the night, as an indicative of fast food chain. Restaurants with 4-5 starts have reasonable and standard openng hours.

	ii. Do the two groups you chose to analyze have a different number of reviews?

		Yes, they have different number of reviews. Restaurants with 4-5 stars have four times more reviews together thant 2-3 together.
			
			
	iii. Are you able to infer anything from the location data provided between these two groups? Explain.

		It seems like in Phoenix people that go to high stand restaurants are more prone to have a good review, while fast food Restaurants do not receive many reviews, basically because people do not expect anything good from them.

	SQL code used for analysis:

	```sql
		SELECT 
			business.name,
			business.city,
			category.category,
			business.stars,
			hours.hours,
			business.review_count
		FROM (business INNER JOIN category ON business.id = category.business_id)
		INNER JOIN hours ON hours.business_id = business.id
		WHERE business.city = 'Phoenix'
			AND category.category LIKE '%Restaurants%'
		GROUP BY business.stars
	```
	```sql
		+----------------------------------------+---------+-------------+-------+----------------------+--------------+
		| name                                   | city    | category    | stars | hours                | review_count |
		+----------------------------------------+---------+-------------+-------+----------------------+--------------+
		| McDonald's                             | Phoenix | Restaurants |   2.0 | Saturday|5:00-0:00   |            8 |
		| Gallagher's                            | Phoenix | Restaurants |   3.0 | Saturday|9:00-2:00   |           60 |
		| Five Guys                              | Phoenix | Restaurants |   3.5 | Saturday|10:00-22:00 |           63 |
		| Bootleggers Modern American Smokehouse | Phoenix | Restaurants |   4.0 | Saturday|11:00-22:00 |          431 |
		| Charlie D's Catfish & Chicken          | Phoenix | Restaurants |   4.5 | Saturday|11:00-18:00 |            7 |
		+----------------------------------------+---------+-------------+-------+----------------------+--------------+
	```
		
2. Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.
		
	i. Difference 1:
			Restaurants that are closed have a slight lower average (3.52) than those that remain open (3.67), which is interesting in order to analyze where is the threshold average for this parameter.
			
	ii. Difference 2:
			Restaurants that are closed have a lower average number of reviews (aprox 23) than those that are still open (31.76). This does not say anything because it should be normalized to the closed date. If it is open, it will have more reviews...
         

	SQL code used for analysis:
	```sql
		SELECT AVG(review_count), AVG(stars), is_open
		FROM business
		GROUP BY is_open
	```
	
	
3. For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.

	Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, and so on. These are just a few examples to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
	
	i. Indicate the type of analysis you chose to do:
		*A comparison between the average review vs the average check-ins in the Restaurants*
			
	ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:
		*Comparing the parameters above would help to see if there is a correlation between the number of reviews and checkings, as an indicator of how many people uses Yelp.*
					
	iii. Output of your finished dataset:
	```sql
		+---------------------+--------------+
		| AVG(B.review_count) | AVG(C.count) |
		+---------------------+--------------+
		|       13.5980392157 | 1.6431372549 |
		+---------------------+--------------+
	```	
	iv. Provide the SQL code you used to create your final dataset:
	```sql
		SELECT AVG(B.review_count), AVG(C.count)
		FROM business AS B
		INNER JOIN checkin AS C ON B.id = C.business_id
	```