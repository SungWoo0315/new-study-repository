<2021-06-24>

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
--having            --인원수 5명 이상만 보고 싶을때 having을 써서 골라낸다. group by 에서 행을 골라내기 위해서 사용.
    --count(*)>=5
order by
    decode( jikup,'사장', 1,'부장', 2,'과장', 3,'대리', 4,'주임', 5, 6) asc;



--<137>

select
	d.dep_no                        "부서번호"
	,d.dep_name                     "부서명"
	,count(distinct(e.emp_no))      "직원수"      -- 중복된 직원수를 제거해야 한다.
	,count((c.emp_no))              "직원이관리하는고객수"
from
	employee e, dept d, customer c
where --컬럼을 붙이는 조건.
	d.dep_no = e.dep_no(+)
	and
	e.emp_no = c.emp_no(+)
group by
	d.dep_no, d.dep_name;














