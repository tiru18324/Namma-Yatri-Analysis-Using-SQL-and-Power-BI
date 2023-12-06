select * from [Namma Yatri].[dbo].[assembly]; 
select * from [Namma Yatri].[dbo].[trips]; 

-- From trips table which are successful that are that will be stored in trip details table 

-- Total trips 
select count(distinct tripid) from [Namma Yatri].[dbo].[trip_details];
 

-- Check duplicates in trip details 
select tripid,count(tripid) cnt from [Namma Yatri].[dbo].[trip_details] 
group by tripid 
having count(tripid)>1; 

--Total drivers 
select count(distinct driverid) from [Namma Yatri].[dbo].[trips] 

-- Total Earnings 
select sum(fare) fare from [Namma Yatri].[dbo].[trips]; 

-- Total Completed Trips 
select count(distinct tripid) from [Namma Yatri].[dbo].[trips];

-- Total Searches 
select sum(searches) searches from [Namma Yatri].[dbo].[trip_details]

-- Total Searches which got estimate 
select sum(searches_got_estimate) searches from [Namma Yatri].[dbo].[trip_details]; 

-- Total searches for quotes 
select sum(searches_for_quotes) search from [Namma Yatri].[dbo].[trip_details];

-- total searches who got quotes 
select sum(searches_got_quotes) quotes from [Namma Yatri].[dbo].[trip_details];

-- total driver cancelled 
select count(*)-sum(driver_not_cancelled) cancel from [Namma Yatri].[dbo].[trip_details]

--Total OTP Entered 
select sum(otp_entered) otp from [Namma Yatri].[dbo].[trip_details];

--Total Ended Rides 
select sum(end_ride) Ended from [Namma Yatri].[dbo].[trip_details];


-- Average Distance Per Trip 
select avg(distance) Avg from [Namma Yatri].[dbo].[trips]; 


-- Average fare Per Trip 
select avg(fare) Fare from [Namma Yatri].[dbo].[trips]; 


-- Distance Travelled 
select sum(distance) Distance from [Namma Yatri].[dbo].[trips]; 

--what is most used payment method 
select a.method from [Namma Yatri].[dbo].[payment] a inner join 
(select top 1 faremethod,count(distinct tripid) cnt from [Namma Yatri].[dbo].[trips] 
group by faremethod 
order by count(distinct tripid) desc) b 
on a.id=b.faremethod; 

-- Highest Payment Made Through by? 

select a.method from [Namma Yatri].[dbo].[payment] a inner join 
(select top 1 * from [Namma Yatri].[dbo].[trips]
order by fare desc) b 
on a.id=b.faremethod; 


--which 2 location had most number of trips 

select * from
(select *,dense_rank() over (order by cnt desc) rnk
from
(select loc_from,loc_to,count(distinct tripid) cnt from [Namma Yatri].[dbo].[trips] 
group by loc_from,loc_to)a)b
where rnk=1; 
 

--Top 5 Earning Drivers 

select * from 
(select *,dense_rank() over(order by fare desc) rnk 
from 
(select driverid,sum(fare) fare from [Namma Yatri].[dbo].[trips] 
group by driverid)b)c where rnk<6; 


--Which Duration Has More Number Of Trips 
select * from 
(select *,rank() over(order by cnt desc) rnk from
(select duration,count(distinct tripid) cnt from [Namma Yatri].[dbo].[trips] 
group by duration)b)c 
where rnk=1; 

--which driver,customer pair had more Orders 
select * from 
(select *,rank() over(order by cnt desc) rnk from 
(select driverId,custId,count(distinct tripid) cnt from [Namma Yatri].[dbo].[trips]  
group by driverid,custid)c)d 
where rnk=1;


--search to estimate rate 
select sum(searches_got_estimate)*100.0/sum(searches) estimate from [Namma Yatri].[dbo].[trip_details]  

--estimate to search for quote rate 
select sum(searches_got_quotes)*100.0/sum(searches) from [Namma Yatri].[dbo].[trip_details];
--quote to booking rate
select sum(searches_got_quotes)*100.0/sum(searches) from [Namma Yatri].[dbo].[trip_details];


--booking cancellation rate 
SELECT 100 - b.ca AS CancellationRate
FROM (
    SELECT SUM(customer_not_cancelled) * 100.0 / SUM(searches) AS ca
    FROM [Namma Yatri].[dbo].[trip_details]
) b;

--which location got the higher number of trips in each duration present
select * from
(select *,rank()  over(partition by duration order by cnt desc) rnk from
(select duration,loc_from,count(distinct tripid) cnt from [Namma Yatri].[dbo].[trips] 
group by duration,loc_from)a)b 
where rnk=1;
 

 -- which duration got the higher number of trips in each of location present

 select * from
(select *,rank()  over(partition by loc_from order by cnt desc) rnk from
(select duration,loc_from,count(distinct tripid) cnt from [Namma Yatri].[dbo].[trips] 
group by duration,loc_from)a)b 
where rnk=1; 


--which area got higher fares 
select * from (select *,rank() over(order by fare desc) rnk 
from 
(select loc_from,sum(fare) fare
from 
[Namma Yatri].[dbo].[trips]
group by loc_from)b)c 
where rnk=1


-- which area got more cancellations - driver
select * from (select *,rank() over(order by cancelled desc) rnk 
from
(select loc_from,count(*)-sum(driver_not_cancelled) cancelled
from [Namma Yatri].[dbo].[trip_details]
 group by loc_from)b)c where rnk=1


-- which area got more cancellations - customer
select * from (select *,rank() over(order by cancelled desc) rnk 
from
(select loc_from,count(*)-sum(customer_not_cancelled) cancelled
from [Namma Yatri].[dbo].[trip_details]
 group by loc_from)b)c where rnk=1 




 --which duration got higher trips and fares 

 select * from (select *,rank() over(order by fare desc) rnk 
from
(select duration,count(distinct tripid) fare
from [Namma Yatri].[dbo].[trips] group by duration)b)c
 where rnk=1 






































