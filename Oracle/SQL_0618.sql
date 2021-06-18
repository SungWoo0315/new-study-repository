-- 20210618


-- <57>
select * from employee
where
to_char(
        to_date(
            case substr(jumin_num,7,1) when '1' then '19'
            when '2' then '19' else '20' end||substr(jumin_num,1,6)
            , 'YYYYMMDD'
        )
        , 'DY'
        , 'NLS_DATE_LANGUAGE = Korean'
	) = '수';



select * from employee
where
to_char(
	to_date(
      decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,6), 'YYYYMMDD'
		)
		,'D'
)
= '4';


----

--<58>

select * from employee
	where
		substr(jumin_num,1,1) = '7'
		and
		substr(jumin_num,7,1) = '1' ;


--<59>
select * from employee
where
	(substr(jumin_num,1,1) = '6'
	or
	substr(jumin_num,1,1) = '7'
	)
	and
	(substr(jumin_num,7,1) = '1'
	or
	substr(jumin_num,7,1) = '3'
	);


--<60>

	select * from employee
	order by

	to_number(sysdate-hire_date)

	desc;


	select * from employee
	order by
		(sysdate-hire_date)
	desc;

-- 두가지 방법


--<61>

select
		emp_no                              "직원번호"
		,emp_name                           "직원명"
		,sysdate-hire_date                  "근무일수"
		,months_between(sysdate,hire_date)  "근무개월수"
 from
 	employee;



select
		emp_no                                         "직원번호"
		,emp_name                                      "직원명"
		,round(sysdate-hire_date, 3)                   "근무일수"
		,trunc(months_between(sysdate,hire_date), 2)   "근무개월수"
		,to_char(add_months(hire_date,5), 'YYYY-MM-DD')  "입사후5개월후날짜"
		,to_char(last_day(hire_date), 'YYYY-MM-DD')  "입사한달의마지막날짜"
		,to_char(next_day(hire_date,1), 'YYYY-MM-DD') "입사일오는일요일날짜"

 from
 	employee;



----

--<62>
select * from employee
where
jikup = '과장';

--<63>
select * from employee where jikup != '과장';
select * from employee where jikup <> '과장';


--<64>
select * from employee where dep_no = 10 and jikup = '과장';

--<65>
select * from employee where jikup = '과장' or jikup = '부장';
select * from employee where jikup in('과장', '부장');
select * from employee where jikup = any('과장', '부장');

--<66>
select * from employee where (dep_no = 10 or dep_no = 20) and jikup = '과장';
select * from employee where dep_no in(10, 20) and jikup = '과장';

--<67>
select * from customer where emp_no is null;

--<68>
select * from customer where emp_no is not null;

--<69>
select * from customer where (emp_no != 9) or emp_no is null;

--<70>
select * from employee where salary >= 3000 and salary <= 4000;
select * from employee where salary between 3000 and 4000;

--<71>
select * from employee where salary >= 3000 and salary < 4000;
select * from employee where (salary between 3000 and 4000) and salary != 4000;

--<72>
select * from employee where salary*1.05 >= 3000

--<73>

select * from employee where hire_date >= to_date('1995-1-1','YYYY-MM-DD');

--<74>

select * from employee
where
	hire_date >= to_date('1990-1-1','YYYY-MM-DD')
	and
	hire_date < to_date('2000-1-1','YYYY-MM-DD');
-------------------------------------------------
select * from employee where
	to_number(to_char(hire_date, 'yyyy')) between 1990 and 1999;
-------------------------------------------------


--<75>
select * from employee where
dep_no in(10,30)
and salary < 3000
and hire_date < to_date('1996-01-01', 'YYYY-MM-DD');



--<76>
select * from employee where substr(emp_name, 1,1) = '김';
select * from employee where emp_name like '김%';


--<77>

select * from employee where
	substr(emp_name, 1,1) = '황'
	and
	substr(emp_name, 1,2) != '황보';


select * from employee where
	emp_name like '황%'
	and
	emp_name not like '황보%';

--<78>

select * from employee where length(emp_name) = 2;


--<79>

select * from employee where emp_name like '%남';

select * from employee where substr(emp_name, length(emp_name), 1) = '남';

select * from employee where substr(emp_name, -1, 1) = '남';


--<80>

select * from employee where substr(emp_name, 1, 1) = '김'
and length(emp_name) = 3;

select * from employee where emp_name like '김%'
and length(emp_name) = 3;

select * from employee where emp_name like '김__'
and length(emp_name) = 3;



--<81>
select * from employee where emp_name like '%김%';

--<82>
select * from employee where emp_name not like '김%';


--<83>

select * from employee where emp_name like '_%미%_';
-- 내가한것 맞는지 확인해보기. -- 틀림. 앞자리 김이 들어갈수도 있기 때문.


select * from employee where emp_name like '%미%'
and emp_name not like '미%'
and emp_name not like '%미';



 --<84>
-------------------------------------------------
select * from employee where
substr(jumin_num,7,1) = '2' or substr(jumin_num,7,1) ='4';
-------------------------------------------------
select * from employee where
substr(jumin_num, 7, 1) in('2','4');
-------------------------------------------------
select * from employee where
jumin_num like '______2%' or jumin_num like '______4%'
-------------------------------------------------
select * from employee where
jumin_num not like '______1%' and jumin_num not like '______3%'
-------------------------------------------------



--<85>

select * from employee where
(substr(jumin_num,1,1) = '6' or substr(jumin_num,1,1) = '7')
and substr(jumin_num,7,1) = '1';
---------------------------------------------------------
select * from employee where
substr(jumin_num,1,1) in ('6','7') and substr(jumin_num,7,1) = '1';
---------------------------------------------------------
select * from employee where
jumin_num like '6_____1%' or jumin_num like '7_____1%' ;





--<86>

select
	employee.emp_no
	,employee.emp_name
	,dept.dep_name
from
	employee , dept
where
	employee.dep_no=dept.dep_no  ;


select
	e.emp_no
	,e.emp_name
	,d.dep_name
from
	employee e, dept d
where
	e.dep_no=d.dep_no    ;



--<87>
select
	c.cus_no                 "고객번호"
	,c.cus_name              "고객명"
	,e.emp_name              "고객담당직원이름"
from
	customer c, employee e
where
	c.emp_no=e.emp_no



select
	c.cus_no                 "고객번호"
	,c.cus_name              "고객명"
	,e.emp_name              "고객담당직원이름"
from
	customer c, employee e
where
	c.emp_no=e.emp_no(+)





--<88>

select * from employee where salary >= (select avg(salary) from employee);





--<89>
select
	jikup
	,avg(salary)
from
employee
group by
	jikup;

