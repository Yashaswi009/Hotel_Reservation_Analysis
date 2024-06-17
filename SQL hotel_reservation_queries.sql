SELECT *
FROM hotel_reservation;

UPDATE hotel_reservation
SET arrival_date=str_to_date(arrival_date,"%d-%m-%Y");

ALTER TABLE hotel_reservation
MODIFY COLUMN arrival_date date;

#1. What is the total number of reservations in the dataset?  
SELECT COUNT(*)
FROM hotel_reservation;

#2. Which meal plan is the most popular among guests?
SELECT type_of_meal_plan, COUNT(*) AS plan_count
FROM hotel_reservation
GROUP BY type_of_meal_plan
ORDER BY plan_count DESC;
#Hence meal plan 1 is popular among guests

#3. What is the average price per room for reservations involving children?  
SELECT AVG(avg_price_per_room) AS avg_price
FROM hotel_reservation
WHERE no_of_children > 0;

#4.How many reservations were made for the year 20XX (replace XX with the desired year)?
SELECT Year, COUNT(booking_id) AS no_of_reservations 
FROM (
    SELECT booking_id, YEAR(arrival_date) AS Year 
    FROM hotel_reservation
) AS year_subquery
GROUP BY Year 
ORDER BY no_of_reservations DESC;

#5.What is the most commonly booked room type?
 SELECT room_type_reserved, COUNT(room_type_reserved) AS commonly_booked_room
 FROM hotel_reservation
 GROUP BY 1
 ORDER BY 2 DESC;
 #Room_type 1 is commonly booked room
 
 #6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
 SELECT COUNT(no_of_weekend_nights)
 FROM hotel_reservation
 WHERE no_of_weekend_nights > 0;
 
 #7.What is the highest and lowest lead time for reservations? 
SELECT MAX(lead_time) AS highest_lead_time, MIN(lead_time) AS lowest_lead_time
FROM hotel_reservation;

#8. What is the most common market segment type for reservations? 
SELECT market_segment_type, COUNT(market_segment_type)
FROM hotel_reservation
GROUP BY 1
ORDER BY 2 DESC;
#Online is the most common market_segment_type

#9.How many reservations have a booking status of "Confirmed"?  
SELECT COUNT(booking_status) AS status
FROM hotel_reservation
WHERE booking_status= 'Confirmed';
 
 #10.What is the total number of adults and children across all reservations? 
 SELECT SUM(no_of_adults) + SUM(no_of_children) AS total_number
FROM hotel_reservation;

#11.What is the average number of weekend nights for reservations involving children? 
SELECT AVG(no_of_weekend_nights) AS avg_weekend_nights 
FROM hotel_reservation
WHERE no_of_children > 0;

# 12.How many reservations were made in each month of the year? 
SELECT YEAR(arrival_date) AS Year,MONTH(arrival_date) AS Month,
COUNT(*) AS no_of_reservations
FROM hotel_reservation
GROUP BY 1,2
ORDER BY 1,2;

#13. What is the average number of nights (both weekend and weekday) spent by guests for each room type 
SELECT room_type_reserved, avg(no_of_weekend_nights + no_of_week_nights)
FROM hotel_reservation
GROUP BY 1;

#14. For reservations involving children, what is the most common room type, and what is the average price for that room type?  
SELECT room_type_reserved,
count(booking_id) as common_room_type_count,
avg(avg_price_per_room) as avg_room_price 
from hotel_reservation where no_of_children>0
group by room_type_reserved
order by 2 desc,3
LIMIT 1;
#Room_type 1 is the most common room type

#15.Find the market segment type that generates the highest average price per room.
SELECT market_segment_type, avg(avg_price_per_room) AS avg
FROM hotel_reservation
GROUP BY 1
ORDER BY 2 DESC;
#Online market_segment_type generates highest average price