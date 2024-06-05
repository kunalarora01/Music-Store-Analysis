Q1:--Who is the Senior Most Employee based on the Job Title.

Select * from employee
order by Levels DESC
Limit 1

Q2:--Which country has the most invoices ?

Select count(*) c, Billing_country from invoice
Group by Billing_country
Order by 1 DESC
Limit 1

Q3:-- What are the Top 3 of Total Invoice?

Select Total from Invoice
Order by Total DESC
Limit 3

Q4:-- Which city has the best customer in Terms of Revenue

Select Billing_City, Sum(Total) from Invoice
Group by billing_city
Order by Sum(Total) DESC
Limit 1

Q5:-- Best Customer in Terms of Money Spent

Select C.customer_id, C.first_name,last_name , Sum(Total) as Money_Spent from Customer C
Inner Join
invoice I on C.customer_id = I.customer_id
Group by C.customer_id,C.first_name
Order by Money_Spent DESC
Limit 1

Q6: --Write a query to return the email, first_name, last_name & genre of all Rock Music Listeners.
    --Return your output ordered by Email Starting with 'A'.
	
Select C.email, C.first_name, C.last_name from Customer C
Join  Invoice I on C.customer_id = I.customer_id
Join  Invoice_line IL on I.invoice_id = IL.invoice_id
Join  Track T on IL.Track_id = T.Track_id 	
Join  Genre G on T.genre_id = G.genre_id
where G.name = 'Rock'
Group by C.email, C.first_name, C.last_name		
Order by Email ASC

Q7: --Artists with most rock music , Write a query that returns the 
--Artist Name and the total track of count 	of the Top rock bands

Select A.id,A.name , count(A.name) Num_of_Tracks from Artist A 
Join Album2 AM2 on A.id = AM2.Artist_id
Join Track T on AM2.Album_id = T.Album_id
Join Genre G on T.Genre_id = G.Genre_id
where G.name = 'Rock'
Group by A.name, A.id
Order by 3 DESC
Limit 10
	
Q8:--Return all the Track names that have a longer duration than the 
--average duration of Songs. Return the name and milliseconds for each Track
--Order by the Song Length , with the longer first.

Select name , milliseconds from Track
Where milliseconds >
(Select Avg(milliseconds) from Track)
order by 2 DESC

Q9:--Find how much amount spent by each customer on artists ?
--Write a Query to return the customer name , artist and Total Spent

Select C.first_name as Cust_Name, A.name as Artist_Name,Sum(IL.unit_Price * Il.quantity) as Total_Bill	 
From Customer C
	Join Invoice I on C.customer_id = I.customer_id	
	Join Invoice_line IL on I.Invoice_ID = IL.Invoice_ID
	Join Track T on IL.Track_Id= T.Track_Id
	Join album2 ALB on T.Album_Id = ALB.Album_Id
	Join Artist A on A.id = ALB.artist_id
Group by A.name, C.first_name 
Order by 3 Desc  


Q10 :--Most popular genre for each country in terms of Purchases . 

With CTE as 
            (
 Select I.Billing_Country as Country, G.name Genre , Count(IL.Quantity) as Purchses,
	Row_number() over(partition by I.Billing_Country order by Count(IL.Quantity)DESC) as RN		
	 from Invoice I 
  	  Join Invoice_Line IL on I.Invoice_ID = IL.Invoice_id
	  Join Track T on IL.Track_Id = T.Track_id
	  Join Genre G on T.genre_id = G.genre_id
 Group by 1 , 2
 Order by 3 DESC
			
            )
			
Select country , Genre , Purchses from CTE
Where rn =1
order by 3 ASC

Q11:-- A customer that has spent most amount for each country.
--Write a query that returns the country , customer name and Total Spent

With CTE as (
Select C.Customer_id as Cust_id , C.first_name ,
	C.last_Name ,I.Billing_country as Country ,
	Sum(I.Total) as Total_Spent ,
	Row_number() over(Partition by I.Billing_country order by Sum(I.Total) DESC ) as RN
	from Invoice I
Join Customer C on I.Customer_id = C.Customer_id	
Group by 1 , 4
Order by 1 ASC,5 DESC
			)
Select cust_id , first_name , last_name ,country, Total_spent from CTE
Where rn = 1
order by 4 ASC , 5 DESC


