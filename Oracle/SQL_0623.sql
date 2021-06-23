<2021-06-23 수요일>

--<118>

-- select count(*) from customer where emp_no = 1

select
    e.emp_no    "직원번호"
    ,e.emp_name "직원명"
    ,(select count(*) from customer c where c.emp_no = e.emp_no) "담당고객수"
from
	employee e;



--<119>

select
	d.dep_name "부서명"
	,(select count(*) from employee e where e.dep_no = d.dep_no)||'명'  "부서직원수"
	,(select count(*) from employee e, customer c where e.dep_no = d.dep_no and e.emp_no = c.emp_no)||'명' "부서담당고객수"
from
	dept d
order by 2 desc;


--<120>
--내가한것.
select
	e1.emp_no      "직원번호"
	,e1.emp_name   "직원명"
	,e1.jikup      "직급"
	,e1.jumin_num  "주민번호"
	,(select count(*)+1 from employee e2 where decode( e2.jikup
		,'사장', 1
		,'부장', 2
		,'과장', 3
		,'대리', 4
		,'주임', 5
		,6
	)|| decode (substr(e2.jumin_num,7,1), '1', '19', '2', '19', '20' )
    || substr(e2.jumin_num,1,6)
	< decode( e1.jikup
		,'사장', 1
		,'부장', 2
		,'과장', 3
		,'대리', 4
		,'주임', 5
		,6
	)|| decode (substr(e1.jumin_num,7,1), '1', '19', '2', '19', '20' )
    || substr(e1.jumin_num,1,6) )
	 "직급서열순위"
from
	employee e1
order by
	5 asc;


--decode 말고 다른방식.
select
    e1.emp_no      "직원번호"
    ,e1.emp_name   "직원명"
    ,e1.jikup      "직급"
    ,e1.jumin_num  "주민번호"
    , (select count(*)+1 from employee e2 where case (e2.jikup
        when '사장' then 1
        when '부장' then 2
		when '과장' then 3
		when '대리' then 4
		when '주임' then 5 else 6 end)||case (substr(e2.jumin_num,7,1)
	 	when '1' then '19'
		when '2' then '19'
		else '20' end)||substr(e2.jumin_num,1,6)
< case (e1.jikup
	when '사장' then 1
	when '부장' then 2
	when '과장' then 3
	when '대리' then 4
	when '주임' then 5 else 6 end)||case(substr(e1.jumin_num,7,1)
	when '1' then '19'
	when '2' then '19'
	else '20' end)||substr(e1.jumin_num,1,6)
) "직급서열순위"
from
	employee e1
order by 5;


--강사님 정답.
select
	e1.emp_no      "직원번호"
	,e1.emp_name   "직원명"
	,e1.jikup      "직급"
	,e1.jumin_num  "주민번호"
	,(
		select count(*)+1 from employee e2
		where
		decode( e2.jikup
			,'사장', 1
			,'부장', 2
			,'과장', 3
			,'대리', 4
			,'주임', 5
			,6)
		<
		decode( e1.jikup
			,'사장', 1
			,'부장', 2
			,'과장', 3
			,'대리', 4
			,'주임', 5
			,6)
		or
		(
			e2.jikup = e1.jikup
			and
			to_number(
        decode (substr(e2.jumin_num,7,1), '1', '19', '2', '19', '20' )
		    ||substr(e2.jumin_num,1,6)
      )
      <
			to_number(
        decode (substr(e1.jumin_num,7,1), '1', '19', '2', '19', '20' )
		    ||substr(e1.jumin_num,1,6)
      )
		)
	)         "직급서열순위"
from
	employee e1
order by
	5;


--<121>
--서브쿼리 답
select
	c.cus_no     "고객번호"
	,c.cus_name  "고객명"
	,c.tel_num   "고객전화번호"
	,(select e.emp_name from employee e where e.emp_no = c.emp_no ) "담당직원명"
	,(select e.jikup from employee e where e.emp_no = c.emp_no ) "담당직원직급"
	,(select e.dep_no from employee e where e.emp_no = c.emp_no )"부서번호"
from customer c;


-- 조인답(오라클조인)
select
  c.cus_no     "고객번호"
  ,c.cus_name  "고객명"
  ,c.tel_num   "고객전화번호"
  ,e.emp_name  "담당직원명"
  ,e.jikup     "담당직원직급"
  ,e.dep_no    "부서번호"
from
  customer c, employee e
where
  c.emp_no = e.emp_no(+)
order by
1 asc;


-- 조인답(ANSI 조인)
select
  c.cus_no     "고객번호"
  ,c.cus_name  "고객명"
  ,c.tel_num   "고객전화번호"
  ,e.emp_name  "담당직원명"
  ,e.jikup     "담당직원직급"
  ,e.dep_no    "부서번호"
from
  customer c left outer join employee e
on
  c.emp_no = e.emp_no
order by
1 asc;


--<122>

--서브쿼리 답
select
  c.cus_no     "고객번호"
  ,c.cus_name  "고객명"
  ,c.tel_num   "고객전화번호"
  ,(select e.emp_name from employee e where e.emp_no = c.emp_no and e.dep_no=10 ) "담당직원명"
  ,(select e.jikup from employee e where e.emp_no = c.emp_no and e.dep_no=10 ) "담당직원직급"
  ,(select e.dep_no from employee e where e.emp_no = c.emp_no and e.dep_no=10 )"부서번호"
from customer c;

--조인 답(오라클조인)
select
  c.cus_no     "고객번호"
  ,c.cus_name  "고객명"
  ,c.tel_num   "고객전화번호"
  ,e.emp_name  "담당직원명"
  ,e.jikup     "담당직원직급"
  ,e.dep_no    "부서번호"
from
  customer c, employee e
where
  c.emp_no = e.emp_no(+) and e.dep_no(+)=10
order by
1 asc;

--조인 답(ANSI 조인)
select
  c.cus_no     "고객번호"
  ,c.cus_name  "고객명"
  ,c.tel_num   "고객전화번호"
  ,e.emp_name  "담당직원명"
  ,e.jikup     "담당직원직급"
  ,e.dep_no    "부서번호"
from
  --customer c left outer join employee e
  employee e right outer join customer c     -- 이렇게 바꾸어 적어도 잘 된다.
on
  c.emp_no = e.emp_no
  and e.dep_no=10
order by
1 asc;

--<123>



--<124>
select
	dep_no            "부서번호"
	,sum(salary)      "급여합"
	,floor(avg(salary))      "평균급여"
	,count(*)         "인원수"
from employee
group by dep_no ;



--<125>
select
  jikup             "직급"
  ,sum(salary)      "급여합"
  ,avg(salary)      "평균급여"
  ,count(*)||'명'   "인원수"
from
  employee
group by
  jikup ;





















