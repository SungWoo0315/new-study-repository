<2021-06-22 화요일>

--<103> 추가문제
select
  c.cus_no
  ,c.cus_name
from
  customer c, employee e
where
c.emp_no = e.emp_no
and
(e.dep_no = 10 or e.dep_no = 30)
--e.dep_no in (10,30)  --in 으로도 사용 가능.



--<104>
select
    c.cus_no    "고객번호"
    ,c.cus_name "고객명"
    ,nvl(to_char(e1.emp_no),'없음')    "담당직원번호"
    ,nvl(e1.emp_name,'없음') "담당직원명"
    ,nvl(d.dep_name,'없음') "담당직원소속부서명"
    ,nvl(to_char(s1.sal_grade_no),'없음') "담당직원연봉등급"
    ,nvl(e2.emp_name,'없음') "담당직원직속상관명"
    ,nvl(e2.jikup,'없음') "담당직원직속상관직급"
    ,nvl(to_char(s2.sal_grade_no),'없음') "직속상관연봉등급"
    --,nvl(c.cus_name||'','없음') -> to_char 대신 쓰는 방법.
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


--ANSI join

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
	--,nvl(c.cus_name||'','없음') -> to_char 대신 쓰는 방법.
from ((((customer c left outer join employee e1 on c.emp_no = e1.emp_no)
lef outer join dept d on e1.dep_no = d.dep_no)
lef outer join salary_grade s1 on e1.salary between s1.min_salary and s1.max_salary)
lef outer join employee e2 on e1.mgr_emp_no = e2.emp_no)
lef outer join salary_grade s2 on e2.salary between s2.min_salary and s2.max_salary
order by c.cus_no asc;



--<105>
select emp_name, call_num from employee
union
select cus_name, call_num from customer


--<106>
select emp_name, call_num from employee
union all
select cus_name, call_num from customer















