
--查询指定员工的姓名和薪资，保存在变量中 。
declare
  v_name emp.e_name%type; --声明变量 v_name 数据类型就是 emp表e_name这一列的数据类型
  v_sal  emp.e_salary%type;
begin 
  --给变量赋值   使用  select  into 语法 
  select e_name,e_salary into v_name,v_sal from emp where e_id = 100013 ;
  dbms_output.put_line('姓名:' || v_name);
  dbms_output.put_line('薪资:' || v_sal);
end ; 

--查询指定员工的姓名，薪资，部门编号，岗位，入职日期

declare
  v_emp  emp%rowtype ; 
 --v_emp变量是 emp 表里面一行的类型 。
begin 
  select * into v_emp from emp where e_id = 100013;
  dbms_output.put_line('姓名:' || v_emp.e_name);
  dbms_output.put_line('薪资:' || v_emp.e_salary);
 dbms_output.put_line('薪资:' || v_emp.deptno);
end ; 


-- record 记录类型 。
/*
   如何定义记录类型 
*/

declare
   --声明一个记录类型 。   声明数据类型 。
   type emp_record is record 
   (
        eno emp.e_id%type ,
        ename emp.e_name%type, 
        esal  emp.e_salary%type 
   );
   --声明变量 ，   这个变量就是  emp_record 类型 
   v_emp emp_record ; 
begin 
   select e_id ,e_name ,e_salary into v_emp from emp where e_id = 100013 ;
   dbms_output.put_line(v_emp.ename)  ;
   dbms_output.put_line(v_emp.esal)  ;
end ; 



--条件表达式 
declare
    num1 int := 200 ;
    num2 int := 200 ;
begin 
    if num1 < num2 then 
       dbms_output.put_line('ok');
    elsif num1 = num2 then 
       dbms_output.put_line('==');    
    else 
        dbms_output.put_line('error');
    end if ; 
end ; 



--比较三个数字的大小 。

declare
     num1 int := &num1 ;        
     num2 int := &num2 ;        
     num3 int := &num3 ;        
begin 
     if num1 < num2 then 
        if num2 < num3 then 
           dbms_output.put_line(num3 || '最大');
        else 
           dbms_output.put_line(num2 || '最大');
        end if ; 
     else 
        if num1 < num3 then 
           dbms_output.put_line(num3 || '最大');
        else
           dbms_output.put_line(num1 || '最大');
        end if ; 
     end if ; 
end; 

--循环结构   loop  exit  end loop ; 

declare
    num1 int := 20 ;
    num2 int := 25 ;
begin 
    loop 
         if num1 > num2 then
            exit; 
         else 
            num1 := num1 + 1 ; 
            dbms_output.put_line(num1) ; 
         end if ; 
    end loop ; 
end ; 

--循环结构  loop  exit  when   end loop ;  
declare
    num1 int := 20 ;
    num2 int := 25 ;
begin 
    loop 
         num1 := num1 + 1; 
         exit when num1 > num2 ;
         dbms_output.put_line(num1);
    end loop ; 
end ; 

--循环结构   while循环 

declare
    num1 int := 20 ;
    num2 int := 25 ;
begin 
    while num1 < num2 
    loop 
         num1 := num1 + 1; 
         dbms_output.put_line(num1);
    end loop ; 
end ; 

--for  in 循环 。

declare
       num1 int := 1 ;
       num2 int := 25 ;
begin
       for i in num1..num2 
       loop 
           dbms_output.put_line(i) ;
       end loop ;
end ; 

--招商基金里面去面试   sql分页怎么写。




--游标案例 
declare
        cursor mycur is select * from emp  where  deptno in ('d01') ; 
        v_cur mycur%rowtype ;       
begin 
        open mycur ; 
        --循环便利这个游标 。
        loop 
            fetch mycur into v_cur ; 
            if mycur%notfound then 
               exit;  
            end if ; 
            dbms_output.put_line(v_cur.e_id || '  ' || v_cur.e_name) ;
        end loop ; 
        close mycur ; 
end ; 

-- loop exit when end loop ; 
declare
        cursor mycur is select * from emp  where  deptno in ('d01') ; 
        v_cur mycur%rowtype ;       
begin 
        open mycur ; 
        --循环便利这个游标 。
        loop 
            fetch mycur into v_cur ; 
            exit when mycur%notfound ; 
            dbms_output.put_line(v_cur.e_id || '  ' || v_cur.e_name) ;
        end loop ; 
        close mycur ; 
end ; 


-- for in 循环。
/*
   使用for in循环便利游标最简洁，最方便
   默认的 打开和关闭游标  还可以自动提取数据。
*/

declare
     cursor mycur is select * from emp  where  deptno in ('d01') ; 
begin 
     for v_cur in mycur 
     loop 
         dbms_output.put_line(v_cur.e_id || '  ' || v_cur.e_name) ;
     end loop; 
end ; 

--如果 d01 加 500 d02  300  d03 加 100 
declare
     cursor mycur is select * from emp  where  deptno in ('d01','d02','d03') ; 
begin 
     for v_cur in mycur 
     loop 
         if v_cur.deptno = 'd01' then 
            v_cur.e_salary := v_cur.e_salary + 500 ; 
         elsif v_cur.deptno = 'd02' then
            v_cur.e_salary := v_cur.e_salary + 300 ; 
         else
            v_cur.e_salary := v_cur.e_salary + 100 ; 
         end if; 
     end loop ;
     commit ; 
end ; 

drop trigger tri_emp_sal ;
select * from emp where  e_id = 100051 ; 

update emp set  e_salary = e_salary + 500 where e_id = 100051 ; 


-- case when 

declare
   cursor mycur (deptno varchar2) is select * from emp ;  
begin 
   for v_cur in mycur('d01') 
   loop 
       dbms_output.put_line(v_cur.e_id);
   end loop ; 
end ; 


--预定义异常
declare
    v_emp emp%rowtype ; 
begin 
    dbms_output.put_line(1/0) ;
    select * into v_emp from emp ;
    dbms_output.put_line(v_emp.e_id);
    exception 
    when cursor_already_open then 
        dbms_output.put_line('游标已经打开');
    when no_data_found then 
        dbms_output.put_line('用户不存在');
    when too_many_rows then
        dbms_output.put_line('查询到多行结果集'); 
    when others then 
        dbms_output.put_line('其他异常~'); 
end ; 

--自定义异常 。
declare
      exc exception ;  
begin
     update emp set e_salary = e_salary * 1.1 where e_id = 1000111;
     if sql%notfound then
        raise exc ;
     else 
        dbms_output.put_line('更新成功');
        commit ;   
     end if ; 
     exception 
         when exc then 
              dbms_output.put_line('此用户不存在') ;
              rollback; 
         when others then 
              dbms_output.put_line('其他异常~') ;
              rollback; 
end ;




