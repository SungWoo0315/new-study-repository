<2021-06-28>

--<139>
--inline view

--<140>
select
	e.*
from
	employee e

--rownum 테이블이 자동으로 붙는다.
select
	rownum, e.*
from
	employee e

--order by salary 해주면 일련번호가 꼬인다. 이때 인라인뷰가 필요함.
--salary 정렬하고 rownum이 붙는것이 아니다. 먼저 붙어버리고 정렬되어서 꼬임.
select
	rownum, e.*
from
	employee e
order by salary


select
	rownum, emp_no, emp_name, jikup
from
	employee


select
	rownum, dep_no, dep_name, loc
from
	dept;


select
	rownum, emp_no, emp_name, jikup
from
	employee
where
	rownum<=10
order by
	salary desc


select
	rownum, e.*
from
	employee e
where
	rownum<=10
order by
	salary desc

-- inline view를 써서 정렬해주면 원하는 결과를 얻을수 있다.
select
	rownum, e.*
from
	(select * from employee order by salary desc) e
where
	rownum<=10

-- 위를 활용하여 11행부터 20행까지 조건. 하지만, 나오지 않는다.
-- rownum이 where절에 들어갈때 rownum 1이 들어가서 true 되는 조건만 나올수 있는데,
-- rownum>=11 에서 1이 포함 안되기 때문에 false.
-- 이런식으로는 행 검색을 할 수 없다.
select
	rownum, e.*
from
	(select * from employee order by salary desc) e
where
	rownum>=11 and rownum<=20

--

select
	rownum RNUM, e.*
from
	(select * from employee order by salary desc) e
where
	rownum<=10

-- 11행 부터 20행까지 추출.
select
	*
from
(
select
	rownum RNUM, e.*
from
	(select * from employee order by salary desc) e
where
	rownum<=20
)
where
	RNUM>=11


-- 6행부터 10행까지 추출.
select
	*
from
(
select
	rownum RNUM, e.*
from
	(select * from employee order by salary desc) e
where
	rownum<=10
)
where
	RNUM>=6

--정답은 동일하다. 바깥쪽에선 RNUM 단순 컬럼으로 인식.
select
	*
from
(
select
	rownum RNUM, e.*
from
	(select * from employee order by salary desc) e
)
where
	RNUM>=1 and RNUM<=10;



-- 고객을 나이대로 서열 정리. 6행부터 10행까지.

select * from ( select rownum RNUM, zxcvb.* from (
	select * from customer
	order by
		decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,6) asc
) zxcvb where rownum<=10 ) where RNUM>=6;

-- <새끼문제> 직원 직급 서열중 2행~5행 까지 검색하면?

select * from ( select rownum RNUM, zxcvb.* from (
	select * from employee
	order by
		decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, '사원', 6) asc
) zxcvb where rownum<=5 ) where RNUM>=2;




-- <127>번 문제를 인라인뷰로 풀이.


-- group by
select
  dep_no                "부서번호"
  ,jikup                "직급"
  ,sum(salary)          "급여합"
  ,round(avg(salary),1) "평균급여"
  ,count(*)||'명'       "인원수"
from
  employee
group by
  dep_no, jikup
having
  count(*) >= 3;
------------------------------------------------------------
group by 결과물에서 행을 골라낼 때에는 where 을 쓰지 말고 having 을 사용한다.

-- inline view
select
  *
from
(
select
  dep_no                DEP_NO
  ,jikup                JIKUP
  ,sum(salary)          TOT_SALARY
  ,round(avg(salary),1) AVG_SALARY
  ,count(*)             EMP_CNT
from
  employee
group by
  dep_no, jikup
)
where
  EMP_CNT >= 3



-- <135>번 인라인뷰 사용.

-- <135>
select
	to_char(hire_date, 'MM')||'월' "입사월"
	,count(emp_no)||'명' "입사인원수"
from
	employee
group by
	to_char(hire_date, 'MM')||'월'
order by
	"입사월" asc;


-- inline view 사용
-- m.month => m.월월 변경. 그래도 실행 가능.
select
  m.월월||'월'                         "입사월"
  ,count(e.emp_name)||'명'           "입사인원수"
from
(
select '01' "월월" from dual union
select '02' from dual union
select '03' from dual union
select '04' from dual union
select '05' from dual union
select '06' from dual union
select '07' from dual union
select '08' from dual union
select '09' from dual union
select '10' from dual union
select '11' from dual union
select '12' from dual
) m
,employee e
where
  to_char(e.hire_date(+), 'MM') = m.월월
group by
  m.월월||'월'
order by
  "입사월";

--상관쿼리로 풀이

select
	  m.month||'월'                      "입사월"
		,(select count(*) from employee e where to_char(e.hire_date, 'MM')=m.month )||'명'    "입사인원수"
from
(
select '01' "MONTH" from dual union
select '02' from dual union
select '03' from dual union
select '04' from dual union
select '05' from dual union
select '06' from dual union
select '07' from dual union
select '08' from dual union
select '09' from dual union
select '10' from dual union
select '11' from dual union
select '12' from dual
) m


-- 올바른 풀이는 아니지만 참고. rownum 사용.
select
	  m.month||'월'                      "입사월"
		,(select count(*) from employee e where to_char(e.hire_date, 'MM')=m.month )    "입사인원수"
from
(
  select case when rownum<10 then '0' else '' end||rownum "MONTH" from employee where rownum<=12
) m


--<141>
--내가 한것.
select
	count(*) from
(
select to_char(sysdate, 'DAY') "D" from dual union
select to_char(sysdate+1, 'DAY') from dual union
select to_char(sysdate+2, 'DAY') from dual union
select to_char(sysdate+3, 'DAY') from dual union
select to_char(sysdate+4, 'DAY') from dual union
select to_char(sysdate+5, 'DAY') from dual union
select to_char(sysdate+6, 'DAY') from dual union
select to_char(sysdate+7, 'DAY') from dual union
select to_char(sysdate+8, 'DAY') from dual union
select to_char(sysdate+9, 'DAY') from dual union
select to_char(sysdate+10, 'DAY') from dual
) d
where
d.D!='토'
and d.D!='일'
and d.D!='월'



-- 정답

select count(*) from
(
	select sysdate "XDAY" from dual
	union select sysdate+1 from dual
	union select sysdate+2 from dual
	union select sysdate+3 from dual
	union select sysdate+4 from dual
	union select sysdate+5 from dual
	union select sysdate+6 from dual
	union select sysdate+7 from dual
	union select sysdate+8 from dual
	union select sysdate+9 from dual
	union select sysdate+10 from dual
) d
where
	to_char(d.xday, 'dy', 'nls_date_language = korean')!='토'
	and to_char(d.xday, 'dy', 'nls_date_language = korean')!='일'
	and to_char(d.xday, 'dy', 'nls_date_language = korean')!='월'



--<142>
select
	count(*)
from
	(
		select
				to_date(to_char(sysdate, 'YYYY-MM')||'-01', 'YYYY-MM-DD')+RNUM-1 "XDAY"
			from
			(
				select rownum RNUM from employee union select rownum+20 from employee)
				where RNUM<=to_number(to_char(last_day(sysdate), 'dd')
			)
	) d
where
	to_char( d.xday, 'dy', 'nls_date_language = korean')!='토'
	and to_char(d.xday, 'dy', 'nls_date_language = korean')!='일'
	and XDAY <= last_day(sysdate)


--<42> 다시 풀이
select
	cus_no
	,cus_name
	,emp_no
from
	customer;

-- 정답1 숫자형을 숫자문자형으로 변환.
select
	cus_no
	,cus_name
	,nvl(to_char(emp_no),'없음')
from
	customer;

-- 정답2 숫자형뒤에 길이가 없는 문자데이터 ||'' 을 이어 붙여주어서 앞의 숫자형이 자동으로 문자형으로 형변환 된다.
select
	cus_no
	,cus_name
	,nvl(emp_no||'','없음')
from
	customer;


--<43> 다시풀이

select
  	cus_no
  	,cus_name
  	,nvl2(emp_no,'있음', '없음')
	from
  	customer;


-- <104>
-- 20210628.md 참고하기.
select
	c.cus_no	"고객번호"
	,c.cus_name "고객명"
	,nvl(to_char(e1.emp_no),'없음')	"담당직원번호"
	,nvl(e1.emp_name,'없음') "담당직원명"
	,nvl(d.dep_name,'없음') "담당직원소속부서명"
	,nvl(to_char(s1.sal_grade_no),'없음') "담당직원연봉등급"
	,nvl(e1.mgr_emp_no||'', '없음') "담당직원번호"
	,nvl(e2.emp_name,'없음') "담당직원직속상관명"
	,nvl(e2.jikup,'없음') "담당직원직속상관직급"
	,nvl(to_char(s2.sal_grade_no),'없음') "직속상관연봉등급"
from
	customer c, employee e1, dept d, salary_grade s1, employee e2, salary_grade s2

where
	c.emp_no = e1.emp_no(+)
	and
	e1.dep_no = d.dep_no(+)
	and
	e1.salary between s1.min_salary(+) and s1.max_salary(+)
	and
	e1.mgr_emp_no = e2.emp_no(+)
	and
	e2.salary between s2.min_salary(+) and s2.max_salary(+)


--<112>
select
	cus_no "고객번호"
	,cus_name "고객명"
	,emp_no
from
	customer
where
	emp_no in(1,9,12,13,15,20); --10번 부서의 번호를 나열한 것이다.

-- 서브쿼리(비상관쿼리)로 작성.
select
	cus_no "고객번호"
	,cus_name "고객명"
	,emp_no
from
	customer
where
	emp_no in(select emp_no from employee where dep_no=10) -- select문은 n행 1열 규칙을 지켜야 한다.
--서브쿼리가 바깥과 전혀 상관성이 없다. 그래서 비상관 쿼리.


-- 50번 부서 검색. 조건에 맞지 않아서 아무것도 안나온다. 에러는 아니다.
select
	cus_no "고객번호"
	,cus_name "고객명"
	,emp_no
from
	customer
where
	emp_no in(select emp_no from employee where dep_no=50)
	-- emp_no=any (select emp_no from employee where dep_no=50)
	-- in 대신 any도 쓸 수 있다. `=` 을 주의해서 써주어야 한다.

--주의할것. 50번 부서는 존재하지 않기때문. 검색이 안될 뿐. 에러가 아니다.


-- 위의 문제를 [상관 쿼리]로 적은것.
select
	c.cus_no
	,c.cus_name
	,c.emp_no
from
	customer c
where
	(select e.dep_no from employee e where c.emp_no=e.emp_no) = 10;


-- 위의 문제를 [join 조인]으로 적은것.
select
	c.cus_no
	,c.cus_name
	,c.emp_no
from
	customer c, employee e
where
	c.emp_no = e.emp_no and e.dep_no = 10;




-- <117>
























