/*

-------------------------------------
-- king 계정 만들기
-------------------------------------
create user king  identified by k123;   -- 계정생성 명령
-------------------------------------
-- king 계정에 system 과 비슷한 권한 주기
-------------------------------------
grant connect,resource,dba to king;     -- 권한부여 명령
-------------------------------------
-- emp_sq 시퀀스 제거
-- cus_sq 시퀀스 제거
-- dept 테이블 제거
-- employee 테이블 제거
-- salary_grade 테이블 제거
-- customer 테이블 제거
-------------------------------------
drop sequence emp_sq;  -- ><주의>emp_sq 가 없으면 삭제 대상이 없다는 에러 메시지 출력
drop sequence cus_sq;
drop table salary_grade;
drop table customer;
drop table employee;
drop table dept;
*/




-------------------------------------
--dept 테이블 만들기
-------------------------------------
create table dept(
    dep_no       number(3)                               -- [부서 번호] 저장 컬럼 선언. 자료형은 숫자형
    ,dep_name    varchar2(20)    not null unique         -- [부서 명] 저장 컬럼 선언. 자료형은 문자형. 제약조건 비지마! 중복마!
    ,loc         varchar2(20)    not null                -- [부서위치] 저장 컬럼 선언. 자료형은 문자형. 제약조건은 비지마!
    , primary key(dep_no)                                -- dep_no 컬럼에 primary key 설정하기.
);
-- 4 행 입력하기
insert into dept(dep_no,dep_name,loc) values(10,'총무부','서울');
insert into dept(dep_no,dep_name,loc) values(20,'영업부','부산');
insert into dept(dep_no,dep_name,loc) values(30,'전산부','대전');
insert into dept(dep_no,dep_name,loc) values(40,'자재부','광주');

-------------------------------------------------
-- dept 테이블의 모든 컬럼과 모든 행을 검색하기
-------------------------------------------------
select * from dept;
-------------------------------------------------
-- select * from dept where dep_no=10;  -- 행을 골라내는 sql 구문.  where절.



-------------------------------------------------
-- employee 테이블에서 PK 값으로 사용할 일련번호를 생성하는 시퀀스 생성하기 (일련 번호 자동 생성기)
-------------------------------------------------
create sequence emp_sq
    start with 1
    increment by 1
    minvalue 1
    maxvalue 999;

-------------------------------------------------
-- employee 테이블 만들기. 직원 정보가 저장되는 테이블이다.
-------------------------------------------------
create table employee(
      emp_no        number(3)                                 -- [직원번호]가 저장되는 컬럼 선언.
      ,emp_name		varchar2(20)	not null                  -- [직원명]이 저장되는 컬럼 선언.
      ,dep_no       number(3)                                 -- [소속부서번호]가 저장되는 컬럼 선언.
      ,jikup        varchar2(20)    not null                  -- [직급]이 저장되는 컬럼 선언. 제약조건은 비지마!
      ,salary       number(9)       default 0                 -- [연봉]이 저장되는 컬럼 선언. 제약조건은 안주면 0줄게!
      ,hire_date    date            default  sysdate          -- [입사일]이 저장되는 컬럼 선언. 제약조건은 안주면 지금 시간을 넣어줄게!
      ,jumin_num    char(13)        not null unique           -- [주민번호]가 저장되는 컬럼 선언. 제약조건은 비지마! 중복마!
      ,phone	    varchar2(15)	not null                  -- [전화번호]가 저장되는 컬럼 선언. 제약조건은 비지마!
	  ,mgr_emp_no	number(3)                                 -- [직속상관직원번호]가 저장되는 컬럼 선언.

      , primary key(emp_no)                                   -- [직원번호] 컬럼에 PK 제약조건 주기
      , foreign key(dep_no)  references dept(dep_no)          -- [소속부서번호] 컬럼에 FK 제약조건 주기. dept 테이블에 dep_np 컬럼 참조하게 하기
      , constraint  employee_mgr_emp_no_fk foreign key(mgr_emp_no)  references employee(emp_no)
);                                                            -- [직속상관직원번호] 컬럼에 FK 제약조건 주기. employee 테이블에 emp_no 컬럼 참조하게 하기
                                                              -- employee_mgr_emp_no_fk 는 제약 조건에 붙이는 이름이다.


--------------------------------------------
-- employee_mgr_emp_no_fk 라는 이름의 FK 제약조건 끄기. 제약 조건 임시 무력화.(임시, 다시 켤 수 있음)
--------------------------------------------
alter table employee disable constraint employee_mgr_emp_no_fk;


--------------------------------------------
--지금 현재 로그인 한 계정이 날짜 데이터는 '년-월-일'  로 취급하게 하기
--------------------------------------------
alter session set nls_date_format = 'yyyy-mm-dd' ;

--------------------------------------------
--employee 테이블에 20개 행 입력하기.
--------------------------------------------
insert into employee values( emp_sq.nextval, '홍길동', 10, '사장', 5000, '1980-01-01', '7211271109410', '01099699515', null );
insert into employee values( emp_sq.nextval, '한국남', 20, '부장', 3000, '1988-11-01', '6002061841224', '01024948424', 1 );
insert into employee values( emp_sq.nextval, '이순신', 20, '과장', 3500, '1989-03-01', '6209172010520', '01026352672', 2 );
insert into employee values( emp_sq.nextval, '이미라', 30, '대리', 2503, '1983-04-01', '8409282070226', '01094215694', 17 );
insert into employee values( emp_sq.nextval, '이순라', 20, '사원', 1200, '1990-05-01', '8401041483626', '01028585900', 3 );
insert into employee values( emp_sq.nextval, '공부만', 30, '과장', 4003, '1995-05-01', '8402121563616', '01191338328', 17 );
insert into employee values( emp_sq.nextval, '놀기만', 20, '과장', 2300, '1996-06-01', '8011221713914', '01029463523', 2 );
insert into employee values( emp_sq.nextval, '채송화', 30, '대리', 1703, '1992-06-01', '8105271014112', '01047111052', 17 );
insert into employee values( emp_sq.nextval, '무궁화', 10, '사원', 1100, '1984-08-01', '8303291319116', '01025672300', 12 );
insert into employee values( emp_sq.nextval, '공부해', 30, '사원', 1303, '1988-11-01', '8410031281312', '01027073174', 4 );
insert into employee values( emp_sq.nextval, '류별나', 20, '과장', 1600, '1989-12-01', '8409181463545', '01071628290', 2 );
insert into employee values( emp_sq.nextval, '류명한', 10, '대리', 1800, '1990-10-01', '8207211661117', '01042072622', 20 );
insert into employee values( emp_sq.nextval, '무궁화', 10, '부장', 3000, '1996-11-01', '8603231183011', '01098110955', 1 );
insert into employee values( emp_sq.nextval, '채시라', 20, '사원', 3400, '1993-10-01', '8001172065410', '01044452437', 3 );
insert into employee values( emp_sq.nextval, '최진실', 10, '사원', 2000, '1991-04-01', '8303101932611', '01027491145', 12 );
insert into employee values( emp_sq.nextval, '김유신', 30, '사원', 4000, '1981-04-01', '7912031009014', '01098218448', 4 );
insert into employee values( emp_sq.nextval, '이성계', 30, '부장', 2803, '1984-05-01', '8102261713921', '0165358075', 1 );
insert into employee values( emp_sq.nextval, '강감찬', 30, '사원', 1003, '1986-07-01', '8203121977315', '01033583130', 4 );
insert into employee values( emp_sq.nextval, '임꺽정', 20, '사원', 2200, '1988-04-01', '8701301040111', '01086253078', 7 );
insert into employee values( emp_sq.nextval, '깨똥이', 10, '과장', 4500, '1990-05-01', '8811232452719', '01090084876', 13 );

select * from employee;

--------------------------------------------
-- employee_mgr_emp_no_fk 라는 이름의 FK 제약조건 켜기. 즉 제약 조건 임시 활성화.
--------------------------------------------
alter table employee enable constraint employee_mgr_emp_no_fk;



-------------------------------------------------
-- customer 테이블에서 PK 값으로 사용할 일련번호를 생성하는 시퀀스 생성하기 (일련 번호 자동 생성기)
-------------------------------------------------
create sequence cus_sq
    start with 1
    increment by 1
    minvalue 1
    maxvalue 999;


----------------------------------------------
--●customer 테이블 생성하기. 고객 정보가 저장되는 테이블이다.
----------------------------------------------
create table customer (
    cus_no        number(3)                           -- [고객번호] 저장 컬럼 선언
    ,cus_name     varchar2(20)    not null            -- [고객명]이 저장되는 컬럼 선언.  제약조건은 비지마!
    ,tel_num      varchar2(15)
    ,jumin_num    char(13)        not null unique     -- [주민번호] 저장 컬럼 선언   제약조건은 비지마! 중복마!
    ,emp_no       number(3)                           -- [담당직원번호] 저장 컬럼 선언


    , primary key(cus_no)                             -- [고객번호] 컬럼에 PK제약조건 주기
    , foreign key(emp_no) references employee(emp_no) -- [담당직원번호] 컬럼에 FK 제약조건 주기. dept 테이블에 dep_no 컬럼 참조하게 하기.
);


--------------------------------------------
--customer 테이블에 10개 행 입력하기.
--------------------------------------------
insert into customer values( cus_sq.nextval, '류민이', '123-1234', '7001131537915', 3);insert into customer values( cus_sq.nextval, '이강민', '343-1454', '6902161627914', 2);insert into customer values( cus_sq.nextval, '이영희', '144-1655', '7503202636215', null);insert into customer values( cus_sq.nextval, '김철이', '673-1674', '7704301234567', 4);insert into customer values( cus_sq.nextval, '박류완', '123-1674', '7205211123675', 3);insert into customer values( cus_sq.nextval, '서캔디', '673-1764', '6507252534566', null);insert into customer values( cus_sq.nextval, '신똘이', '176-7677', '0006083648614', 7);insert into customer values( cus_sq.nextval, '도쇠돌', '673-6774', '0008041346574', 9);insert into customer values( cus_sq.nextval, '권홍이', '767-1234', '7312251234689', 13);insert into customer values( cus_sq.nextval, '김안나', '767-1677', '7510152432168', 4);


select * from customer;


----------------------------------------------
--salary_grade 테이블 생성하기. 연봉 등급을 관리하는 테이블이다.
----------------------------------------------
create table salary_grade (
    sal_grade_no    number(2)   primary key    --[연봉등급] 저장 컬럼 선언
    ,min_salary     number(5)   not null       --[최소연봉] 저장 컬럼 선언
    ,max_salary     number(5)   not null       --[최대연봉] 저장 컬럼 선언
);

insert into salary_grade values( 1, 8000, 10000);
insert into salary_grade values( 2, 6000, 7999);
insert into salary_grade values( 3, 4000, 5999);
insert into salary_grade values( 4, 2000, 3999);
insert into salary_grade values( 5, 1000, 1999);

select * from salary_grade;

--------------------------------------------
-- 지금까지의 모든 입력, 수정, 삭제 작업을 실제 작업으로 인정하기
--------------------------------------------
commit;






select
		emp_no             as "직원번호"
		, emp_name||' 님'  as "직원명"
		, jikup            as "직급"
		, salary||'만원'   as "연봉"
		, hire_date        as "입사일"
	from
		employee;


select
	emp_name               as "직원명"
	, jikup                as "직급"
	, salary*0.12||'만원'   as "세금"
	, salary*0.88||'만원'   as "실수령액"
from
	employee;


select distinct jikup from employee;

select unique jikup from employee;

select distinct jikup from employee order by 1;

select distinct dep_no , jikup from employee;

select distinct dep_no , jikup from employee order by 1;


select unique dep_no, jikup from employee;


select * from employee where salary>=3000;

select * from employee order by salary asc;

select * from employee order by salary desc;

select * from employee order by dep_no asc, salary desc;

select * from employee order by decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4);

select * from employee where dep_no=20 and jikup='과장';

select * from employee where dep_no=20 or jikup='과장';

select * from employee where salary*0.88>=4000;

select * from employee where dep_no=20 and salary>=2000 and salary<=3000;

select * from employee where dep_no=20 and salary between 2000 and 3000;

select * from employee where mgr_emp_no is null;


select

		min( salary )

	from
		employee;



select

		min( salary )    as "최소연봉"
		,max( salary )   as "최대연봉"
		,avg( salary )   as "평균연봉"
		,sum( salary )   as "연봉총합"
		,count( salary ) as "총인원수"
	from
		employee;


select count(emp_no) from customer;

select count(distinct emp_no) from customer;

select count(mgr_emp_no) from employee;

select
		emp_no                          "직원번호"
		,emp_name                       "직원명"
		,substr(jumin_num,3,2)||'-'||substr(jumin_num,5,2)   "생일월일"  -- 세번째에서 두개 출력
	from
		employee;



select
  cus_no
  ,cus_name
  ,call_num
  ,substr(jumin_num,1,6)||'-'||substr(jumin_num,7,1)||'******'
  ,emp_no
from
  customer;



select
  cus_no
  ,cus_name
  ,nvl(emp_no||'','없음')
from
  customer;



select
  cus_no
  ,cus_name
  ,nvl2(emp_no,'있음', '없음')
from
  customer;



select
  emp_no
  ,emp_name
  ,jikup
  ,case
    substr(jumin_num,7,1)
    when '1' then '남'
    when '3' then '남'
    when '2' then '여'
    when '4' then '여'
  end          as "성별"
from
  employee;

select
		emp_no
		,emp_name
		,jikup
		,case
			when substr(jumin_num,7,1)='1' then '남'
			when substr(jumin_num,7,1)='3' then '남'
			else '여'
		end
	from
		employee;



select
	emp_no
	,emp_name
	,jikup
	,case
		when substr(jumin_num,7,1)='1' then '19'
		when substr(jumin_num,7,1)='2' then '19'
		else '20'
	end ||substr(jumin_num,1,2) "출생년도"
from
	employee;




select
		emp_no
		,emp_name
		,jikup
		,decode(substr(jumin_num,7,1)
		,'1','19'
		,'2','19'
		,'20'
		) ||substr(jumin_num,1,2) "출생년도"
	from
		employee;





	select
		emp_no
		,emp_name
		,jikup
		,case
			when substr(jumin_num,7,1)='1' then '19'
			when substr(jumin_num,7,1)='2' then '19'
			else '20'
		end ||substr(jumin_num,1,1)||'0' "출생년대"
	from
		employee;



	select
	 *

	from
		employee
	order by
		case
			when substr(jumin_num,7,1)='1' then '19'
			when substr(jumin_num,7,1)='2' then '19'
			else '20'
		end || substr(jumin_num,1,6)

		asc; --asc는 생략 가능하다.



select * from employee
	order by
		case jikup
			when '사장' then '1'
			when '부장' then '2'
			when '과장' then '3'
			when '대리' then '4'
			when '주임' then '5' else '6'
		end
		asc;



select emp_no, emp_name, hire_date from employee;



select
		emp_no
		, emp_name
		, to_char(hire_date,'YYYY.MM-DD')
	from
		employee;


select
		emp_no
		, emp_name
		, to_number(to_char(sysdate,'YYYY'))
		 - to_number(
		 case
 			substr(jumin_num,7,1) when '1' then '19'
 			when '2' then '19' else '20' end ||substr(jumin_num,1,2)
		 ) + 1     ||'살'    as "나이"
	from
		employee;


select
		emp_no "직원번호"
		,emp_name "직원명"
		, sysdate - hire_date
	from
		employee;



	select
		emp_no                                      "직원번호"
		,emp_name                                   "직원명"
		, ceil((sysdate - hire_date)/365)||'년차'    "근무년차"
	from
		employee;





select
		emp_no "직원번호"
		,emp_name "직원명"
		, floor((to_number(to_char(sysdate,'YYYY'))
		 - to_number(
		  case
 			substr(jumin_num,7,1) when '1' then '19'
 			when '2' then '19' else '20'
			end ||substr(jumin_num,1,2)
		 ) + 1) * 0.1)  ||'0대'    "연령대"
	from
		employee;





	select
		emp_no "직원번호"
		, emp_name "직원명"
		, to_date(
			case
				substr(jumin_num,7,1) when '1' then '19'
				when '2' then '19' else '20'
			end||substr(jumin_num,1,6), 'YYYYMMDD' )+100  "100일잔치날짜"
from
	employee;




	select
		emp_no "직원번호"
		, emp_name "직원명"
		, to_char(
				to_date(
				case
					substr(jumin_num,7,1) when '1' then '19'
					when '2' then '19' else '20'
				end||substr(jumin_num,1,6), 'YYYYMMDD' )+100
				, 'YYYY-MM-DD'
				)  "100일잔치날짜"
	from
		employee;



	select
		to_date('20211110', 'YYYYMMDD')
		-
		to_date('20210512', 'YYYYMMDD')       as  "학원생활"
	from
		dual;



select
  emp_no                                 "직원번호"
  , emp_name                             "직원명"
  , to_number(to_char(sysdate,'YYYY'))
   - to_number(
    case
    substr(jumin_num,7,1) when '1' then '19'
    when '2' then '19' else '20' end ||substr(jumin_num,1,2)
  ) + 1  ||'세'                          "현재나이"
  , to_number(to_char(hire_date,'YYYY'))
   - to_number(
    case
    substr(jumin_num,7,1) when '1' then '19'
    when '2' then '19' else '20' end ||substr(jumin_num,1,2)
  ) + 1  ||'세'                                  "입사일당시나이"
from
  employee;



select
		emp_no                     "직원번호"
		,emp_name                  "직원명"
		,to_number(to_char(sysdate, 'YYYY'))
			- to_number(
				case substr(jumin_num,7,1) when '1' then '19' when '2' then '19' else '20' end
				||substr(jumin_num,1,2)
			) + 1 ||'세'               "현재나이"
		,to_number(to_char(hire_date, 'YYYY'))
			- to_number(
				case substr(jumin_num,7,1) when '1' then '19' when '2' then '19' else '20' end
				||substr(jumin_num,1,2)
			) + 1 ||'세'               "입사일당시나이"
	from
		employee;

-------56번 과제 시작

select
  emp_no                                                 "직원번호"
  , emp_name                                             "직원명"
  , jumin_num                                            "주민번호"
  , to_char(
         to_date(
                 case when
                 to_number(to_char(sysdate, 'MMDD'))
                 - to_number(substr(jumin_num,3,4)
                 ) >=0 then '2022'||substr(jumin_num,3,4)  else '2021'||substr(jumin_num,3,4) end
                , 'YYYYMMDD'
                )
           ,'YYYY-MM-DD'
           )                                                     "다가올생일날"
  , to_char(
    (
    to_number(to_char(sysdate, 'MMDD'))
    - to_number(substr(jumin_num,3,4))
    )
           )
                                                    "생일까지남은일수"   -- 날짜계산을 하여야 하는데.. number 계산은 아닌것 같다..

from
  employee;


select

    to_date(to_char(sysdate, 'YYYYMMDD'),'YYYYMMDD')
    -
    to_date(case substr(jumin_num,7,1) when '1' then '19' when '2' then '19' else '20' end
				||substr(jumin_num,1,6), 'YYYYMMDD')      -- 현재 2021년인데 1972 이런식으로 계산하니까 숫자가 엄청크게 나옴...
from
employee;


TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD')) - TO_DATE('19930315'), -- 두 날짜 사이 일수 계산


 select
    to_number(to_char(sysdate, 'MMDD'))
    - to_number(substr(jumin_num,3,4))    -- 단순 숫자계산.. 날짜계산이 안나옴.

 from
 employee;


 select
    to_date(to_char(sysdate, 'MMDD'))
    - to_date((substr(jumin_num,3,4)),'MMDD')      -- 오류...

 from
 employee;





select

to_date(to_char(sysdate, 'YYYYMMDD'),'YYYYMMDD')
-
to_date(
                 case when
                 to_number(to_char(sysdate, 'MMDD'))
                 - to_number(substr(jumin_num,3,4)
                 ) >=0 then '2022'||substr(jumin_num,3,4)  else '2021'||substr(jumin_num,3,4) end
                , 'YYYYMMDD'
                )     "생일까지남은일수"               -- 다가올 생일에서 현재날짜를 빼주면?

from
employee;



 --------- 최종 테스트    (음수가 떠서 인터넷 찾고 ABS 해줌..음수값 날리고 절대값표시.)


select
  emp_no                                                 "직원번호"
  , emp_name                                             "직원명"
  , jumin_num                                            "주민번호"
  , to_char(
         to_date(
                 case when
                 to_number(to_char(sysdate, 'MMDD'))
                 - to_number(substr(jumin_num,3,4)
                 ) >=0 then '2022'||substr(jumin_num,3,4)  else '2021'||substr(jumin_num,3,4) end
                , 'YYYYMMDD'
                )
           ,'YYYY-MM-DD'
           )                                                     "다가올생일날"
  , ABS(

         to_date(to_char(sysdate, 'YYYYMMDD'),'YYYYMMDD')
         -
         to_date(
                 case when
                 to_number(to_char(sysdate, 'MMDD'))
                 - to_number(substr(jumin_num,3,4)
                 ) >=0 then '2022'||substr(jumin_num,3,4)  else '2021'||substr(jumin_num,3,4) end
                , 'YYYYMMDD'
                )-1
        )   "생일까지남은일수"

from
  employee;


--음수 제거 테스트   ABS() 쓰지 않고,


select
  emp_no                                                 "직원번호"
  , emp_name                                             "직원명"
  , jumin_num                                            "주민번호"
  , to_char(
         to_date(
                 case when
                 to_number(to_char(sysdate, 'MMDD'))
                 - to_number(substr(jumin_num,3,4)
                 ) >=0 then '2022'||substr(jumin_num,3,4)  else '2021'||substr(jumin_num,3,4) end
                , 'YYYYMMDD'
                )
           ,'YYYY-MM-DD'
           )                                                     "다가올생일날"
  ,



         to_date(
                 case when
                 to_number(to_char(sysdate, 'MMDD'))
                 - to_number(substr(jumin_num,3,4)
                 ) >=0 then '2022'||substr(jumin_num,3,4)  else '2021'||substr(jumin_num,3,4) end
                , 'YYYYMMDD'
                )
         -
         to_date(to_char(sysdate, 'YYYYMMDD'),'YYYYMMDD') + 1
           "생일까지남은일수"

from
  employee;













