CREATE TABLE PEOPLE (id INTEGER, name CHAR);

INSERT INTO PEOPLE VALUES(1, "A");
INSERT INTO PEOPLE VALUES(2, "B");
INSERT INTO PEOPLE VALUES(3, "C");
INSERT INTO PEOPLE VALUES(4, "D");

CREATE TABLE ADDRESS (id INTEGER, address CHAR, updatedate date);

INSERT INTO ADDRESS VALUES(1, "address-1-1", "2016-01-01");
INSERT INTO ADDRESS VALUES(1, "address-1-2", "2016-09-02");
INSERT INTO ADDRESS VALUES(2, "address-2-1", "2015-11-01");
INSERT INTO ADDRESS VALUES(3, "address-3-1", "2016-12-01");
INSERT INTO ADDRESS VALUES(3, "address-3-2", "2014-09-11");
INSERT INTO ADDRESS VALUES(3, "address-3-3", "2015-01-01");
INSERT INTO ADDRESS VALUES(4, "address-4-1", "2010-05-21");
INSERT INTO ADDRESS VALUES(4, "address-4-2", "2012-02-11");
INSERT INTO ADDRESS VALUES(4, "address-4-3", "2015-04-27");
INSERT INTO ADDRESS VALUES(4, "address-4-4", "2014-01-01");


--Questions

-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
with people_listcte as (
    select p.id as person_id, p.name, a.id AS address_id, a.address, a.updatedate
    from people p
    join address a ON p.id = a.id
    group by p.id
)
select *
from people_listcte;
  
-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE

--using CTE and window function
with latest_address as (
  select p.id, p.name, a.address, a.updatedate,
    row_number() over (partition by p.id  order by a.updatedate desc) as row_num
  from people p
  join address a
  on p.id = a.id
)
select id, name, address, updatedate
from latest_address
where row_num = 1;

--using normal join query
select p.*, a.*
from people p
left join address a on p.id = a.id
where a.updatedate = (
  select MAX(updatedate)
  from address
  where id = p.id
);
