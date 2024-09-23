select * from Train;

-- columns with null values in the table
select 
	column_name,
	is_nullable
from 
	 INFORMATION_SCHEMA.COLUMNS 
where
    table_name = 'Train' and IS_NULLABLE = 'YES';

--- selecting the column names from the table
select 
    column_name 
from 
   INFORMATION_SCHEMA.COLUMNS 
where 
	table_name = 'Train'; 

--- total count of each item
select 
    Item_Type, count(Item_Type) as count_of_item 
from 
	Train 
Group BY	
   Item_Type 
ORDER BY 
   count_of_item DESC;

-- total sales by item
select 
	Item_Type, sum(Item_Outlet_Sales) as sales_by_item 
from 
   Train 
Group BY 
	Item_Type 
ORDER BY 
	sales_by_item DESC;

--- Total Sales by Year 
select 
	Outlet_Establishment_Year, sum(Item_Outlet_Sales) as total_sales 
from 
	Train
GROUP BY 
	Outlet_Establishment_Year 
ORDER BY 
	Outlet_Establishment_Year;

--- Total Sales by Item and Year 
select 
	Item_Type, Outlet_Establishment_Year, sum(Item_Outlet_Sales) as total_sales 
from 
	Train
GROUP BY 
	Outlet_Establishment_Year, Item_Type 
ORDER BY 
	Outlet_Establishment_Year;

---- Rank for highest amount of sales by year
WITH aggregate_data AS (
    SELECT 
        Outlet_Establishment_Year, 
        SUM(Item_Outlet_Sales) AS total_sales 
    FROM 
        Train
    GROUP BY 
        Outlet_Establishment_Year
)
SELECT 
    Outlet_Establishment_Year,
    total_sales,
    RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM aggregate_data;


---- rank with total sales by item and year
WITH aggregate_data AS (
    SELECT 
        Outlet_Establishment_Year, 
        Item_Type,
        SUM(Item_Outlet_Sales) AS total_sales 
    FROM 
        Train
    GROUP BY 
        Outlet_Establishment_Year,
        Item_Type
)
SELECT 
    Outlet_Establishment_Year,
    Item_Type,
    total_sales,
    RANK() OVER(PARTITION BY Outlet_Establishment_Year ORDER BY total_sales DESC) AS sales_rank
FROM aggregate_data;

---- top selling item in each year
WITH aggregate_data AS (
    SELECT 
        Outlet_Establishment_Year, 
        Item_Type,
        SUM(Item_Outlet_Sales) AS total_sales 
    FROM 
        Train
    GROUP BY 
        Outlet_Establishment_Year,
        Item_Type
)
, RankedSales as (SELECT 
    Outlet_Establishment_Year,
    Item_Type,
    total_sales,
    RANK() OVER(PARTITION BY Outlet_Establishment_Year ORDER BY total_sales DESC) AS sales_rank
FROM aggregate_data
)

select * from RankedSales
where sales_rank = 1;


---- top 5 best selling item in each year
WITH aggregate_data AS (
    SELECT 
        Outlet_Establishment_Year, 
        Item_Type,
        SUM(Item_Outlet_Sales) AS total_sales 
    FROM 
        Train
    GROUP BY 
        Outlet_Establishment_Year,
        Item_Type
)
, RankedSales as (SELECT 
    Outlet_Establishment_Year,
    Item_Type,
    total_sales,
    RANK() OVER(PARTITION BY Outlet_Establishment_Year ORDER BY total_sales DESC) AS sales_rank
FROM aggregate_data
)

select * from RankedSales
where sales_rank <= 5;


--- RANK TOTAL SALES BY ITEM
with AGGEGRATE_ITEM_RANK AS (
select 
  Item_Type,
  sum(item_outlet_sales) as total_sales
from 
	Train
group by 
	item_type
)
select 
	Item_type,
	total_sales,
	RANK() OVER(Order by total_sales DESC) as rank_by_item
from AGGEGRATE_ITEM_RANK;