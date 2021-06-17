select
        emp_no
        , emp_name
        , to_char(sysdate,'YYYY-MM-DD //(DY) Q AM HH:MI:SS', 'NLS_DATE_LANGUAGE = Korean')
    from
        employee;




select
        emp_no
        , emp_name
        , to_char(sysdate,'YYYY-MM-DD //(DY) PM HH:MI:SS', 'NLS_DATE_LANGUAGE = Korean')
    from
        employee;




select
        emp_no
        , emp_name
        , to_char(sysdate,'YYYY-MM-DD //(DAY) HH24:MI:SS', 'NLS_DATE_LANGUAGE = Korean')
    from
        employee;




select
	emp_no
	, emp_name
	, to_char(hire_date,'YYYY"년-"MM"월-"DD"일" (DY) Q"분기" HH"시"MI"분"SS"초"' , 'NLS_DATE_LANGUAGE = Korean')
from
	employee;



select
	emp_no
	, emp_name
    ,to_char(
	 to_char(hire_date,'YYYY')||'년'
    , to_char(hire_date,'MM')||'월'
    , to_char(hire_date,'DD')||'일'
    , to_char(hire_date,'(DY)','NLS_DATE_LANGUAGE = Korean')
    )
from
	employee;



select
		emp_no
		,emp_name
		,to_char(hire_date, 'YYYY')||'년'
		|| to_char(hire_date, 'MM')||'월'
		|| to_char(hire_date, 'DD')||'일'
		|| to_char(hire_date, '(DY)' , 'NLS_DATE_LANGUAGE = Korean')
		|| to_char(hire_date, 'AM HH')||'시'
		|| to_char(hire_date, 'MI')||'분'
		|| to_char(hire_date, 'SS')||'초'
	from
		employee;




select
		emp_no "직원번호"
		, emp_name "직원명"
		, to_char(
				to_date(
					case substr(jumin_num,7,1) when '1' then '19'
					when '2' then '19' else '20' end||substr(jumin_num,1,6)
					, 'YYYYMMDD'
				) + 100
				, 'YYYY-MM-DD(DY)'
                , 'NLS_DATE_LANGUAGE = Korean'
			)                           "100일잔치날짜"
	from
		employee;



	select
	  emp_no                                                 "직원번호"
	  , emp_name                                             "직원명"
	  , jumin_num                                            "주민번호"

		,case when
				to_date(
	    		to_char(sysdate,'YYYY')||substr(jumin_num,3,4)
					, 'YYYYMMDD'
	  		)
				-
				sysdate
				>=0
			then	--올해 생일을 년-월-일 로 리턴하는 식
				to_char(
						to_date(
								to_char(sysdate,'YYYY')||substr(jumin_num,3,4)
								, 'YYYYMMDD'
						)
						,'YYYY-MM-DD'
				)
			else  --내년 생일을 년-월-일 로 리턴하는 식
				to_char(
						to_date(
								to_number(to_char(sysdate,'YYYY'))+1||substr(jumin_num,3,4)
								, 'YYYYMMDD'
						)
						,'YYYY-MM-DD (dy)'
				)
		end    "다가올생일날"
		,ceil(

		case when
				to_date(
					to_number(to_char(sysdate,'YYYY'))||substr(jumin_num,3,4)
					, 'YYYYMMDD'
				)
				-
				sysdate
				>=0
		then
				to_date(
				to_number(to_char(sysdate,'YYYY'))||substr(jumin_num,3,4)
				, 'YYYYMMDD'
				)
				-
				sysdate
		else
				to_date(
					to_number(to_char(sysdate,'YYYY'))+1||substr(jumin_num,3,4)
					, 'YYYYMMDD'
				)
				-
				sysdate
		end
		)
		 "생일까지남은일수"
	from
	  employee
	order by 5 asc;



select
		  emp_no                            "직원번호"
		  , emp_name                        "직원명"
		  , jikup                           "직급"
			, to_char(salary, '999,999,999') ||'만원' "연봉"
	from
		employee;






select * from employee
where

to_char(to_date(
								to_number(to_char(sysdate,'YYYY'))||substr(jumin_num,3,4)
								, 'YYYYMMDD'
						)
						,'YYYY-MM-DD(dy)' , 'NLS_DATE_LANGUAGE = Korean') = '수';






select * from employee
where
substr(jumin_num,1,1) = '7' and substr(jumin_num,7,1) = '1' ;



select * from employee
where
to_char(to_date(
			case substr(jumin_num,7,1) when '1' then '19'
			when '2' then '19' else '20' end||substr(jumin_num,1,6)
			, 'day') ) = '수요일';



select * from employee
where
to_char(
		to_date(
			case substr(jumin_num,7,1) when '1' then '19'
			when '2' then '19' else '20' end||substr(jumin_num,1,6)
			, 'YYYYMMDD'
		)
		, 'DAY'
		, 'NLS_DATE_LANGUAGE = Korean'
	) = '수요일';




select  *  from employee
where
   to_char(
      to_date(
        case substr(jumin_num,7,1) when '1' then '19'
        when '2' then '19' else '20' end||substr(jumin_num,1,6)
        , 'YYYYMMDD'
      )
      , '(DY)'
      , 'NLS_DATE_LANGUAGE = Korean'
    )     = '(수)' ;


--<60>번

select chr(19) from dual;

select upper('abcd') from dual;

select lower('ABCD') from dual;

select length('asdfasdfasdf') from dual;

select substr( 'You are not alone', 9, 3 ) from dual;
select substr( 'You are not alone', 0, 5 ) from dual;
select substr( 'You are not alone', 5 ) from dual;
select substr( 'You are not alone', -5, 2 ) from dual;
select substr( 'You are not alone', 5, 0 ) from dual;

select
to_char('          I am your father... no~ ! ! !                ')
,trim('        I am your father... no~ ! ! !         ')    "trim공백제거"
,to_char('          I am your father... no~ ! ! !                ')
,ltrim(to_char('I am your father... no~ ! ! !'), 'I am your')
,rtrim(to_char('I am your father... no~ ! ! !'), 'no~ ! ! !')

from dual;

----