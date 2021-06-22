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
left outer join dept d on e1.dep_no = d.dep_no)
left outer join salary_grade s1 on e1.salary between s1.min_salary and s1.max_salary)
left outer join employee e2 on e1.mgr_emp_no = e2.emp_no)
left outer join salary_grade s2 on e2.salary between s2.min_salary and s2.max_salary
order by c.cus_no asc;



select
    c.cus_no "고객번호"
    , c.cus_name "고객명"
    , nvl(to_char(e1.emp_no), '없음') "담당직원번호"
    , nvl(e1.emp_name, '없음') "담당직원명"
    , nvl(d.dep_name, '없음') "담당직원소속부서명"
    , nvl(to_char(s1.sal_grade_no), '없음') "담당직원연봉등급"
    , nvl(e2.emp_name, '없음') "담당직원직속상관명"
    , nvl(e2.jikup, '없음') "담당직원직속상관직급"
    , nvl(to_char(s2.sal_grade_no), '없음') "직속상관연봉등급"
from
    ((((customer c left outer join employee e1 on c.emp_no = e1.emp_no)
    left outer join dept d on e1.dep_no = d.dep_no)
    left outer join salary_grade s1 on e1.salary between s1.min_salary and s1.max_salary)
    left outer join employee e2 on e1.mgr_emp_no = e2.emp_no)
    left outer join salary_grade s2 on e2.salary between s2.min_salary and s2.max_salary
order by c.cus_no asc;


--<105>
select emp_name, call_num from employee
union
select cus_name, call_num from customer


--<106>
select emp_name, call_num from employee
union all
select cus_name, call_num from customer




--<86> 함수 다시 해보기.





--replace
select replace( 'You are not alone', 'You', 'We' ) from dual;
select replace( 'You are not alone', 'not' ) from dual;
select replace( 'You are not alone', 'not', '' ) from dual;
-------------------------------
select translate( 'You are not alone', 'You', 'We' ) from dual;


--initcap
select  initcap( 'abc def' ) from dual;


--lpad( s1, n, s2 )

select lpad( 'abc', 7, ' ' ) from dual;

select lpad( 'abc', 7, '#' ) from dual;


--rpad( s1, n, s2 )

select rpad( 'abc', 7, '#' ) from dual;




--instr( s1, s2, n1, n2 )

select
  instr( 'Every Sha-la-la-la Every wo-o-wo-o', 'la' ),
  instr( 'Every Sha-la-la-la Every wo-o-wo-o', 'la', 1),
  instr( 'Every Sha-la-la-la Every wo-o-wo-o', 'la', 1, 2),
  instr( 'Every Sha-la-la-la Every wo-o-wo-o', 'la', 12, 2)
from dual;


--<108>

select * from employee
	where salary = (select max(salary) from employee);




--<110>
select * from employee
where salary = (select max(salary) from employee where dep_no = 20)

--<주의> 다른부서의 3500 받는사람도있으면 출력되어 버린다.
--20번 부서의 최고연봉자와 같은연봉을 받는사람이 다 출력된다.

select * from employee
where salary = (select max(salary) from employee where dep_no = 20) and dep_no = 20;

--또한번 20번 부서를 정해줘야지. 20번 부서에서 최고 연봉자만 나온다.


--<>

--<join 으로>

select
c.cus_no         "고객번호"
,c.cus_name      "고객명"
,e.emp_no        "직원번호"
,e.emp_name      "직원이름"
,e.jikup         "직급"

from
customer c, employee e

where
c.emp_no = e.emp_no;


--<subquery 로>
select
cus_no "고객번호"
,cus_name "고객명"
,(select emp_no from employee) "직원번호"

from customer


--<111>
select
    emp_name "직원명"
    ,jikup "직급"
    ,salary "연봉"
    ,floor(salary / (select sum(salary) from employee) * 100) ||'%' "연봉비율"
from
    employee
order by
    salary/(select sum(salary) from employee)*100 desc;

-- order by 에서는 floor 써서 소수점 버릴 필요가 없다. 오히려 소수점이 있으면 더 정확하게 나열한다.
-------------------------------------------------------------------
select
    emp_name "직원명"
    ,jikup "직급"
    ,salary "연봉"
    ,trunc(salary / (select sum(salary) from employee) * 100, 1) ||'%' "연봉비율"   -- trunc 사용하여 소수점 조절.
from
    employee
order by
    salary/(select sum(salary) from employee)*100, desc;

--<주의>정렬할때는 소수점 컨트롤을 하지 말고 소수점이 널부러지게 하고 정렬해야 정확한 정렬이 된다.


--<112>
-------------------------------------------------------------------
--조인(join) 답
-------------------------------------------------------------------
select
	c.cus_no
	,c.cus_name
	,c.emp_no
from
	customer c, employee e
where
	c.emp_no = e.emp_no and e.dep_no = 10;
-------------------------------------------------------------------
--서브쿼리(subquery) 답
-------------------------------------------------------------------
select
	cus_no "고객번호"
	,cus_name "고객명"
	,emp_no
from
	customer
where
	emp_no in(select emp_no from employee where dep_no=10)
-------------------------------------------------------------------
--n행1열 서브쿼리 쓰면 , 자동으로 붙어서 나오게 된다.
-------------------------------------------------------------------
--	in 뒤에 n행 1열의 결과가 나오는 서브쿼리가 나오면 n행 1열의 데이터가 in 뒤에 콤마(,)로 나열된다.
-------------------------------------------------------------------
--서브쿼리(subquery) 답
-------------------------------------------------------------------
	select
		cus_no "고객번호"
		,cus_name "고객명"
		,emp_no
	from
		customer
	where
		emp_no = any(select emp_no from employee where dep_no=10)

--<113>
select
	emp_name "직원명"
	,salary "연봉"
	, (select avg(salary)from employee)  "전체평균연봉"
	, (select max(salary)from employee)  "전체최대연봉"
from
	employee
where
	salary>= (select avg(salary) from employee)
	and
	salary< (select max(salary) from employee);




--<114>
select
	e.emp_no
	,e.emp_name
	,d.dep_name
	,e.salary

from
 employee e, dept d

where
 e.dep_no = d.dep_no
and
e.salary = (select max(salary) from employee);


--<115>
select
	e.emp_no
	,e.emp_name
	,e.jikup
from
	employee e
where
	(select count(c.emp_no) from customer c where e.emp_no=c.emp_no) >=2;



--<112> 상관쿼리로 풀이.
select
	c.cus_no
	,c.cus_name
	,c.emp_no
from
	customer c
where
	(select e.dep_no from employee e where c.emp_no=e.emp_no) = 10;

-------------------------------------------------------------------
select
	c.cus_no
	,c.cus_name
	,c.emp_no
from
	customer c
where
	(select count(*) from employee e where c.emp_no = e.emp_no and e.dep_no=10)>0;



--<116>
--조인(join) 답
-----------------------------------------------------------------
select
	e.emp_no    "직원번호"
	,e.emp_name "직원명"
	,d.dep_name "소속부서명"
from
	employee e, dept d
where
	e.dep_no = d.dep_no;

-----------------------------------------------------------------
--서브쿼리 답
-----------------------------------------------------------------
select
	e.emp_no    "직원번호"
	,e.emp_name "직원명"
	,(select d.dep_name from dept d where d.dep_no = e.dep_no) "소속부서명"
from
	employee e;


--<117>
select
	e1.emp_no    "직원번호"
	,e1.emp_name "직원명"
	,e1.salary   "연봉"
	,(select count(*)+1 from employee e2 where e2.salary>e1.salary)  "연봉순위"
from
 employee e1
order by
	4 asc;


--<118>
select
	e.emp_no    "직원번호"
	,e.emp_name "직원명"
	,(select count(*) from customer c where c.emp_no = e.emp_no) "담당고객수"
from
	employee e;



--<119>

update employee set dep_no=40 where emp_no=2;

commit;

-- 부서번호 수정 후. 하기.
select
	d.dep_name "부서명"
	,(select count(*) from employee e where d.dep_no = e.dep_no)||'명'  "부서직원수"
	,(select count(*) from customer c, employee e where d.dep_no = e.dep_no and c.emp_no = e.emp_no)||'명' "부서담당고객수"
from
	dept d;


--<120>
select
	e.emp_no
	,e.emp_name
	,e.jikup
	,e.jumin_num
	,(select * from employee e where decode( e.jikup
		,'사장', 1
		,'부장', 2
		,'과장', 3
		,'대리', 4
		,'주임', 5
		,6
	) ) "직급서열순위"
from
	employee e
order by
	5 asc;
