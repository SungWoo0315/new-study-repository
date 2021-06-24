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















