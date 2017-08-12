select * from orders ; 

select o.* ,u.id uids ,u.username ,u.birthday ,d.id did,d.orders_id,d.items_id,
d.items_num from orders o,userInfo u ,orderdetail d 
where o.user_id = u.id  and o.id = d.orders_id ;

select * from items ; 


--用户表
select * from userinfo ;
--订单表 
select * from orders ;
--订单明细表 
select * from orderdetail;
--商品表  
select * from items ;


--查询订单信息，关联用户
select o.* ,u.username,u.sex,u.address from orders o ,userinfo u ,

where o.user_id = u.id and o.id = d.orders_id ;

--查询订单明细 ，关联用户信息 。

select o.* ,u.username,u.sex,u.address,d.items_id,d.items_num from orders o ,userinfo u ，orderdetail d
where o.user_id = u.id ;

--查询用户购买的商品。

--用户下订单，订单中包含了订单明细，订单明细中是不是才有商品 。
/*
   用户和订单 ：一对多的关系 。
   订单和订单明细 ： 一对多的关系 。
   订单明细和商品 ：一个订单明细对应一个商品u。
*/

select * from userinfo u,orders o ,orderdetail d,
items i where u.id = o.user_id 
and o.id = d.orders_id 
and d.items_id = i.id  ;


select * from emp ; 

--根据员工的编号，返回员工的薪资 

create or replace function fun_get_salary
(
       eno in emp.e_id%type
)
return varchar2
as 
       v_sal varchar2(50) ;
begin 
       select e_salary into v_sal from emp where e_id = eno ;
       return v_sal ; 
       exception 
              when no_data_found then 
                   v_sal := '此员工不存在' ;
                   return v_sal ;  
end ;  



--如何调用 ？ 
select fun_get_salary(100047) from dual; 

select * from emp ; 


--输入员工编号，查询员工薪资和部门 。

create or replace function fun_get_salary_deptno
(
       eno in emp.e_id%type ,
       dno out emp.deptno%type
)
return varchar2
as 
       v_sal varchar2(50) ;
     
begin 
       select e_salary,deptno into v_sal,dno from emp where e_id = eno ;
       return v_sal  ; 
       exception 
              when no_data_found then 
                   v_sal := eno || ' 员工不存在' ;
                   return v_sal ;  
end ;  


--调用函数。带有out类型的参数 。

declare
    dno emp.deptno%type ; 
    v_sal varchar2(50) ;
begin 
    v_sal := fun_get_salary_deptno(100047,dno) ;
    dbms_output.put_line(v_sal  || '   ' || dno);
end ; 
; 

-- in  out 类型的参数 。

create or replace function fun_get_salary_deptno_in_out
(
     v_emp in out varchar2
)
return varchar2
as 
       v_sal varchar2(50) ;
begin 
       select e_salary,deptno into v_sal,v_emp from emp where e_id = v_emp ;
       return v_sal  ; 
       exception 
              when no_data_found then 
                   v_sal := v_emp || ' 员工不存在' ;
                   return v_sal ;  
end ;  


--调用函数 
declare
    v_e varchar2(50) := '100013' ;
    v_sal varchar2(50) ;
begin 
    v_sal := fun_get_salary_deptno_in_out(v_e);
    dbms_output.put_line(v_sal  || '   ' || v_e);
end ; 

select * from emp where e_id = 100013 ; 

select * from user_procedures; 

--存储过程
create or replace procedure  getDeptCount
as 
  deptCount int;
begin 
  select count(*) into deptCount from dept ; 
  dbms_output.put_line('dept表共有'||deptCount||'行记录');
end ;


--如何调用存储过程。
--1.使用call 关键字调用 

call getDeptCount() ;

--2.使用plsql块调用
begin
     getDeptCount() ;
end ; 

--3.exec 调用存储过程，只支持在命令窗口 
exec getDeptCount();




create or replace procedure add_emp(
empno emp.e_id%type ,
ename emp.e_name%type ,
deptno emp.deptno%type )
is
begin
       insert into emp(e_id,e_name,deptno)
       values(empno,ename,deptno);
       commit ; 
end;

call add_emp(1000100,'健力宝','d01') ;
select * from emp where e_id = 1000100 ;




select * from emp ; 

select * from emp_history  ; 
alter table emp_history add leavedate date ; 

create table emp_history 
as
select emp.e_id,emp.e_name,emp.e_hiredate,emp.job  from emp 
where 1= 0 ;  


--要求，删除员工之前，向emp_history表中自动添加一条记录。
create or replace trigger tri_del_emp_add_history
before delete 
on emp
for each row 
begin 
    insert into emp_history values (:old.e_id,:old.e_name,:old.e_hiredate,:old.job,sysdate) ;
end ; 


select * from emp  where e_id = 1000100 for update 


delete from emp where e_id = 1000100 ;

select * from emp_history ; 

/*
    :old 表示之前的数据
    :new 表示新的数据
*/

select * from t_default for update; 

create or replace trigger tri_t_default_add_tid
before insert
on t_default 
for each row 
begin 
    select seq.nextval into :new.tid from dual ; 
end ; 

select * from emp  for update ; 
--调薪 。

create  or replace trigger tri_merge_salary
before update of e_salary 
on emp 
for each row 
begin 
    if :new.e_salary < :old.e_salary then 
       raise_application_error(-20000,'薪资不能低于原来的薪资') ;
    end if ; 
end ; 



















