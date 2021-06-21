

--<90>

select
        employee.emp_no           "직원번호"
        ,employee.emp_name        "직원명"
        ,dept.dep_name            "소속부서명"
    from
        employee, dept
    where
        employee.dep_no=dept.dep_no


-- 별칭 버전.
select
            e.emp_no             "직원번호"
            ,e.emp_name          "직원명"
            ,d.dep_name          "소속부서명"
        from
            employee e, dept d
        where
            e.dep_no=d.dep_no



-- ANSI inner join
select
	e.emp_no                      "직원번호"
	,e.emp_name                   "직원명"
	,d.dep_name                   "소속부서명"
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

--ANSI 조인
select
  c.cus_name	"고객명"
  ,c.tel_num	"고객전화번호"
  ,e.emp_name	"담당직원명"
  ,e.jikup	"담당직원직급"
from
  customer c inner join employee e
on
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
	--e.dep_no=d.dep_no and (e.salary>=s.min_salary and e.salary<=s.max_salary)
     e.dep_no=d.dep_no and (e.salary between s.min_salary and s.max_salary) --between을 써도 된다.

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



--<96>
select
	e1.emp_name	"직원명"
	,e1.jikup	"직원직급"
	,e2.emp_name	"직속상관명"
	,e2.jikup "직속상관직급"
from
	employee e1, employee e2
where
	e1.mgr_emp_no = e2.emp_no;



--<97>
--내가한것.
select
	e2.emp_name	"직속상관명"
	,e2.jikup "직속상관직급"
	,e1.emp_name	"직원명"
	,e1.jikup	"직원직급"

from
	employee e1, employee e2
where
	e2.emp_no = e1.mgr_emp_no;


--정답.
select
	e1.emp_name	"직속상관명"
	,e1.jikup	"직속상관직급"
	,e2.emp_name	"직원명"
	,e2.jikup "직원직급"
from
	employee e1, employee e2
where
	e1.emp_no = e2.mgr_emp_no ;


-------------------------------------------------
--ANSI 조인
-------------------------------------------------
select
	e1.emp_name	"직속상관명"
	,e1.jikup	"직속상관직급"
	,e2.emp_name	"직원명"
	,e2.jikup "직원직급"
from
	employee e1 inner join employee e2 on e1.emp_no = e2.mgr_emp_no;


--<98>
select
	e1.emp_name	"직원명"
	,e1.jikup	"직원직급"
	,d.dep_name	"소속부서명"
	,s.sal_grade_no "연본등급"
	,e2.emp_name "직속상관명"
	,e2.jikup "직속상관직급"
	,c.cus_name "담당고객명"
from
	employee e1, dept d, salary_grade s, employee e2, customer c
where
	e1.dep_no = d.dep_no
	and (e1.salary between s.min_salary and s.max_salary)
	and e2.emp_no = e1.mgr_emp_no
	and e1.emp_no = c.emp_no;


-------------------------------------------------
--ANSI 조인
-------------------------------------------------
select
	e1.emp_name	"직원명"
	,e1.jikup	"직원직급"
	,d.dep_name	"소속부서명"
	,s.sal_grade_no "연본등급"
	,e2.emp_name "직속상관명"
	,e2.jikup "직속상관직급"
	,c.cus_name "담당고객명"
from
	(((employee e1 inner join dept d on e1.dep_no = d.dep_no)
	inner join salary_grade s on e1.salary between s.min_salary and s.max_salary)
	inner join employee e2 on e2.emp_no = e1.mgr_emp_no)
	inner join customer c on e1.emp_no = c.emp_no;



--<99>
select
	c.cus_name	"고객명"
	,c.tel_num	"고객전화번호"
	,e.emp_name	"담당직원명"
	,e.jikup	"담당직원직급"
	,e.dep_no "부서번호"
from
	customer c, employee e
where
	c.emp_no=e.emp_no(+);


--<100>
select
	c.cus_no "고객번호"
	,c.cus_name	"고객명"
	,c.tel_num	"고객전화번호"
	,e.emp_name	"담당직원명"
	,e.jikup	"담당직원직급"
	,e.dep_no "부서번호"
from
	customer c, employee e
where
	c.emp_no = e.emp_no(+)
	and e.dep_no(+) = 10
	;

-------------------------------------------------
--ANSI 조인
-------------------------------------------------
select
	c.cus_no "고객번호"
	,c.cus_name	"고객명"
	,c.tel_num	"고객전화번호"
	,e.emp_name	"담당직원명"
	,e.jikup	"담당직원직급"
	,e.dep_no "부서번호"
from
	customer c left outer join employee e
on
	c.emp_no = e.emp_no and	e.dep_no = 10;




--<101>

select
	c.cus_no "고객번호"
	,c.cus_name	"고객명"
	,c.tel_num	"고객전화번호"
	,e.emp_name	"담당직원명"
	,e.jikup	"담당직원직급"
	,s.sal_grade_no "담당직원 연봉등급"
from
	customer c, employee e, salary_grade s
where
	c.emp_no = e.emp_no(+)
	--and e.salary(+) between s.min_salary and s.max_salary;
    and(e.salary>=s.min_salary(+) and e.salary<=s.max_salary(+))
--내가한것.

--정답.
select
	c.cus_no "고객번호"
	,c.cus_name	"고객명"
	,c.tel_num	"고객전화번호"
	,e.emp_name	"담당직원명"
	,e.jikup	"담당직원직급"
	,s.sal_grade_no "담당직원 연봉등급"
from
	customer c, employee e, salary_grade s

where
	c.emp_no = e.emp_no(+)
	--and e.salary between s.min_salary(+) and s.max_salary(+);
    and s.min_salary(+) <= e.salary and s.max_salary(+) >= e.salary

 order by
    c.cus_no asc;



--<102>
select
	c.cus_no	"고객번호"
	,c.cus_name "고객명"
	,c.tel_num	"고객전화번호"

from
	customer c, employee e
where
	e.salary>=3000 and e.emp_no=c.emp_no



--<103>

select
	c.cus_no	"고객번호"
	,c.cus_name "고객명"
	,c.jumin_num	"고객주민번호"

from
	customer c, employee e
where
	to_number(to_char(sysdate, 'YYYY'))
	- to_number(
		case substr(e.jumin_num,7,1) when '1' then '19' when '2' then '19' else '20' end
		||substr(e.jumin_num,1,2)+1) >= 40 and e.emp_no=c.emp_no;


--<104>
select
	c.cus_no	"고객번호"
	,c.cus_name "고객명"
	,nvl(to_char(e1.emp_no),'없음')	"담당직원번호"
	,nvl(e1.emp_name,'없음') "담당직원명"
	,nvl(d.dep_name,'없음') "담당직원소속부서명"
	,nvl(to_char(s1.sal_grade_no),'없음') "담당직원연봉등급"
	,nvl(e2.emp_name,'없음') "담당직원직속상관명"
	,nvl(e2.jikup,'없음') "담당직원직속상관직급"
	,nvl(to_char(s2.sal_grade_no),'없음') "직속상관연봉등급"
	--,nvl(c.cus_name||'','없음')
from
	customer c, employee e1, dept d, salary_grade s1, employee e2, salary_grade s2
where
	c.emp_no = e1.emp_no(+)
	and
	e1.dep_no = d.dep_no(+)
	and
	e1.mgr_emp_no = e2.emp_no(+)
	and
	--s1.min_salary(+) <= e1.salary and s1.max_salary(+) >= e1.salary
	e1.salary between s1.min_salary(+) and s1.max_salary(+)
	and
	--s2.min_salary(+) <= e2.salary and s2.max_salary(+) >= e2.salary
	e2.salary between s2.min_salary(+) and s2.max_salary(+)
order by
c.cus_no asc;






