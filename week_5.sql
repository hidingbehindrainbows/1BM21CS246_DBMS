create database employee;
use employee;
create table project(
p_no int primary key,
p_loc varchar(40),
p_name varchar(40)
);
create table dept(
dept_no int primary key,
d_name varchar(40),
d_loc varchar(40)
);
create table employee(
emp_no int primary key,
e_name varchar(40),
mgr_no int,
hire_date date,
sal int,
dept_no int,
foreign key (dept_no) references dept(dept_no) on delete cascade
);
create table incentives(
emp_no int,
incentive_date date primary key,
incentive_amount int,
foreign key (emp_no) references employee(emp_no) on delete cascade
);
create table assigned_to(
emp_no int,
p_no int,
job_role varchar(50),
foreign key (p_no) references project(p_no) on delete cascade,
foreign key (emp_no) references employee(emp_no) on delete cascade
);

insert into project values(1,"Beng","p_1"),
(2,"Guj","p_2"),
(3,"Mys","p_3"),
(4,"Hyder","p_4"),
(5,"Mumb","p_5");

insert into dept values(10,"Sales","Beng"),
(20,"Finance","Bengal"),
(30,"Marketing","Bihar"),
(40,"Purchase","Mumb"),
(50,"R&D","Hyder");

insert into employee values(100,"Prannay",400,"2003-01-01",100000,10),
(200,"Farhaan",500,"2004-02-02",100500,50),
(300,"Sanika",100,"2003-01-21",200500,30),
(400,"Sakshi", NULL ,"2008-02-17",300500,40),
(500,"Nishith",300,"2004-03-05",200700,40),
(600,"Sohan",200,"2005-11-01",200000,20),
(700,"Mahima",200,"2005-11-21",200900,20);

insert into incentives values(100,"2012-02-17",6000),
(200,"2012-05-21",7000),
(400,"2012-07-25",6500),
(500,"2013-04-19",7400),
(600,"2013-08-08",8000);

insert into assigned_to values(100,1, "P_Manager"),
(200,1, "R_Manager"),
(300,2, "B_Analyst"),
(400,3, "B_Analyst"),
(500,3, "P_Manager"),
(600,5, "R_Manager");

select ato.emp_no
from project p, assigned_to ato
where p.p_no = ato.p_no and p.p_loc in ('Beng','Mys','Hyder');

select emp_no
from employee
where emp_no not in( select emp_no from incentives);

select e.e_name, e.emp_no, ato.job_role, d.d_name, d.d_loc, p.p_loc
from employee e, dept d, project p, assigned_to ato
where e.emp_no = ato.emp_no and p.p_no = ato.p_no and e.dept_no = d.dept_no;