-- 1)	Show customer number, customer name, state and credit limit from customers table for below conditions. Sort the results by highest to lowest values of creditLimit.

-- ●	State should not contain null values
-- ●	credit limit should be between 50000 and 100000
select customerNumber,customerName,state,creditlimit from customers where  state is not null and creditlimit between 50000 and 100000 Order By creditlimit desc ;
	 

	
	
-- 2) Show the unique productline values containing the word cars at the end from products table.
-- Expected output:

	

select distinct productline from products where productline like '%cars%';
/* 
	
==============================================================================================================
					DAY 4
==============================================================================================================

1) Show the orderNumber, status and comments from orders table for shipped status only. If some comments are having null values then show them as “-“.

 */
SELECT orderNumber, status, COALESCE(comments, '-') FROM orders WHERE status = 'Shipped';


/*+-------------+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------+
| orderNumber | status  | COALESCE(comments, '-')
                                                                
+-------------+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------+
|       10100 | Shipped | -
                                                                
|       10101 | Shipped | Check on availability.
                                                                
|       10102 | Shipped | -
                                                                
|       10103 | Shipped | -
                                                                
|       10104 | Shipped | -
                                                                
|       10105 | Shipped | -
                                                                
|       10106 | Shipped | -
                                                                
|       10107 | Shipped | Difficult to negotiate with customer. We need more marketing materials
                                                                
|       10108 | Shipped | -
                                                                
|       10109 | Shipped | Customer requested that FedEx Ground is used for this shipping
                                                                
|       10110 | Shipped | -
                                                                
|       10111 | Shipped | -
                                                                
|       10112 | Shipped | Customer requested that ad materials (such as posters, pamphlets) be included in the shippment                                                                |
|       10113 | Shipped | -
                                                                
|       10114 | Shipped | -
                                                                
|       10115 | Shipped | -
                                                                
|       10116 | Shipped | -
                                                                
|       10117 | Shipped | -
                                                                
|       10118 | Shipped | Customer has worked with some of our vendors in the past and is aware of their MSRP
                                                                
|       10119 | Shipped | -
                                                                
|       10120 | Shipped | -
                                                                
|       10121 | Shipped | -
                                                                
|       10122 | Shipped | -                                                                                                                                                             |
|       10123 | Shipped | -
                                                                
|       10124 | Shipped | Customer very concerned about the exact color of the models. There is high risk that he may dispute the order because there is a slight color mismatch        
|       10125 | Shipped | -
                                                                
|       10126 | Shipped | -
                                                                
|       10127 | Shipped | Customer requested special shippment. The instructions were passed along to the warehouse                                                                     |
|       10128 | Shipped | -
                                                                
|       10129 | Shipped | -
                                                                
|       10130 | Shipped | -*/



/*
2)	Select employee number, first name, job title and job title abbreviation from employees table based on following conditions.
If job title is one among the below conditions, then job title abbreviation column should show below forms.
●	President then “P”
●	Sales Manager / Sale Manager then “SM”
●	Sales Rep then “SR”
●	Containing VP word then “VP”
*/

	 SELECT employeeNumber, firstName, jobTitle,
            CASE
                WHEN jobTitle = 'President' THEN 'P'
                WHEN jobTitle like '%Sales Manager%' OR jobTitle like '%Sale Manager%' THEN 'SM'
                WHEN jobTitle = 'Sales Rep' THEN 'SR'
               WHEN jobTitle LIKE '%VP%' THEN 'VP'
                ELSE ''
          END AS jobTitle_Abbr
     FROM employees;
/*	
+----------------+-----------+----------------------+---------------+
| employeeNumber | firstName | jobTitle             | jobTitle_Abbr |
+----------------+-----------+----------------------+---------------+
|           1002 | Diane     | President            | P             |
|           1056 | Mary      | VP Sales             | VP            |
|           1076 | Jeff      | VP Marketing         | VP            |
|           1088 | William   | Sales Manager (APAC) | SM            |
|           1102 | Gerard    | Sale Manager (EMEA)  | SM            |
|           1143 | Anthony   | Sales Manager (NA)   | SM            |
|           1165 | Leslie    | Sales Rep            | SR            |
|           1166 | Leslie    | Sales Rep            | SR            |
|           1188 | Julie     | Sales Rep            | SR            |
|           1216 | Steve     | Sales Rep            | SR            |
|           1286 | Foon Yue  | Sales Rep            | SR            |
|           1323 | George    | Sales Rep            | SR            |
|           1337 | Loui      | Sales Rep            | SR            |
|           1370 | Gerard    | Sales Rep            | SR            |
|           1401 | Pamela    | Sales Rep            | SR            |
|           1501 | Larry     | Sales Rep            | SR            |
|           1504 | Barry     | Sales Rep            | SR            |
|           1611 | Andy      | Sales Rep            | SR            |
|           1612 | Peter     | Sales Rep            | SR            |
|           1619 | Tom       | Sales Rep            | SR            |
|           1621 | Mami      | Sales Rep            | SR            |
|           1625 | Yoshimi   | Sales Rep            | SR            |
|           1702 | Martin    | Sales Rep            | SR            |
+----------------+-----------+----------------------+---------------+

==============================================================================================================
					DAY 5
==============================================================================================================

1)	For every year, find the minimum amount value from payments table.

---> */
 select year(paymentdate) as year, min(amount) as 'min amount' from payments group by year(paymentdate);
 /*+-------------------+-------------+
| year              | min amount  |
+-------------------+-------------+
|              2004 |     1676.14 |
|              2003 |     1128.20 |
|              2005 |      615.45 |
+-------------------+-------------+


2)	For every year and every quarter, find the unique customers and total orders from orders table. Make sure to show the quarter as Q1,Q2 etc.
*/

 select year(orderdate) as 'year',
     case
     when quarter(orderdate)= 1 then 'Q1'
     when quarter(orderdate)= 2 then 'Q2'
     when quarter(orderdate)= 3 then 'Q3'
     else 'Q4'
     end as 'Quarter',
      COUNT(DISTINCT customerNumber) AS 'Unique Customers',
      COUNT(orderNumber) AS 'Total Orders'
     FROM orders
     GROUP BY YEAR(orderDate),
     case
     when quarter(orderdate)= 1 then 'Q1'
     when quarter(orderdate)= 2 then 'Q2'
     when quarter(orderdate)= 3 then 'Q3'
     else 'Q4'
     end;
/*+------+---------+------------------+--------------+
| year | Quarter | Unique Customers | Total Orders |
+------+---------+------------------+--------------+
| 2003 | Q1      |               14 |           14 |
| 2003 | Q2      |               18 |           20 |
| 2003 | Q3      |               19 |           20 |
| 2003 | Q4      |               50 |           57 |
| 2004 | Q1      |               25 |           27 |
| 2004 | Q2      |               25 |           30 |
| 2004 | Q3      |               31 |           35 |
| 2004 | Q4      |               48 |           59 |
| 2005 | Q1      |               25 |           37 |
| 2005 | Q2      |               24 |           27 |
+------+---------+------------------+--------------+
10 rows in set (0.00 sec)


3) Show the formatted amount in thousands unit (e.g. 500K, 465K etc.) for every month (e.g. Jan, Feb etc.) with filter on total amount as 500000 to 1000000. Sort the output by total amount in descending mode. [ Refer. Payments Table]
*/

SELECT DATE_FORMAT(paymentDate, '%b') AS month, CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS Amount FROM payments GROUP BY month HAVING SUM(amount) BETWEEN 500000 AND 1000000 ORDER BY SUM(amount) DESC;

/*+-------+--------+
| month | Amount |
+-------+--------+
| Mar   | 990K   |
| May   | 641K   |
| Sep   | 638K   |
| Aug   | 624K   |
| Feb   | 503K   |
| Oct   | 502K   |
+-------+--------+



Day 6:

1)	Create a journey table with following fields and constraints.

●	Bus_ID (No null values)
●	Bus_Name (No null values)
●	Source_Station (No null values)
●	Destination (No null values)
●	Email (must not contain any duplicates)

---->
*/
 create table journey(
    Bus_id int not null,Bus_name varchar(25) not null,source_station varchar(30) not null,desination varchar(30) not null,Email varchar(25) unique );
/*
2)	Create vendor table with following fields and constraints.

●	Vendor_ID (Should not contain any duplicates and should not be null)
●	Name (No null values)
●	Email (must not contain any duplicates)
●	Country (If no data is available then it should be shown as “N/A”)
*/
create table vendor(Vendor_id int primary key,Name varchar(25) not null,email varchar(25) unique,country varchar(25) default "N/A");

/*3)	Create movies table with following fields and constraints.

●	Movie_ID (Should not contain any duplicates and should not be null)
●	Name (No null values)
●	Release_Year (If no data is available then it should be shown as “-”)
●	Cast (No null values)
●	Gender (Either Male/Female)
●	No_of_shows (Must be a positive number)

--->*/

 CREATE TABLE MOVIE(MOVIE_ID INT PRIMARY KEY,NAME VARCHAR(25) NOT NULL,RELEASE_YEAR INT ,CAST VARCHAR(25) NOT NULL,GENDER ENUM("MALE","FEMALE"),NO_OF_SHOWS INT CHECK(NO_OF_SHOWS>0));

/*
4)	Create the following tables. Use auto increment wherever applicable

a. Product
✔	product_id - primary key
✔	product_name - cannot be null and only unique values are allowed
✔	description
✔	supplier_id - foreign key of supplier table
--->*/

create table product(product_id int primary key,product_name varchar(25) not null unique,description varchar(25),supplier_id int, foreign key(supplier_id) references suppliers(supplier_id)); 

/*b. Suppliers
✔	supplier_id - primary key
✔	supplier_name
✔	location
---> */

create table Suppliers(Supplier_id int primary key,supplier_name varchar(25),location varchar(25));



/* c. Stock
✔	id - primary key
✔	product_id - foreign key of product table
✔	balance_stock

-----> */
create table stock(id int primary key,product_id int, balance_stock int,foreign key(product_id) references product(product_id));

/*Day 7
1)	Show employee number, Sales Person (combination of first and last names of employees), unique customers for each employee number and sort the data by highest to lowest unique customers.
Tables: Employees, Customers
----> */
select a.employeeNumber,
concat(a.firstname,'',a.lastname) as SalesPerson,
count(distinct b.customernumber) as unique_customers
 from employees a,customers b 
where a.employeenumber=b.salesrepemployeenumber 
 group by a.employeenumber order by unique_customers desc;

/*+----------------+-----------------+------------------+
| employeeNumber | SalesPerson     | unique_customers |
+----------------+-----------------+------------------+
|           1401 | PamelaCastillo  |               10 |
|           1504 | BarryJones      |                9 |
|           1323 | GeorgeVanauf    |                8 |
|           1501 | LarryBott       |                8 |
|           1286 | Foon YueTseng   |                7 |
|           1370 | GerardHernandez |                7 |
|           1165 | LeslieJennings  |                6 |
|           1166 | LeslieThompson  |                6 |
|           1188 | JulieFirrelli   |                6 |
|           1216 | StevePatterson  |                6 |
|           1337 | LouiBondur      |                6 |
|           1702 | MartinGerard    |                6 |
|           1611 | AndyFixter      |                5 |
|           1612 | PeterMarsh      |                5 |
|           1621 | MamiNishi       |                5 |
+----------------+-----------------+------------------+


2)Show total quantities, total quantities in stock, left over quantities for each product and each customer. Sort the data by customer number.
Tables: Customers, Orders, Orderdetails, Products
------> */

SELECT c.customerNumber AS CustomerNumber, c.customerName AS CustomerName, p.productCode AS ProductCode, p.productName AS ProductName, SUM(od.quantityOrdered) AS Ordered_Qty, IFNULL(p.quantityInStock, 0) AS Total_inventory, IFNULL(p.quantityInStock - SUM(od.quantityOrdered), 0) AS Left_Qty FROM Customers c JOIN Orders o ON c.customerNumber = o.customerNumber JOIN OrderDetails od ON o.orderNumber = od.orderNumber JOIN Products p ON od.productCode = p.productCode LEFT JOIN products s ON p.productCode = s.productCode GROUP BY c.customerNumber, p.productCode ORDER BY c.customerNumber;


/*+----------------+------------------------------------+-------------+---------------------------------------------+-------------+-----------------+----------+
| CustomerNumber | CustomerName                       | ProductCode | ProductName                                 | Ordered_Qty | Total_inventory | Left_Qty |
+----------------+------------------------------------+-------------+---------------------------------------------+-------------+-----------------+----------+
|            103 | Atelier graphique                  | S10_2016    | 1996 Moto Guzzi 1100i                       |          39 |            6625 |     6586 |
|            103 | Atelier graphique                  | S18_1589    | 1965 Aston Martin DB5                       |          26 |            9042 |     9016 |
|            103 | Atelier graphique                  | S18_2625    | 1936 Harley Davidson El Knucklehead         |          32 |            4357 |     4325 |
|            103 | Atelier graphique                  | S18_2870    | 1999 Indy 500 Monte Carlo SS                |          46 |            8164 |     8118 |
|            103 | Atelier graphique                  | S18_3685    | 1948 Porsche Type 356 Roadster              |          34 |            8990 |     8956 |
|            103 | Atelier graphique                  | S24_1628    | 1966 Shelby Cobra 427 S/C                   |          50 |            8197 |     8147 |
|            103 | Atelier graphique                  | S24_2022    | 1938 Cadillac V-16 Presidential Limousine   |          43 |            2847 |     2804 |
|            112 | Signal Gift Stores                 | S18_1129    | 1993 Mazda RX-7                             |          34 |            3975 |     3941 |
|            112 | Signal Gift Stores                 | S18_1342    | 1937 Lincoln Berline                        |          42 |            8693 |     8651 |
|            112 | Signal Gift Stores                 | S18_1589    | 1965 Aston Martin DB5                       |          23 |            9042 |     9019 |
|            112 | Signal Gift Stores                 | S18_1749    | 1917 Grand Touring Sedan                    |          21 |            2724 |     2703 |
|            112 | Signal Gift Stores                 | S18_1889    | 1948 Porsche 356-A Roadster                 |          29 |            8826 |     8797 |
|            112 | Signal Gift Stores                 | S18_1984    | 1995 Honda Civic                            |          29 |            9772 |     9743 |
|            112 | Signal Gift Stores                 | S18_2248    | 1911 Ford Town Car                          |          42 |             540 |      498 |
|            112 | Signal Gift Stores                 | S18_2325    | 1932 Model A Ford J-Coupe                   |          42 |            9354 |     9312 |
|            112 | Signal Gift Stores                 | S18_2870    | 1999 Indy 500 Monte Carlo SS                |          39 |            8164 |     8125 |
|            112 | Signal Gift Stores                 | S18_3232    | 1992 Ferrari 360 Spider red                 |          42 |            8347 |     8305 |
|            112 | Signal Gift Stores                 | S18_3685    | 1948 Porsche Type 356 Roadster              |          31 |            8990 |     8959 |
|            112 | Signal Gift Stores                 | S18_4409    | 1932 Alfa Romeo 8C2300 Spider Sport         |          36 |            6553 |     6517 |
|            112 | Signal Gift Stores                 | S18_4933    | 1957 Ford Thunderbird                       |          23 |            3209 |     3186 |
|            112 | Signal Gift Stores                 | S24_1046    | 1970CChevy Chevelle SS 454                  |          22 |            1005 |      983 |
|            112 | Signal Gift Stores                 | S24_1628    | 1966 Shelby Cobra 427 S/C                   |          35 |            8197 |     8162 |
|            112 | Signal Gift Stores                 | S24_1937    | 1939 Chevrolet Deluxe Coupe                 |          45 |            7332 |     7287 |
|            112 | Signal Gift Stores                 | S24_2022    | 1938 Cadillac V-16 Presidential Limousine   |          22 |            2847 |     2825 |
|            112 | Signal Gift Stores                 | S24_2766    | 1949 Jaguar XK 120                          |          57 |            2350 |     2293 |
+----------------+------------------------------------+-------------+---------------------------------------------+-------------+-----------------+----------+

3)	Create below tables and fields. (You can add the data as per your wish)

●	Laptop: (Laptop_Name)
●	Colours: (Colour_Name)
Perform cross join between the two tables and find number of rows.
---> */

create table laptop (
laptop_name varchar(25));
create table colours(
colour_name varchar(25));
insert into laptop values('dell');
insert into laptop values('hp');
insert into colours values('red');
insert into colours values('blue');
insert into colours values('green');

select * from laptop cross join colours;
/*+-------------+-------------+
| laptop_name | colour_name |
+-------------+-------------+
| hp          | blue        |
| dell        | blue        |
| hp          | green       |
| dell        | green       |
| hp          | red         |
| dell        | red         |
+-------------+-------------+

4)	table project with below fields.

●	EmployeeID
●	FullName 
●	Gender
●	ManagerID
Add below data into it.
INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);
Find out the names of employees and their related managers.
------> */

create table manager_details(managerid int primary key, manager_name varchar(20));
insert into manager_details values(1,'pranaya');
insert into manager_details values(3,'preety');
create table project(employeeid int primary key,fullname varchar(25),gender varchar(8),managerID int,foreign key(managerid) references manager_details(managerid));
INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);

select a.manager_name as 'manager name' , b.fullname as 'employee name' from manager_details a, project b where a.managerid = b.managerid;
/*
+--------------+---------------+
| manager name | employee name |
+--------------+---------------+
| pranaya      | Priyanka      |
| pranaya      | Anurag        |
| pranaya      | Sambit        |
| preety       | Pranaya       |
| preety       | Rajesh        |
| preety       | Hina          |
+--------------+---------------+
=======
Day 8
=======
Create table facility. Add the below fields into it.
●	Facility_ID
●	Name
●	State
●	Country

i) Alter the table by adding the primary key and auto increment to Facility_ID column.
ii) Add a new column city after name with data type as varchar which should not accept any null values.
-----> */

create table facility(Facility_ID int,Name varchar(25),state varchar(25),country varchar(25));
alter table facility modify column Facility_id int primary key auto_increment;

alter table facility add column city varchar(25) not null after name;

 desc facility;
/* +-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| Facility_id | int         | NO   | PRI | NULL    | auto_increment |
| Name        | varchar(25) | YES  |     | NULL    |                |
| city        | varchar(25) | NO   |     | NULL    |                |
| state       | varchar(25) | YES  |     | NULL    |                |
| country     | varchar(25) | YES  |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
========
Day 9
========
Create table university with below fields.
●	ID
●	Name
Add the below data into it as it is.
INSERT INTO University
VALUES (1, "       Pune          University     "), 
               (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
              (4, "Madras University"),
              (5, "Nagpur University");
Remove the spaces from everywhere and update the column like Pune University etc.
---->*/

create table university(id int primary key,name varchar(60));
INSERT INTO University
VALUES (1, "      Pune University       "), 
               (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
              (4, "Madras University"),
              (5, "Nagpur University");

UPDATE university SET Name = REPLACE(Name,' ','');


 select * from university;
/*+----+------------------+
| id | name             |
+----+------------------+
|  1 | PuneUniversity   |
|  2 | MumbaiUniversity |
|  3 | DelhiUniversity  |
|  4 | MadrasUniversity |
|  5 | NagpurUniversity |
+----+------------------+
=========
Day 10
=========
Create the view products status. Show year wise total products sold. Also find the percentage of total value for each year. The output should look as shown in below figure.
--->*/

  create view product_status as select year(o.orderdate) as year, concat( count(od.priceeach),' ', '(',round(sum(od.priceeach * od.quantityordered)/(SELECT SUM(od2.priceEach * od2.quantityOrdered) FROM OrderDetails od2)*100),'%)') as value from orders o , orderdetails  od  where o.ordernumber = od.ordernumber   group by year(o.orderdate) order by value desc;


 select * from product_status;
/*+------+------------+
| year | value      |
+------+------------+
| 2005 | 523 (18%)  |
| 2004 | 1421 (47%) |
| 2003 | 1052 (35%) |
+------+------------+
==============
Day 11
==============
1)	Create a stored procedure GetCustomerLevel which takes input as customer number and gives the output as either Platinum, Gold or Silver as per below criteria.

Table: Customers

●	Platinum: creditLimit > 100000
●	Gold: creditLimit is between 25000 to 100000
●	Silver: creditLimit < 25000
creditLimit
---->*/
 
DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(IN cust_no INT)
BEGIN
    DECLARE level VARCHAR(10);
SELECT 
CASE 
WHEN creditLimit > 100000 THEN 'Platinum'
WHEN creditLimit BETWEEN 25000 AND 100000 THEN 'Gold'
ELSE 'Silver'
END INTO level
FROM 
Customers 
WHERE 
customerNumber = cust_no;
SELECT level;
END $$

CALL GetCustomerLevel(114);
/*+----------+
| level    |
+----------+
| Platinum |
+----------+

2)	Create a stored procedure Get_country_payments which takes in year and country as inputs and gives year wise, country wise total amount as an output. Format the total amount to nearest thousand unit (K)
Tables: Customers, Payments
--->*/

DELIMITER //
CREATE PROCEDURE Get_country_payments(IN inputYear INT, IN inputCountry VARCHAR(255))
 BEGIN 
SELECT YEAR(p.paymentDate) AS Year, c.country AS Country, CONCAT(FORMAT(SUM(p.amount)/1000, 0), 'K') AS 'Total Amount'
 FROM Payments p ,customers c
 where p.customerNumber = c.customerNumber and  YEAR(p.paymentDate) = inputYear AND c.country = inputCountry GROUP BY Year, Country; END //
DELIMITER ;
CALL Get_country_payments(2003, 'France');
/*+------+---------+--------------+
| Year | Country | Total Amount |
+------+---------+--------------+
| 2003 | France  | 283K         |
+------+---------+--------------+*/



/*
day 12 
1) Calculate year wise, month name wise count of orders and year over year (YoY) percentage change. 
Format the YoY values in no decimals and show in % sign.
---->*/
SELECT
    EXTRACT(YEAR FROM OrderDate) AS OrderYear,
    OrderDate, 'Month' AS MonthName,
    COUNT(*) AS OrderCount,
    LAG(COUNT(*)) OVER (PARTITION BY OrderDate, 'Month' ORDER BY EXTRACT(YEAR FROM OrderDate)) AS PreviousYearOrderCount,
    CONCAT(
        CASE
            WHEN COUNT(*) > 0 AND LAG(COUNT(*)) OVER (PARTITION BY OrderDate, 'Month' ORDER BY EXTRACT(YEAR FROM OrderDate)) > 0 THEN
                CONCAT(
                    ROUND(((COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY OrderDate, 'Month' ORDER BY EXTRACT(YEAR FROM OrderDate))) * 100.0) / LAG(COUNT(*)) OVER (PARTITION BY OrderDate, 'Month' ORDER BY EXTRACT(YEAR FROM OrderDate))),
                    '%'
                )
            ELSE '0%'
        END
    ) AS YoYPercentageChange
FROM Orders
GROUP BY OrderYear
ORDER BY OrderYear;

/*WITH YearMonthOrders AS (
    SELECT EXTRACT(YEAR FROM orderDate) AS order_year,
    DATE_FORMAT(orderDate, '%M') AS order_month,
    COUNT(*) AS order_count
    FROM Orders
    GROUP BY  order_month, order_year
    
),
YoYPercentageChange AS (
    SELECT a.order_year, a.order_month, a.order_count, b.order_count AS prev_year_order_count,
    CASE WHEN b.order_count IS NULL THEN 'N/A'
    ELSE CONCAT(
        ROUND(((a.order_count - b.order_count) / b.order_count) * 100, 2),
        '%'
    ) END AS yoy_percentage_change
    FROM YearMonthOrders a
    LEFT JOIN YearMonthOrders b ON
    a.order_year = b.order_year + 1 AND a.order_month = b.order_month
)
SELECT order_year, order_month, order_count, yoy_percentage_change FROM YoYPercentageChange;*/


/*2)	Create the table emp_udf with below fields.

●	Emp_ID
●	Name
●	DOB
Add the data as shown in below query.
INSERT INTO Emp_UDF(Name, DOB)
VALUES ("Piyush", "1990-03-30"), ("Aman", "1992-08-15"), ("Meena", "1998-07-28"), ("Ketan", "2000-11-21"), ("Sanjay", "1995-05-21");

Create a user defined function calculate_age which returns the age in years and months (e.g. 30 years 5 months) by accepting DOB column as a parameter.

---->*/

CREATE TABLE emp_udf ( Emp_ID INT AUTO_INCREMENT PRIMARY KEY, Name VARCHAR(255) NOT NULL, DOB DATE );

INSERT INTO emp_udf (Name, DOB) VALUES ("Piyush", "1990-03-30"), ("Aman", "1992-08-15"), ("Meena", "1998-07-28"), ("Ketan", "2000-11-21"), ("Sanjay", "1995-05-21");

DELIMITER //

CREATE FUNCTION calculate_age(date_of_birth DATE) RETURNS VARCHAR(50) DETERMINISTIC BEGIN DECLARE years INT; DECLARE months INT; DECLARE age VARCHAR(50);

SET years = TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE());
SET months = TIMESTAMPDIFF(MONTH, date_of_birth, CURDATE()) % 12;

IF years = 0 THEN
    SET age = CONCAT(months, ' months');
ELSEIF months = 0 THEN
    SET age = CONCAT(years, ' years');
ELSE
    SET age = CONCAT(years, ' years ', months, ' months');
END IF;

RETURN age;
END //

SELECT Emp_ID,Name, DOB, calculate_age(DOB) AS Age FROM emp_udf;
/*+--------+--------+------------+-------------------+
| Emp_ID | Name   | DOB        | Age               |
+--------+--------+------------+-------------------+
|      1 | Piyush | 1990-03-30 | 33 years 9 months |
|      2 | Aman   | 1992-08-15 | 31 years 5 months |
|      3 | Meena  | 1998-07-28 | 25 years 5 months |
|      4 | Ketan  | 2000-11-21 | 23 years 1 months |
|      5 | Sanjay | 1995-05-21 | 28 years 7 months |
+--------+--------+------------+-------------------+*/
/*

Day 13
1)	Display the customer numbers and customer names from customers table who have not placed any orders using subquery

Table: Customers, Orders

---->*/
SELECT CustomerNumber, CustomerName FROM Customers WHERE CustomerNumber NOT IN (SELECT CustomerNumber FROM Orders);

/*+----------------+--------------------------------+
| CustomerNumber | CustomerName                   |
+----------------+--------------------------------+
|            125 | Havel & Zbyszek Co             |
|            168 | American Souvenirs Inc         |
|            169 | Porto Imports Co.              |
|            206 | Asian Shopping Network, Co     |
|            223 | Natürlich Autos                |
|            237 | ANG Resellers                  |
|            247 | Messner Shopping Network       |
|            273 | Franken Gifts, Co              |
|            293 | BG&E Collectables              |
|            303 | Schuyler Imports               |
|            307 | Der Hund Imports               |
|            335 | Cramer Spezialitäten, Ltd      |
|            348 | Asian Treasures, Inc.          |
|            356 | SAR Distributors, Co           |
|            361 | Kommission Auto                |
|            369 | Lisboa Souveniers, Inc         |
|            376 | Precious Collectables          |
|            409 | Stuttgart Collectable Exchange |
|            443 | Feuer Online Stores, Inc       |
|            459 | Warburg Exchange               |
|            465 | Anton Designs, Ltd.            |
|            477 | Mit Vergnügen & Co.            |
|            480 | Kremlin Collectables, Co.      |
|            481 | Raanan Stores, Inc             |
+----------------+--------------------------------+


2)	Write a full outer join between customers and orders using union and get the customer number, customer name, count of orders for every customer.
Table: Customers, Orders

---->*/

SELECT C.CustomerNumber, C.CustomerName, IFNULL(COUNT(O.OrderNumber), 0) AS OrderCount FROM Customers as C LEFT JOIN Orders AS O ON C.CustomerNumber = O.CustomerNumber GROUP BY C.CustomerNumber, C.CustomerName UNION SELECT O.CustomerNumber, C.CustomerName, IFNULL(COUNT(O.OrderNumber), 0) AS OrderCount FROM Customers AS C RIGHT JOIN Orders AS O ON C.CustomerNumber = O.CustomerNumber GROUP BY O.CustomerNumber, C.CustomerName;

/*+----------------+------------------------------------+------------+
| CustomerNumber | CustomerName                       | OrderCount |
+----------------+------------------------------------+------------+
|            103 | Atelier graphique                  |          3 |
|            112 | Signal Gift Stores                 |          3 |
|            114 | Australian Collectors, Co.         |          5 |
|            119 | La Rochelle Gifts                  |          4 |
|            121 | Baane Mini Imports                 |          4 |
|            124 | Mini Gifts Distributors Ltd.       |         17 |
|            125 | Havel & Zbyszek Co                 |          0 |
|            128 | Blauer See Auto, Co.               |          4 |
|            129 | Mini Wheels Co.                    |          3 |
|            131 | Land of Toys Inc.                  |          4 |
|            141 | Euro+ Shopping Channel             |         26 |
|            144 | Volvo Model Replicas, Co           |          4 |
|            145 | Danish Wholesale Imports           |          5 |
|            146 | Saveley & Henriot, Co.             |          3 |
|            148 | Dragon Souveniers, Ltd.            |          5 |
|            151 | Muscle Machine Inc                 |          4 |
|            157 | Diecast Classics Inc.              |          4 |
|            161 | Technics Stores Inc.               |          4 |
|            166 | Handji Gifts& Co                   |          4 |
+----------------+------------------------------------+------------+

3)	Show the second highest quantity ordered value for each order number.
Table: Orderdetails
---->*/

SELECT OrderNumber, MAX(QuantityOrdered) AS quantityOrdered FROM Orderdetails AS od1 WHERE QuantityOrdered < ( SELECT MAX(QuantityOrdered) FROM Orderdetails AS od2 WHERE od1.OrderNumber = od2.OrderNumber ) GROUP BY OrderNumber;

/*+-------------+-----------------+
| OrderNumber | quantityOrdered |
+-------------+-----------------+
|       10100 |              49 |
|       10101 |              45 |
|       10102 |              39 |
|       10103 |              45 |
|       10104 |              44 |
|       10105 |              44 |
|       10106 |              49 |
|       10107 |              38 |
|       10108 |              44 |
|       10109 |              46 |
|       10110 |              46 |
|       10111 |              43 |
|       10112 |              23 |
+-------------+-----------------+

4)	For each order number count the number of products and then find the min and max of the values among count of orders.
Table: Orderdetails
---->*/

SELECT
MAX(ProductCount) AS "MAX(Total)",
MIN(ProductCount) AS "MIN(Total)"
FROM ( SELECT OrderNumber, COUNT(*) AS ProductCount FROM Orderdetails GROUP BY OrderNumber ) AS Counts;


/*+------------+------------+
| MAX(Total) | MIN(Total) |
+------------+------------+
|         18 |          1 |
+------------+------------+


5)	Find out how many product lines are there for which the buy price value is greater than the average of buy price value. Show the output as product line and its count.
Expected output:
---->*/
SELECT p.ProductLine, COUNT(*) AS Total FROM Products AS p JOIN ( SELECT AVG(BuyPrice) AS AvgBuyPrice FROM Products ) AS avg_prices ON p.BuyPrice > avg_prices.AvgBuyPrice GROUP BY p.ProductLine ORDER BY Total DESC;

/*+------------------+-------+
| ProductLine      | Total |
+------------------+-------+
| Classic Cars     |    24 |
| Vintage Cars     |    10 |
| Trucks and Buses |     7 |
| Motorcycles      |     6 |
| Planes           |     5 |
| Ships            |     1 |
| Trains           |     1 |
+------------------+-------+

Create the table Emp_EH. Below are its fields.
●	EmpID (Primary Key)
●	EmpName
●	EmailAddress
Create a procedure to accept the values for the columns in Emp_EH. Handle the error using exception handling concept. Show the message as “Error occurred” in case of anything wrong.

----->*/

CREATE TABLE Emp_EH ( EmpID INT PRIMARY KEY, EmpName VARCHAR(255), EmailAddress VARCHAR(255) );
CREATE PROCEDURE InsertEmp_EH( IN p_EmpID INT, IN p_EmpName VARCHAR(255), IN p_EmailAddress VARCHAR(255) ) BEGIN DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error occurred'; END;

START TRANSACTION;

-- Insert the values into the Emp_EH table
INSERT INTO Emp_EH (EmpID, EmpName, EmailAddress)
VALUES (p_EmpID, p_EmpName, p_EmailAddress);

COMMIT;
END //


/*
Day 15
Create the table Emp_BIT. Add below fields in it.
●	Name
●	Occupation
●	Working_date
●	Working_hours

Insert the data as shown in below query.
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  
 
Create before insert trigger to make sure any new value of Working_hours, if it is negative, then it should be inserted as positive.
---->*/


CREATE TABLE Emp_BIT ( Name VARCHAR(255), Occupation VARCHAR(255), Working_date DATE, Working_hours INT );
INSERT INTO Emp_BIT VALUES ('Robin', 'Scientist', '2020-10-04', 12),
('Warner', 'Engineer', '2020-10-04', 10),
('Peter', 'Actor', '2020-10-04', 13),
('Marco', 'Doctor', '2020-10-04', 14),
('Brayden', 'Teacher', '2020-10-04', 12),
('Antonio', 'Business', '2020-10-04', 11);

DELIMITER //
CREATE TRIGGER 
EnsurePositiveWorkingHours BEFORE INSERT ON Emp_BIT FOR EACH ROW BEGIN IF NEW.Working_hours < 0 THEN SET NEW.Working_hours = -NEW.Working_hours;
 END IF;
 END // 
DELIMITER ;