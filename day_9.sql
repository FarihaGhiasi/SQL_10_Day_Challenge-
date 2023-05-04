--Questions
-- 9.1 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
select package, count(package) as number_of_downloads 
from cran_logs_2015_01_01 
group by package
order by time desc;

-- 9.2 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
select package, 
       count(package) as number_of_downloads, 
       rank() over (order by number_of_downloads  desc) rank
from cran_logs_2015_01_01 
where TIME(time) between '09:00:00' AND '11:00:00'
group by package
order by rank;

-- 9.3 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
select count(*)  as count_of_recordings 
from cran_logs_2015_01_01 
where country in ('CN', 'JP', 'SG')
group by country;

-- 9.4 Print the countries whose downloaded are more than the downloads from China ("CN")
select country, count(country) as downloads
from cran_logs_2015_01_01
group by country 
having count(country) > (select count(country)
                            from cran_logs_2015_01_01
                                where country = 'CN');

-- 9.5 Print the average length of the package name of all the UNIQUE packages
select avg(LENGTH(package)) as avg_package_length
from (select distinct package
        from cran_logs_2015_01_01) as unique_packages;

-- 9.6 Get the package whose download count ranks 2nd (print package name and its download count).
select package, 
       count(package) as number_of_downloads, 
       rank() over (order by number_of_downloads  desc) rank
from cran_logs_2015_01_01 
group by package
order by rank
limit 1 offset 1;

-- 9.7 Print the name of the package whose download count is bigger than 1000.
select package 
from cran_logs_2015_01_01
having count(country) > 1000;
-- 9.8 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the 
    --proportion (in percentage).

select DISTINCT r_os as main_os, 
       count(*) as count_of_os, 
       count(*) / (select count(*) from cran_logs_2015_01_01) * 100 as proportion
from cran_logs_2015_01_01
group by main_os
order by count_of_os desc;
