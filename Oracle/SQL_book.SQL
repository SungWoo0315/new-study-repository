--<2021-06-28>
-- 오라클 책 따라서 공부해보기.

-- book 계정 만들기
-- create user book identified by 123;   -- 계정생성 명령

-- book 계정에 system 과 비슷한 권한 주기
-- grant connect,resource,dba to book;     -- 권한부여 명령

-- EMP_EXAMPLE.sql 스크립트로 테이블 생성 및 데이터 insert.

select * from employee;

select eno, ename from employee;

-- 34p

select ename, salary, salary*12 from employee; -- 산술연산자 사용.

select ename, salary, job, dno, commission, salary*12, salary*12+commission from employee; --산술 연산자 사용. 다른컬럼과 연계해서 계산 시 null 값 주의.
-- null 값이 더해지면. 계산이 되지 않아서 null 값으로 출력된다.
-- 0이라도 입력되어 있으면 올바르게 계산되어 출력된다.

-- 올바르게 출력하려면 nvl 사용.
select
	ename
	,salary
	,job
	,dno
	,nvl(commission, 0)
	,salary*12
	,salary*12+nvl(commission, 0)
from
	employee;

-- 36p
-- 3.6 컬럼에 별칭 지정
-- 공백추가, as추가, ""사용.

select ename, salary*12+nvl(commission,0) 연봉 from employee;

select ename, salary*12+nvl(commission,0) "연봉" from employee;

select ename, salary*12+nvl(commission,0) as 연봉 from employee;

select ename, salary*12+nvl(commission,0) as "연봉" from employee;




