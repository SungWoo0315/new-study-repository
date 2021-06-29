-- book 계정 만들기
-------------------------------------
--create user book identified by 123;   -- 계정생성 명령
-------------------------------------
-- book 계정에 system 과 비슷한 권한 주기
-------------------------------------
--grant connect,resource,dba to book;     -- 권한부여 명령


--모든 계정 조회.
select * from all_users;

-- 테이블 컬럼명 변경.
alter table customer rename column call_num to tel_num
alter table employee rename column call_num to phone_num
alter table employee rename column phone to phone_num
-- alter view employee_vw1 rename column phone to phone_num -- view는 이렇게 변경이 안된다. 아래처럼 해주어야 한다.
alter table 변경대상테이블명 rename column 현재컬럼명 to 바꿀컬럼명
commit;

-- view 변경사항은 이렇게 해주어야 한다.
CREATE OR REPLACE VIEW KING.EMPLOYEE_VW1
(EMP_NO, EMP_NAME, DEP_NO, JIKUP, HIRE_DATE, JUMIN_NUM, PHONE_NUM, MGR_EMP_NO)
AS
select
		emp_no, emp_name, dep_no, jikup, hire_date, jumin_num, phone_num, mgr_emp_no
	from
		employee;



select * from employee;

DESC employee;


DESC dual;


SELECT *
FROM
	dual;


SELECT
	SYSDATE
FROM
	dual;


SELECT
--날짜 포맷
--TO_CHAR(SYSDATE,'YYYYMMDD')			--20191130
--,TO_CHAR(SYSDATE,'YYYY-MM-DD')	--2019-11-30
--,TO_CHAR(SYSDATE,'YYYY/MM/DD')	--2019/11/30
--,TO_CHAR(SYSDATE,'YYYY')				--2019
--,TO_CHAR(SYSDATE,'YY')					--19
--,TO_CHAR(SYSDATE,'MM')					--11
--TO_CHAR(SYSDATE,'MON')					--11월
--,TO_CHAR(SYSDATE,'D')						--7 (주중의 일을 1~7로 표시(일요일 = 1)
--,TO_CHAR(SYSDATE,'DD')					--30
--,TO_CHAR(SYSDATE,'DDD')					--334 (1년기준 일 수)
--,TO_CHAR(SYSDATE,'DAY')					--토요일 (요일 표시)
--,TO_CHAR(SYSDATE,'DY')					--토 (요일을 한자리로 표시)
--,TO_CHAR(SYSDATE,'WW')					-- 48 (일년 기준 주를 00 ~ 53 형태로 표시)
--,TO_CHAR(SYSDATE,'W')						-- 5 (한달 기준 몇번째 주)
--TO_CHAR(SYSDATE,'DL')					--2019년 11월 30일 토요일

--시간 포맷
--,TO_CHAR(SYSDATE,'AM')			--오전
--,TO_CHAR(SYSDATE,'PM')			--오후
--,TO_CHAR(SYSDATE,'HH')			--10 (시간을 0 ~ 12 형태로 표시)
--,TO_CHAR(SYSDATE,'HH24')		--20 (시간을 0 ~ 24 형태로 표시)
--,TO_CHAR(SYSDATE,'MI')			--03 (분을 00 ~ 59 형태로 표시)
--,TO_CHAR(SYSDATE,'SS') 		--10 (초을 01 ~ 59 형태로 표시)

--분기
--TO_CHAR(SYSDATE,'Q')       -- 분기.

----세기 포맷
--,TO_CHAR(SYSDATE,'CC')			--21 (세기)
--,TO_CHAR(SYSDATE,'BC')			--서기

--테스트
to_char(sysdate, 'YYYY-MM-DD(DY) YY"년" MON HH24:MI : SS <Q"분기">')
,to_char(sysdate, 'CC"세기" DL')
FROM
	dual;


select
max(hire_date) "최근입사일"
,min(hire_date) "오래전입사"
FROM
employee;


select
	count(*)
FROM
	employee;


select
	count(*)  -- null 을 포함한 모든 행 개수 구함.
FROM
	customer
where
	emp_no is null;  -- null을 골라내면 2가 나옴.



select
	count(emp_no)  -- null 을 제외한 모든 행 개수 구함.
FROM
	customer
where
	emp_no is null;  -- null을 제외 하여서. 0개가 나올수 밖에 없음.


select
	count(mgr_emp_no)
from
	employee;


select
 count(distinct mgr_emp_no)  -- 중복제거
FROM
	employee;


select * from employee where salary >= (select avg(salary) from employee)  --서브쿼리


-- 나이
--   to_number(to_char(sysdate, 'YYYY'))
--   -
--   to_number((decode(substr(e1.jumin_num,7,1), '1', '19', '2', '19', '20'))
--   ||substr(e1.jumin_num,1,2))+1


-- 나이구하기.
select
	cus_name
	,to_number(to_char(sysdate, 'YYYY'))
	-
	to_number((decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20'))||substr(jumin_num,1,2))+1
from
	customer
order by 2 desc;



--<127> -- group by -- group by 안에는 select에서 묶어준 일반컬럼이 다 들어가야 한다.
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


select
    dep_no                "부서번호"
    ,jikup                "직급"
    ,sum(salary)          "급여합"
    ,round(avg(salary),1) "평균급여"
    ,count(*)||'명'       "인원수"
from
    employee
where
	 jikup not like '%사원%'
group by
    dep_no, jikup
having
    count(*) >= 3;


-- 카디시안 곱 (Cartesian Product)
select
*
from
	dept
	,employee