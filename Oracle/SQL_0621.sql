

--<90>

select
        employee.emp_no
        ,employee.emp_name
        ,dept.dep_name
    from
        employee, dept
    where
        employee.dep_no=dept.dep_no


-- 별칭 버전.
select
            e.emp_no
            ,e.emp_name
            ,d.dep_name
        from
            employee e, dept d
        where
            e.dep_no=d.dep_no



-- ANSI inner join
select
	e.emp_no
	,e.emp_name
	,d.dep_name
from
	employee e inner join dept d
on
	e.dep_no=d.dep_no


--<91>

select
	c.cus_name	"고객명"
	,c.tel_num	"고객전화번호"
	,e.emp_name	"담당직원명"
	,e.jikup	"담당직원직급"
from
	customer c, employee e
where
	c.emp_no=e.emp_no


--<92>

--Oracle join
select
		c.cus_name	"고객명"
		,c.tel_num	"고객전화번호"
		,e.emp_name	"담당직원명"
		,e.jikup	"담당직원직급"
	from
		customer c, employee e
	where
		c.emp_no=e.emp_no and e.dep_no = 10


--ANSI join
select
		c.cus_name	"고객명"
		,c.tel_num	"고객전화번호"
		,e.emp_name	"담당직원명"
		,e.jikup	"담당직원직급"
	from
		customer c inner join employee e
	on
		c.emp_no=e.emp_no
	where
		e.dep_no = 10


--<93>

select
	c.cus_name	"고객명"
	,c.tel_num	"고객전화번호"
	,e.emp_name	"담당직원명"
	,e.jikup	"담당직원직급"
from
	customer c, employee e
where
	c.emp_no=e.emp_no and e.salary >= 3000;


select
	c.cus_name	"고객명"
	,c.tel_num	"고객전화번호"
	,e.emp_name	"담당직원명"
	,e.jikup	"담당직원직급"
from
	customer c inner join employee e
on
	c.emp_no=e.emp_no
where
	e.salary >= 3000;


--<94>

-------------------------------------------------
오라클 조인
-------------------------------------------------
select
	e.emp_name	"직원명"
	,e.jikup	"직원직급"
	,d.dep_name	"직원부서명"
	,c.cus_name	"담당고객명"
	,c.tel_num "고객전화번호"
from
	 employee e, dept d, customer c
where
	e.dep_no=d.dep_no and e.emp_no=c.emp_no
order by
	e.emp_name asc;
-------------------------------------------------
ANSI 조인
-------------------------------------------------
select
	e.emp_name	"직원명"
	,e.jikup	"직원직급"
	,d.dep_name	"직원부서명"
	,c.cus_name	"담당고객명"
	,c.tel_num "고객전화번호"
from
	 (employee e inner join dept d on e.dep_no=d.dep_no)
	 inner join customer c on c.emp_no=e.emp_no
order by
	e.emp_name asc;




--<95>
select
	e.emp_name	"직원명"
	,e.jikup	"직원직급"
	,d.dep_name	"소속부서명"
	,s.sal_grade_no "연봉등급"
from
	 employee e, dept d, salary_grade s
where
	e.dep_no=d.dep_no and (e.salary>=s.min_salary and e.salary<=s.max_salary)
order by
	s.sal_grade_no asc
	,decode(e.jikup, '사장',1,'부장',2, '과장',3, '대리',4,'주임',5,6) asc
	,	case
			when substr(e.jumin_num,7,1) in('1','2') then '19'
			else '20'
		end || substr(e.jumin_num,1,6)
		asc;


--ANSI
select
  e.emp_name	"직원명"
  ,e.jikup	"직원직급"
  ,d.dep_name	"소속부서명"
  ,s.sal_grade_no "연봉등급"
from
	 (employee e inner join dept d on e.dep_no=d.dep_no)
	 inner join salary_grade s on (e.salary>=s.min_salary and e.salary<=s.max_salary)
order by
	s.sal_grade_no asc
	,decode(e.jikup, '사장',1 ,'부장',2, '과장',3, '대리',4,'주임',5,6) asc
	,	case
		when substr(e.jumin_num,7,1) in('1','2') then '19'
		else '20'
	end || substr(jumin_num,1,6)
	asc;



























