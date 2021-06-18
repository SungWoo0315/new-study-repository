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
		,sysdate-hire_date                             "근무일수"
		,months_between(sysdate,hire_date)             "근무개월수"
		,to_char(add_months(hire_date,5), 'YYYY-MM-DD')  "입사후5개월후날짜"
		,to_char(last_day(hire_date), 'YYYY-MM-DD')  "입사한달의마지막날짜"
		,to_char(next_day(hire_date,1), 'YYYY-MM-DD') "입사일오는일요일날짜"

 from
 	employee;







