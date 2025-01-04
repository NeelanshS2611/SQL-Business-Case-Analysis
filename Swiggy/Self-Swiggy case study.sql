USE swiggy;
Select * from swiggy_records;

select sum(case when hotel_name = '' then 1 else 0 end) as hotel_name, 
	   sum(case when rating = '' then 1 else 0 end) as rating,
       sum(case when time_minutes = '' then 1 else 0 end) as time_minutes,
       sum(case when food_type = '' then 1 else 0 end) as food_type,
       sum(case when location = '' then 1 else 0 end) as location,
       sum(case when offer_above = '' then 1 else 0 end) as offer_above,
       sum(case when offer_percentage = '' then 1 else 0 end) as offer_percentage
from swiggy_records;

-- to automate above query for n number of columns we use functions : schemas, group concate, concate, prepare, execute 

Select * from information_schema.columns where table_name = "swiggy_records";
Select COLUMN_NAME from information_schema.columns where table_name = "swiggy_records";

-- group concat

select group_concat(concat('sum(case when`', COLUMN_NAME, '`='''' then 1 else 0 end) as `',COLUMN_NAME, '`' ) ) as op from information_schema.columns where table_name = "swiggy_records";

-- Creating procedure for null count
delimiter //
create procedure count_null()
begin
		select group_concat(
			   concat('sum(case when`', COLUMN_NAME, '`='''' then 1 else 0 end) as `',COLUMN_NAME, '`' ) ) into @sql 
			   from information_schema.columns where table_name = "swiggy_records";
				
		set @sql = concat('select ',@sql,' from swiggy_records');

		prepare null_cnt from @sql;
		execute null_cnt;
		deallocate prepare null_cnt;
	end
//
delimiter;
 
call count_null()

Select * from swiggy_records;

-- Shifting values of rating to time_minutes

Create table cleans as 
Select * from swiggy_records where rating like '%mins%' 



 