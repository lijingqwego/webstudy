select * from items ; 


drop table s7 ; 

create table s7 
(
       sid int  primary key  ,
       sname varchar2(20)
) ;
select * from s7 ; 

insert into s7 values (seq.nextval,'小红') ;

drop sequence seq ; 

create sequence seq 
maxvalue  50000000
minvalue  10000
start with 10000
increment by 1
cycle ;

select seq.nextval from dual; 


select * from s7 ; 

select user from dual; 

--创建公共同义词
drop public synonym s7 ; 
create public synonym s7 for s7 ; 


select * from s7 ; 
delete from sy_s7 where sid = 10000 ;



create or replace view v_sales
as
select s_years ,
max(decode(s_months,'1季度',s_money)) as 一季度 ,
max(decode(s_months,'2季度',s_money)) as 二季度 ,
max(decode(s_months,'3季度',s_money)) as 三季度 ,
max(decode(s_months,'4季度',s_money)) as 四季度
from sales  group by s_years ; 


select * from v_sales; 


select * from temp_sales ;

select * from sales for update ; 

create or replace view v_emp
as
select emp.e_id,e_name ,e_age ,deptno,job,e_hiredate from emp 
where deptno in ('d01','d02')
with check option ; 

select * from v_emp for update ; 

--查询员工信息，按照部门编号升序排列,按照薪资降序排列
--首先按照部门编号升序，部门编号相同的情况下，按照薪资降序排列
select * from emp order by deptno , e_salary desc ; 


-- 查询员工信息，按照员工薪资降序排列 。
select * from emp order by decode(e_salary,null,
(select avg(e_salary)from emp),e_salary)


select * from emp where e_salary  is null  

select * from emp ; 
--统计每个部门下 .每个岗位的 的人数 
select deptno ,job ,count(*) from emp group by deptno ,job 
order by deptno ; 



