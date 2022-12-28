create database airlines;
use airlines;
create table flights(
fl_no int primary key,
from_ varchar(20),
to_ varchar(20),
distance int,
departs time,
arrives time,
price int
);
create table aircraft(
a_id int primary key,
a_name varchar(20),
cruising_Range int
);
create table employee(
e_id int primary key,
e_name varchar(20),
salary int
);
create table certified(
e_id int,
a_id int,
FOREIGN KEY(e_id) REFERENCES employee(e_id) on update cascade on delete cascade,
FOREIGN KEY(a_id) REFERENCES aircraft(a_id) on update cascade on delete cascade
);

insert into employee values(101,'Avinash',50000),
(102,'Lokesh',60000),
(103,'Rakesh',70000),
(104,'Santhosh',82000),
(105,'Tilak',5000);

insert into aircraft values(1,'Airbus',2000),
(2,'Boeing',700),
(3,'JetAirways',550),
(4,'Indigo',5000),
(5,'Boeing',4500),
(6,'Airbus',2200);

insert into certified values(101,2),
(101,4),
(101,5),
(101,6),
(102,1),
(102,3),
(102,5),
(103,2),
(103,3),
(103,5),
(103,6),
(104,6),
(104,1),
(104,3),
(105,3);

insert into flights values(1,'Bengaluru','NewDelhi',500,'06:00','09:00',5000),
(2,'Bengaluru','Chennai',300,'07:00','08:30',3000),
(3,'Trivandrum','NewDelhi',800,'08:00','11:30',6000),
(4,'Bengaluru','Frankfurt',10000,'06:00','23:30',50000),
(5,'Kolkata','NewDelhi',2400,'11:00','03:30',9000),
(6,'Bengaluru','Frankfurt',8000,'09:00','23:00',40000);

-- First Query:
select (a.a_name) from employee e inner join certified c
on e.e_id=c.e_id and e.salary>80000 inner join aircraft a on
a.a_id=c.a_id;

-- Second Query:
select c.e_id, max(a.cruising_Range) as Max_Range
from aircraft a, certified c
where c.a_id=a.a_id group by c.e_id having count(*)>=3;

-- Third Query:
select e_name from employee where salary<any(select price
from flights where from_='Bengaluru' and to_='Frankfurt');

-- Fourth Query:
select c.a_id,a.a_name, AVG(e.salary) from certified c, aircraft a,
employee e where a.cruising_Range>1000 and e.e_id=c.e_id and
a.a_id=c.a_id group by c.a_id;

-- Fifth Query:
select distinct e.e_name from employee e, certified c, aircraft a
where a.a_id=c.a_id and e.e_id=c.e_id and a.a_name='Boeing';

-- Sixth Query:
select a.a_id from flights f, aircraft a where (f.from_='Bengaluru'
and f.to_='NewDelhi') and f.distance<=a.cruising_Range ;
