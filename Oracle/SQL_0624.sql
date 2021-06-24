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

-------------------------------------------------------------
--답2
-------------------------------------------------------------
select
    d.dep_no as "부서번호"
    ,d.dep_name "부서명"
    ,(select count(*)||'명' from employee e where e.dep_no = d.dep_no) "부서직원수"
    ,(select count(*)||'명' from employee e, customer c where e.dep_no = d.dep_no and e.emp_no = c.emp_no) "담당 고객 수"
from
    dept d;


--<138>

select
    e1.emp_no                                "직원번호"
    ,e1.emp_name                             "직원명"
    ,ceil((sysdate - e1.hire_date)/365)||'년차' "근무년차"
    ,60
    - (extract(year from sysdate)
    - to_number(decode(substr(e1.jumin_num,7,1),'1','19','2','19','20')||substr(e1.jumin_num,1,2)) +1)                                        "퇴직일까지 남은 년도"
    ,case when
            to_date(
                to_char(sysdate,'YYYY')||substr(e1.jumin_num,3,4)
                , 'YYYYMMDD'
            )
            -
            sysdate
            >=0
        then    --올해 생일을 년-월-일 로 리턴하는 식
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



-- 강사님 정답풀이.

select
  e1.emp_no "[직원번호]"
  , e1.emp_name "[직원명]"
  , ceil((sysdate-e1.hire_date)/365) "[근무년차]"
  , to_number(to_char(sysdate,'yyyy'))-to_number((case substr(e1.jumin_num,7,1)
    when '1' then '19' when '2' then '19'else '20'end)||substr(e1.jumin_num,1,2))+1 "[나이]"
  , 60-(to_number(to_char(sysdate,'yyyy'))-to_number((case substr(e1.jumin_num,7,1)
    when '1' then '19' when '2' then '19'else '20'end)||substr(e1.jumin_num,1,2))+1) "[퇴직년도까지]"
  , to_char(to_date(case substr(e1.jumin_num,7,1)
    when '1' then '19' when '2' then '19' else '20' end
      ||substr(e1.jumin_num,1,6),'yyyymmdd'),'yyyy-mm-dd')||' '
      ||to_char(to_date(case substr(e1.jumin_num,7,1)
        when '1' then '19' when '2' then '19' else '20' end
      ||substr(e1.jumin_num,1,6),'yyyymmdd'),'dy','nls_date_language = korean') "생일"
  ,e1.jikup        "[직급]"
  ,d1.dep_name  "[소속부서명]"
  ,e2.emp_name  "[직속상관명]"
  ,d2.dep_name   "[직속상관소속부서명]"
from
  employee e1, dept d1, employee e2, dept d2

where
  e1.dep_no = d1.dep_no(+)
  and e1.mgr_emp_no = e2.emp_no(+)
  and e2.dep_no = d2.dep_no(+)
order by
  decode( e1.jikup,'사장', 1,'부장', 2,'과장', 3,'대리', 4, 5) asc
  ,
  case substr(e1.jumin_num,7,1) when '1' then '19' when '2' then '19' else '20' end ||substr(e1.jumin_num,1,6) asc










