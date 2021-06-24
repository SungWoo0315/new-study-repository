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
    , (select count(*)+1 from employee e2 where (case e2.jikup
        when '사장' then 1
        when '부장' then 2
		when '과장' then 3
		when '대리' then 4
		when '주임' then 5 else 6 end||case substr(e2.jumin_num,7,1)
	 	when '1' then '19'
		when '2' then '19'
		else '20' end||substr(e2.jumin_num,1,6)
< case e1.jikup
	when '사장' then 1
	when '부장' then 2
	when '과장' then 3
	when '대리' then 4
	when '주임' then 5 else 6 end||case substr(e1.jumin_num,7,1)
	when '1' then '19'
	when '2' then '19'
	else '20' end||substr(e1.jumin_num,1,6))) "직급서열순위"
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
  ,round(avg(salary),1) "평균급여"
  ,count(*)         "인원수"
from
  employee
group by
  dep_no ;



--<125>
select
  jikup             "직급"
  ,sum(salary)      "급여합"
  ,round(avg(salary),1) "평균급여"
  ,count(*)||'명'   "인원수"
from
  employee
group by
  jikup ;


--<126>
select
  dep_no            "부서번호"
  ,jikup             "직급"
  ,sum(salary)      "급여합"
  ,round(avg(salary),1) "평균급여"
  ,count(*)||'명'   "인원수"
from
  employee
group by
  dep_no, jikup;



--<127>
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


--<128>
select
		dep_no                 "부서번호"
		,case when substr(jumin_num,7,1) in('1','3') then '남' else '여' end "성"
		,sum(salary)           "급여합"
		,round(avg(salary),1)  "평균급여"
		,count(*)||'명'        "인원수"
	from
		employee
	group by
		dep_no, case when substr(jumin_num,7,1) in('1','3') then '남' else '여' end


-- decode로 해봄.
select
	dep_no                 "부서번호"
	,decode(substr(jumin_num,7,1)
	,'1','남'
	,'3','남'
	,'여'
	) "성"
	,sum(salary)           "급여합"
	,round(avg(salary),1)  "평균급여"
	,count(*)||'명'        "인원수"
from
	employee
group by
	dep_no, decode(substr(jumin_num,7,1),'1','남','3','남','여');



--<129>

select
	hire_date     "입사년도"
	,count(*)     "인원수"

from
	employee
group by
	hire_date
order by 1 asc;


-- 연도만 나오게 해보기.

select
	to_char(hire_date, 'YYYY')||'년'     "입사년도"
	,count(*)||'명'     "인원수"

from
	employee
group by
	to_char(hire_date, 'YYYY')
order by "입사년도" asc;



--<130>

select
	dep_no     "부서번호"
	,round(  avg( (SYSDATE - hire_date)/365 ), 1  ) ||'년'    "평균근무년수"

from
	employee
group by
	dep_no
order by 1 asc;



--<131>
select
    to_char(hire_date, 'Q')||'분기'    "입사분기"
    ,count(*)||'명'                    "인원수"
from
    employee
group by
    to_char(hire_date, 'Q')||'분기';


--<132>
select
	trunc(extract(year from hire_date), -1)||'년대'                       "입사연대"
	,case when substr(jumin_num,7,1) in('1','3') then '남' else '여' end  "성"
	,count(*)                                                             "연대별입사자수"
from
	employee
group by
	trunc(extract(year from hire_date), -1)||'년대', case when substr(jumin_num,7,1) in('1','3') then '남' else '여' end
order by "입사연대"




--<133>
select
emp_name    "직원명"
,to_char(hire_date, 'YYYY"년"-MM"월"-DD"일" Q"분기" DAY', 'NLS_DATE_LANGUAGE = Korean') "입사일"
,to_char(add_months(hire_date + (365*20),5) + 10, 'YYYY"년"-MM"월"-DD"일"', 'NLS_DATE_LANGUAGE = Korean') "퇴직일"

from
	employee
group by
	emp_name
	, to_char(hire_date, 'YYYY"년"-MM"월"-DD"일" Q"분기" DAY', 'NLS_DATE_LANGUAGE = Korean')
	, to_char(add_months(hire_date + (365*20),5) + 10, 'YYYY"년"-MM"월"-DD"일"', 'NLS_DATE_LANGUAGE = Korean')

--강사님 정답

select
	emp_name    "직원명"
	,to_char(hire_date, 'YYYY-MM-DD Q')|| '/4분기' || to_char(hire_date, 'DAY', 'NLS_DATE_LANGUAGE = Korean') "입사일"
	,to_char(add_months(hire_date, 5 + 20*12 ) + 10, 'YYYY-MM-DD', 'NLS_DATE_LANGUAGE = Korean') "퇴직일"
from
	employee



--<134>

--내가 한것.
select
	d.dep_no          "부서번호"
	,d.loc            "부서위치"
	,count(e.emp_no)||'명' "직원수"
from
	employee e, dept d
where
	e.dep_no(+) = d.dep_no
group by
	d.dep_no, d.loc
order by 1
-----------------------------------------------

--ANSI 방식으로 작성해보기
select
	d.dep_no          "부서번호"
	,d.loc            "부서위치"
	,count(e.emp_no)||'명' "직원수"
from
  employee e right outer join dept d
on
  e.dep_no(+) = d.dep_no
group by
  d.dep_no, d.loc
order by 1 ;


--강사님 정답
select
	d.dep_no "부서번호"
	,d.loc "부서위치"
	,(select count(*) from employee e where e.dep_no = d.dep_no)||'명' "직원수"
from
	dept d
--where
  --(select count(*) from employee e where e.dep_no = d.dep_no) > 0;





--<135>

select
	to_char(hire_date, 'MM')||'월' "입사월"
	,count(emp_no)||'명' "입사인원수"
from
	employee
group by
	to_char(hire_date, 'MM')||'월'
order by
	"입사월" asc;




--<136>
select
	jikup                           "직급"
	,round(avg(salary),1)           "직급평균연봉"
	,count(*)||'명'   "인원수"
from
	employee
--where

group by
	jikup
--having            --인원수 5명 이상만 보고 싶을때 having을 써서 골라낸다.
    --count(*)>=5
order by
    decode( jikup,'사장', 1,'부장', 2,'과장', 3,'대리', 4,'주임', 5, 6) asc;



--<137>

select
	d.dep_no          "부서번호"
	,d.dep_name       "부서명"
	,count(distinct(e.emp_no))  "직원수"
	,count(c.emp_no)           "관리고객수"
from
	employee e, dept d, customer c
where
	d.dep_no = e.dep_no(+)
	and
	e.emp_no = c.emp_no(+)
group by
	d.dep_no, d.dep_name;



--<138>
select
	e1.emp_no                                "직원번호"
	,e1.emp_name                             "직원명"
	,ceil((sysdate - e1.hire_date)/365)||'년차' "근무년차"
	,60
	- (extract(year from sysdate)
	- to_number(decode(substr(e1.jumin_num,7,1),'1','19','2','19','20')||substr(e1.jumin_num,1,2))+1 )                                        "퇴직일까지 남은 년도"
	,case when
			to_date(
				to_char(sysdate,'YYYY')||substr(e1.jumin_num,3,4)
				, 'YYYYMMDD'
			)
			-
			sysdate
			>=0
		then	--올해 생일을 년-월-일 로 리턴하는 식
			to_char(
					to_date(
							to_char(sysdate,'YYYY')||substr(e1.jumin_num,3,4)
							, 'YYYYMMDD'
					)
					,'YYYY-MM-DD (dy)' , 'NLS_DATE_LANGUAGE = Korean'
			)
		else  --내년 생일을 년-월-일 로 리턴하는 식
			to_char(
					to_date(
							to_number(to_char(sysdate,'YYYY'))+1||substr(e1.jumin_num,3,4)
							, 'YYYYMMDD'
					)
					,'YYYY-MM-DD (dy)' , 'NLS_DATE_LANGUAGE = Korean'
			)
	end                                      "생일"
	,d1.dep_name                             "소속부서명"
	,e2.emp_name                             "직속상관명"
	,d2.dep_name                             "직속상관부서명"
from
	employee e1, dept d1, employee e2, dept d2
where
	e1.dep_no = d1.dep_no(+)
	and e1.mgr_emp_no = e2.emp_no(+)
	and e2.dep_no = d2.dep_no(+)
order by
	decode( e1.jikup,'사장', 1,'부장', 2,'과장', 3,'대리', 4,'주임', 5, 6)||decode(substr(e1.jumin_num,7,1),'1','19','2','19','20') ||substr(e1.jumin_num,1,6);







--<139>


--<140>



