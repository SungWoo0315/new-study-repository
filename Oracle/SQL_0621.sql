

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
	 employee e inner join dept d inner join customer c
on
	e.dep_no=d.dep_no and c.emp_no=c.emp_no;































