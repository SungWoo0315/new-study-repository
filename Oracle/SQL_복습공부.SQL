--<Oracle 복습>
--<2021년 7월 4일>

--<DATE>
select to_date('20211225', 'YYYYMMDD')-to_date('20210808', 'YYYYMMDD') from dual;

select to_char(sysdate, 'YYYY-MM-DD-DAY') from dual;

--<9>

select to_char(to_date('20211225', 'YYYYMMDD') - to_date('20210704', 'YYYYMMDD'))||'일' as "12월25까지 남은 날" from dual;

select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS') from dual;



--<15> employee 테이블에서 모든 컬럼, 모든행의 데이터를 검색하면?

select * from employee;

select emp_no, emp_name, dep_no, jikup, salary, hire_date, jumin_num, phone_num, mgr_emp_no from employee;


--<16> employee 테이블에서 emp_no, emp_name, jikup, salary, hire_date 컬럼의 데이터를 검색하면?

select
	emp_no
	,emp_name
	,jikup
	,salary
	,hire_date
from
	employee;


--<17> employee 테이블에서 emp_no, emp_name, jikup, salary, hire_date 을 검색하면서
--	별칭(=alias)을 즉, 헤더를 사원번호, 직원명, 직급, 연봉, 입사일로 하고
--	연봉에 '만원' 이란 문자를 붙여 검색하면?

select
	emp_no		  						as "사원번호"
	,emp_name								"직원명"
	,jikup									"직급"
	,salary||' 만원'					연봉
	,hire_date							입사일
from
	employee;

-- 연결 연산자 `||` 주의 하기.


--<18> employee 테이블에서 직원명, 직급, 연봉, 세금, 실수령액을 검색하면? (세금은 연봉의 12%)


select
	emp_name											"직원명"
	,jikup												"직급"
	,salary||' 만원'							"연봉"
	,salary*0.12||'만원'    			"세금"
	,salary-(salary*0.12)||'만원' "실수령액"
	,salary*0.88									"실수령액 다른계산"
from
	employee;


--<19> employee 테이블에서 직급을 중복없이 검색하면?

select
	distinct jikup
from
employee;

select
	distinct(jikup)				"직급"
from
	employee;


select
	unique(jikup)				"직급"
from
	employee
order by
	decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4) asc;  -- 직급별 정렬 방법.


--<20> employee 테이블에서 부서번호와 직급을 중복 없이 검색하면?

select
	distinct dep_no, jikup
from
	employee
order by	-- 직급별 정렬 + 부서넘버 정렬.
	decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4) asc, dep_no asc;
-- order by dep_no asc; -- 정렬 테스트.

select
	unique dep_no, jikup
from
 employee;


--<21> employee 테이블에서 연봉이 3000 이상인 직원을 검색해서 검색하면?

select
	*
from
	employee
where
	salary >= 3000




-- 직급별 정렬 추가해서 해봄.
select
 salary	"연봉"
 ,jikup "직급"
from
	employee
where
	salary >= 3000
order by
	decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4) asc;


--<22> employee 테이블에서 연봉 오름차순으로 검색하면?

select
	*
from
	employee
order by salary asc;

-- 오름차순(asc)은 생략 가능하다.
select
	*
from
	employee
order by salary;

-- 컬럼 위치번호로도 작성 가능하다.  테이블 도식 참고,
select
	*
from
	employee
order by 5 asc;


--<23> employee 테이블에서 연봉 내림차순으로 검색하면?

select
	*
from
	employee
order by salary desc;


-- 컬럼명 대신에 컬럼명 위치번호 가능.
-- 대신, 내림차순(desc)는 생략 불가능하다.
select
	*
from
	employee
order by 5 desc;


--<24> employee 테이블에서 부서번호 오름차순을 유지하면서 연봉 내림차순으로 검색하면?
select
	*
from
	employee
order by
	dep_no asc, salary desc;


--<25> employee 테이블에서 직급이 높은 순서 나열해서 검색하면?

select
	*
from
	employee
order by
	decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5) asc, salary desc;


--<26> employee 테이블에서 부장만 검색하면?
select
 *
from
	employee
where
	jikup = '부장'


-- 26번 추가 연습.
select
	dep_no
	,emp_name
from
	employee
where
	dep_no = '10'

-- 오라클에서는 `==` 이 없다.  `=` 을 써주어야 한다.


--<27> employee 테이블에서 20번 부서의 과장을 검색하면?
select
	*
from
	employee
where
	dep_no = '20' and jikup = '과장'


--<28> employee 테이블에서 20번 부서 또는 과장을 검색하면?
select
	*
from
	employee
where
	dep_no = '20' or jikup = '과장'
-- order by dep_no asc, decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5) asc--, salary desc; --정렬 테스트.

--<29> employee 테이블에서 과장 중에 연봉 3400 이상을 검색하면?
select
	*
from
	employee
where
	jikup = '과장' and salary>=3400

--<30> employee 테이블에서 실수령 액이 4000만원이상 받는 직원을 검색하면? 단, 세금이 12% 라고 가정하자.
select
	*
from
	employee
where
	salary*0.88>=4000

--<31> employee 테이블에서 세금을 제일 많이 내는 직원 순서로 나열하면서 부서번호가 내림차순이면서
--	사장이 아닌 직원을 검색하면?
select
	emp_name
	,salary*0.12 "세금"
	,dep_no
	,jikup
from
	employee
where
	jikup!='사장'
order by
	 "세금" desc, dep_no desc

-- order by 에서 세금이 먼저 나오면 세금 기준으로 정렬을 먼저 하고, 부서번호를 세금 기준으로 잡는다.

-- 부서번호와 세금의 순서를 바꾸면, 부서번호를 먼저 정렬하고 그 기준으로 세금을 정렬한다.  순서 바꿔서 결과 실행 해보기.


--<32> employee 테이블에서 20번 부서 중에 연봉 2000~3000 사이 검색하면?
select
	*
from
	employee
where
	dep_no = '20'
	and
	salary between 2000 and 3000

--
select
	*
from
	employee
where
	dep_no = '20'
	and
	salary >= 2000 and salary <= 3000

-- betwwen '숫자' and '숫자


--<33> employee 테이블에서 직속 상관이 없는 직원을 검색하면?

select
	*
from
	employee
where
	mgr_emp_no is null



--<34> employee 테이블에서 직속 상관이 있는 직원을 검색하면?
select
	*
from
	employee
where
	mgr_emp_no is not null


--<36> employee 테이블에서 [최소 연봉]. [최대 연봉], [평균 연봉], [연봉총합], [총인원수]을 검색해서 출력하면?
select
	min(salary)				최소연봉
	,max(salary)			최대연봉
	,avg(salary)			평균연봉
	,sum(salary)			연봉총합
	,count(emp_no)		"총인원수(emp_no)"
	,count(*)					as "총인원수(행의개수)"
from
	employee


--<기억하기> min, max, avg, sum, count, 함수들은 null 값을 제외하고 계산한다.

-- count(emp_no) 는 null 값을 제외하고 개수를 리턴하지만,
-- count(*) 는 행의 개수를 리턴하므로 null 값도 포함해서 리턴.

--<참고>
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

--<37> 아래 SQL 구문은 무슨 문제의 답인가?

select count(emp_no)"담당직원이있는고객" from customer;

-- 담당 직원이 있는 고객의 명수는?
-- emp_no 컬럼안의 담당 직원의 직원번호이므로 직원번호의 개수는 결국  담당직원이 있는 고객의 명수가 된다.



--<38> 고객을 담당하고 있는 직원의 명수는?
select
	count(distinct emp_no) "고객담당직원수"
from
	customer

-- 담당직원이 중복될수도 있기 때문에 distinct 써주어야 한다.


--<39> 직속상관이 있는 직원의 명수는?
select
	count(mgr_emp_no)
from
	employee


--<39-1> 부하직원이 있는 직원의 명수는?
select
	count(distinct mgr_emp_no)
from
	employee


--<40> employee 테이블에서 [직원번호], [직원명], [생일월-생일일] 검색해서 출력하면?
select
	emp_no
	,emp_name
	,substr(jumin_num,3,2)||'월 - '||substr(jumin_num,5,2)||'일'
from
	employee

-- substr 사용 익히기.


--<41> customer 테이블에서 모든 컬럼, 모든 행을 검색해서 출력하면?
--	단, 주민번호는 901225-2****** 형태로 출력하세요.
select
	cus_no
	,cus_name
	,tel_num
	,substr(jumin_num,1,6)||'-'||substr(jumin_num,7,1)||'******'
	,emp_no
from
	customer

-- 오라클에서 연결 연산자는 `||` 이다.

--<42> customer 테이블에서 고객번호, 고객명, 담당직원번호 를 출력하면?
--	단, 담당직원번호가 없으면 null 출력하지 말고 '없음' 으로 표시 하삼!

select
	cus_no
	,cus_name
	,nvl(to_char(emp_no), '없음')
from
	customer


-- emp_no 가 숫자데이터 이므로 to_char 로 문자로 변경해서 '없음'을 대체해주어야 한다.
-- nvl( 컬럼명, null값일때 대체데이터)


--<43> customer 테이블에서 고객번호, 고객명, 담당직원존재여부 를 출력하면?
--	단, 직원번호가 있으면 '있음', 없으면 '없음'으로 표시

select
	cus_no
	,cus_name
	,nvl2(emp_no, '있음', '없음')
from
	customer

-- nvl2( 컬럼명, null값아닐때대체데이터, null값일때대체데이터 )


--<44> employee 테이블에서 직원번호, 직원명, 직급, 성별 를 출력하면?
--방법1
select
	emp_no
	,emp_name
	,jikup
	,decode(substr(jumin_num,7,1), '1', '남', '3', '남', '여') as "성별"
from
	employee

--<<<decode 단점>>>
--		=> 같다라는 경우에만 사용된다.
--		=> 오라클에서만 사용되는 오라클 전용함수이다. case ~ end 구문은 모든 DB에서 사용가능하다.


--방법2
select
	emp_no
	,emp_name
	,jikup
	,case substr(jumin_num,7,1) when '1' then '남' when '3' then '남' else '여' end "성별"
from
	employee

--방법3
select
	emp_no
	,emp_name
	,jikup
	,case when substr(jumin_num,7,1) = '1' then '남'
				when substr(jumin_num,7,1) = '3' then '남'
				else '여' end 성별
from
	employee

-- 방법3 에서 `=` 대신에 필요에 따라 `>=, >, <, <=, !=` 등의 비교연산자도 사용할 수 있다.
--	필요에 따라 `else 리턴값n` 는 생략 될 수 있다.

-- end 로 닫아주는거 까먹지 말기.


--<45> employee 테이블에서 직원번호, 직원명, 직급, 출생년도(4자리) 를 출력하면?

select
	emp_no
	,emp_name
	,jikup
	,decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,2)||' 년생' "출생년도(4자리)"
from
	employee



select
	emp_no
	,emp_name
	,jikup
	,case
		when substr(jumin_num,7,1)='1' then '19'
		when substr(jumin_num,7,1)='2' then '19'
		else '20'
	end||substr(jumin_num,1,2)||'년생' "출생년도"
from
	employee




--<46> employee 테이블에서 직원번호, 직원명, 직급, 출생년대(4자리) 를 출력하면?
select
	emp_no
	,emp_name
	,jikup
	,decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,1)||'0 년대생' "출생년대(4자리)"
from
	employee


select
	emp_no
	,emp_name
	,jikup
	,case
		when substr(jumin_num,7,1)='1' then '19'
		when substr(jumin_num,7,1)='2' then '19'
		else '20'
	end||substr(jumin_num,1,1)||'0 년대생' "출생년도"
from
	employee


--<47> employee 테이블에서 나이순으로 출력하면? 연장자가 먼저 나오도록.
select
	*
from
	employee
order by
	to_number(decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,6)) asc


--<48> employee 테이블에서 직급순서대로 정렬하여 모든 컬럼을 보이면?
select
	*
from
	employee
order by
	decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, 5) asc;


--<49> employee 테이블에서 직원번호, 직원명, 입사일(년-월-일(요일) 시분초) 검색하면?
select
	emp_no
	,emp_name
	,to_char(hire_date, 'YYYY-MM-DD(DAY) HH24:MI:SS') "입사일"
from
	employee;


select to_char(sysdate, 'YYYY-MM-DD Q"분기"') from dual;



-- to_char(날짜또는숫자컬럼명, '리턴시원하는문자패턴')

-- 지정한 날짜 또는 숫자를 원하는 출력문자패턴 으로 바꾸어 주는 변환함수의 일종
--		리턴시 원하는 문자패턴
--			YYYY   => 년도 4자리
--			MM     => 월 2자리
--			DD     => 일 2자리
--			AM HH  => 오전|오후 1~12사이의 시간
--			HH24   => 0~23 사이의 시간
--			MI     => 0~59 사이의 분
--			SS     => 0~59 사이의 초
--			DAY    => 영문 요일 풀네임
--			DY     => 영문 요일 약어
--			Q      => 1~4 사이의 분기
--



--<49-1> employee 테이블에서 직원번호, 직원명, 입사일(X년-X월-X일(요일) X분기 X시X분X초) 검색하면?

select
	emp_no
	,emp_name
	,to_char(hire_date, 'YYYY"년"-MM"월"-DD"일" (dy"요일") Q"분기" HH"시":MI"분":SS"초"') "입사일"
from
	employee;


--<50> employee 테이블에서 직원번호, 직원명, 나이 검색하면?
select
	emp_no
	,emp_name
	,to_number(to_char(sysdate, 'YYYY'))
	 -
	 to_number(decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,2))+1||'살' "나이"
from
 employee

--<51> employee 테이블에서 직원번호, 직원명, 근무년차를 검색해서 출력하면?

select
	emp_no
	,emp_name
	,ceil(  (sysdate - hire_date)/365  )||'년차'	  "근무년차"
from
	employee

-- ceil(~)  => 소수 첫째 자리에서 무조건 올림해서 리턴하는 수학 함수의 일종이다.
-- floor(~) => 소수 첫째 자리에서 무조건 내림해서 리턴하는 수학 함수이다.



--<52> employee 테이블에서 직원번호, 직원명, 연령대를 검색해서 출력하면?

select
 emp_no		 		"직원번호"
 ,emp_name 		"직원명"
 ,floor(
			 	(
				 	to_number(  to_char(sysdate, 'YYYY')  )
				 	-
				 	to_number(
						case substr(jumin_num,7,1) when '1' then '19' when '2' then '19' else '20' end
				  	||substr(jumin_num,1,2)
				  )
				  +1
		  	)* 0.1
 ) ||'0 대'  "연령대"
from
 employee


--<53> employee 테이블에서 직원번호, 직원명, 100일잔치날짜를 검색해서 출력하면?

select
	emp_no				"직원번호"
	,emp_name     "직원명"
	,	to_char(
				  	to_date(
				  		  		case substr(jumin_num,7,1) when '1' then '19'
				  		  		                           when '2' then '19'
				  		  															 else '20' end ||substr(jumin_num,1,6)
				  				, 'YYYYMMDD'
						) +100
						, 'YYYY-MM-DD'
		)	 	"100일잔치날짜"
from
 employee;


--<53-1> 개강일이 2021년5월12일 이고 종강일이 2021년11월10일 이다. 며칠 동안 학원 생활을 하나?

select
	to_date('20211110','YYYYMMDD') - to_date('20210512','YYYYMMDD') "남은일수"
from
 dual;


--<54> employee 테이블에서 직원번호, 직원명, 현재나이, 입사일당시나이 를 검색해서 출력하면?

select
 emp_no "직원번호"
 ,emp_name "직원명"
 ,to_number(to_char(sysdate, 'YYYY'))
 -
 to_number( decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,2) )+1||'세' "현재나이"
 ,to_number(to_char(hire_date, 'YYYY'))
 -
 to_number( decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,2) )+1||'세' "입사일당시나이"
from
 employee


--<55> employee 테이블에서 직원번호, 직원명, 주민번호, 다가올생일날(년-월-일), 생일까지남은일수 를 검색하면?

select
 emp_no			"직원번호"
,emp_name   "직원명"
,jumin_num  "주민번호"
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
				)||'(올해)'
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
	employee;


----------------------------------
--	생일까지 남은일수 계산 방법
----------------------------------
--		만약 올해생일-지금날짜 값이 양수면 생일이 안지났으므로 올해생일날짜-지금날짜면 된다.
--		만약 올해생일-지금날짜 값이 음수면 생일이 지났으므로 내년생일날짜-지금날짜면 된다.


--<56> employee 테이블에서 직원번호, 직원명, 직급, 연봉(xxx,xxx,xxx만원) 를 검색하면?

select
 emp_no
 ,emp_name
 ,jikup
 ,salary
 ,to_char(salary, '999,999,999')||'만원'	as "연봉"
from
 employee;

---------------------------------------------------------
--to_char(salary, '999,999,999') => salary 컬럼안의 숫자를 3자리마다 끊어서 `,` 를 삽입해서 문자로 리턴하기
--                                  만약 각 9 자리에 대응하는 숫자 없으면 화면에 출략이 안된다.
---------------------------------------------------------
--to_char(salary, '099,999,999') => salary 컬럼안의 숫자를 3자리마다 끊어서 `,` 를 삽입해서 문자로 리턴하기
--																	맨앞에 0이 있으면 그자리가 비면 0이 대체된다. 따라서 나머지도 9이어도 다 0으로 대체가 된다.
---------------------------------------------------------



--<57> employee 테이블에서 수요일에 태어난 직원을 검색하라 (새로추가)

select
	*
from
 employee
where
 to_char(
 					to_date(
 					decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,6)
 					, 'YYYYMMDD'
 					)
 					,'DY'
 					, 'NLS_DATE_LANGUAGE = Korean'
 ) = '수';

-----------------------------------------
select
	*
from
 employee
where
 to_char(
 					to_date(
 					decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,6)
 					, 'YYYYMMDD'
 					)
 					,'DAY'
 					, 'NLS_DATE_LANGUAGE = Korean'
 ) = '수요일';

-----------------------------------------
select
	*
from
 employee
where
 to_char(
 					to_date(
 					decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,6)
 					, 'YYYYMMDD'
 					)
 					,'D'
 					, 'NLS_DATE_LANGUAGE = Korean'
 ) = '4';


--<58> employee 테이블에서 70년대생 남자 직원을 검색하라 (새로추가)

select * from employee

where
		substr(jumin_num,1,1) = '7'
		and
		substr(jumin_num,7,1) = '1'


--<59> employee 테이블에서 1960년대, 1970년대 출생자중 남자만 검색하라


select * from employee

where
		(substr(jumin_num,1,1) = '6'
		or
		substr(jumin_num,1,1) = '7')
		and
		(substr(jumin_num,7,1) = '1'
		or
		substr(jumin_num,7,1) = '3')


--<60> employee 테이블에서 오래 근무한 직원이 먼저 나오게 검색하면?

select
	emp_name "직원명"
	,ceil(sysdate-hire_date) "근무일수"
from
	employee
order by
	(sysdate-hire_date) desc;


-- sysdate-hire_date => 지금날짜 - 입사일. 날짜에서 날짜를 빼면 차이만큼 일수를 리턴한다.


--<61> employee 테이블에서 직원번호, 직원명, 근무일수, 근무개월수, 입사후 5개월후 날짜(년-월-일),
-- 입사한달의마지막날짜(년-월-일), 입사한날짜에서돌아오는일요일날짜(년-월-일) 검색하면?
-- 단, 근무일수는 소수 2자리에서 반올림 하삼

select
		emp_no                                         "직원번호"
		,emp_name                                      "직원명"
		,round(sysdate-hire_date, 1)                   "근무일수"
		,trunc(sysdate-hire_date, 1)                   "근무일수"
		,ceil(months_between(sysdate,hire_date))             "근무개월수"
		,to_char(add_months(hire_date,5), 'YYYY-MM-DD')  "입사후5개월후날짜"
		,to_char(last_day(hire_date), 'YYYY-MM-DD')  "입사한달의마지막날짜"
		,to_char(next_day(hire_date,1), 'YYYY-MM-DD') "입사돌아오는일요날짜"
from
 	employee;

--*********************************************
--날짜함수 정리 (리턴값의 자료형을 조심하자)
--*********************************************
--	---------------------------------------------
--	months_between(날짜1, 날짜2) => 날짜1에 날짜2의 차이를 개월수로 리턴하기
--	---------------------------------------------
--	add_months(날짜1, 개월수) => 날짜에 개월수 만큼 더한 날의 날짜를 리턴하기
--	---------------------------------------------
--	last_day(날짜) => 날짜가 속한 달의 마지막 날짜를 리턴하기
--	---------------------------------------------
--	next_day(날짜, 요일정수) => 날짜기준으로 돌아오는 요일의 날짜를 리턴하기
--	                          요일정수는 1~7(1은일 ~ 토)
--	---------------------------------------------
--	날짜1 - 날짜2 => 날짜1 과 날짜2 의 차이를 일수로 리턴하기
--	---------------------------------------------
--	날짜 + 정수 => 날짜에다 정수만큼의 일수를 더한 만큼의 날의 날짜를 리턴하기
--	---------------------------------------------
--	날짜 - 정수 => 날짜에다 정수만큼의 일수를 뺀만큼의 날의 날짜를 리턴하기
--	---------------------------------------------
--*********************************************
--
--round(숫자저장컬럼명, 반올림한 후 보여지는 소수자리수)
--=> round(sysdate-hire_date, 1) => 소수 둘째자리에서 반올림한 결과 리턴
--
--trunc(숫자저장컬럼명, 버린 후 보여지는 소수자리수)
--=> trunc(sysdate-hire_date, 1) => 소수 둘째자리 이후는 모두 버리고 리턴



--<62> employee 테이블에서 직급이 과장인 직원을 검색하면?

select
	*
from
	employee
where
	jikup = '과장';


--<63> employee 테이블에서 직급이 과장이 아닌 직원을 검색하면?

select * from employee where jikup != '과장';
select * from employee where jikup <> '과장';

--위의 두개는 같은 결과를 리턴하는것임.


--<64> employee 테이블에서 부서번호가 10번이고 직급이 과장인 직원을 검색하면?

select
  *
from
	employee
where
  dep_no = 10 and jikup = '과장';


--<65> employee 테이블에서 직급이 과장 또는 부장인 직원을 검색하면? (기)

select * from employee where jikup = '과장' or jikup = '부장';
select * from employee where jikup in('과장', '부장');
select * from employee where jikup = any('과장', '부장');

--in 은 `=` 없다.

--any 왼쪽의 `=` 조심하자.

--위의 세개는 같은 결과를 리턴하는것임.


--<66> employee 테이블에서 10번, 20번 부서 중에 직급이 과장인 직원을 검색하면?

select * from employee

where
	(dep_no = 10 or dep_no = 20) and jikup = '과장';

------------------------------------

select * from employee

where
	dep_no in(10, 20) and jikup = '과장';

------------------------------------

select * from employee

where
	dep_no = any(10, 20) and jikup = '과장';


--<67> employee 테이블에서 담당직원이 없는 고객을 검색하면?

select * from customer
where
	emp_no is null;


--<68> customer 테이블에서 담당직원이 있는 고객을 검색하면?

select * from customer
where
	emp_no is not null;


--<69> customer 테이블에서 담당직원 번호가 9번이 아닌 고객을 검색하면?

select * from customer
where
	(emp_no != 9)
	or
	emp_no is null;

--<주의> emp_no is null 조건도 붙이는 이유는 emp_no가 null 일 경우
--emp_no != 9 조건에 포함되지 않기 때문이다.
--즉, null 은 is null 또는 is not null 연산자에 의해서만 검색된다.


--<70> employee 테이블에서 연봉이 3000만원~4000 만원 사이인 직원을 검색하면?

select * from employee
where
	salary between 3000 and 4000

------------------------------------

select * from employee
where
	salary >= 3000 and salary <= 4000;

--<주의>
--between 왼쪽에 컬럼명이 나온다.
--select * from employee where between salary 3000 and 4000;  (X)
--틀린것 조심하기.


--<71> employee 테이블에서 연봉이 3000만원 이상 ~4000 만원 미만 사이인 직원을 검색하면?

select * from employee
where
	salary >= 3000 and salary < 4000;

-----------------------------------

select * from employee
where
	(salary between 3000 and 4000) and salary != 4000;


--<72> employee 테이블에서 연봉을 5% 인상했다고 가정하고 3000 이상인 직원을  검색하면?

select * from employee
where
 salary + (salary*0.05) >= 3000;

----------------------------------

select * from employee where salary*1.05 >= 3000


--<73> employee 테이블에서 입사일이 '1995-1-1' 이상인 직원을  검색하면?

select * from employee
where
  to_number(to_char(hire_date, 'YYYYMMDD')) >= 19950101


select * from employee where hire_date >= to_date('1995-1-1','YYYY-MM-DD');


--<74> employee 테이블에서 입사일이 '1990년~1999년' 사이인 직원을  검색하면?

select * from employee
where
	to_number(to_char(hire_date, 'YYYY')) between 1990 and 1999

-------------------------------------------------

select * from employee
where
	hire_date >= to_date('1990-1-1','YYYY-MM-DD')
	and
	hire_date < to_date('2000-1-1','YYYY-MM-DD');


--<75> employee 테이블에서 부서번호가 10번 또는 30번인 직원 중에 연봉이 3000미만이고
--입사일이 '1996-01-01' 미만 직원을 검색하면?

select * from employee
where
	(dep_no = '10' or dep_no = '30') and salary < 3000 and hire_date < to_date('1996-1-1', 'YYYY-MM-DD')

---------------------------------------------------

select * from employee
where
dep_no in(10,30)
and salary < 3000
and hire_date < to_date('1996-01-01', 'YYYY-MM-DD');

---------------------------------------------------

select * from employee
where
dep_no = any(10,30)
and salary < 3000
and hire_date < to_date('1996-01-01', 'YYYY-MM-DD');


--<76> employee 테이블에서 성이 김씨인 직원을 검색하면?

select * from employee
where
  substr(emp_name, 1, 1) = '김'

------------------------------------

select * from employee where emp_name like '김%';

-------------------------------------------------
--where 컬럼명 like '패턴문자열' => 컬럼명 안의 데이터가 패턴문자열을 갖고 있으면 그 행을 검색하라
-------------------------------------------------
--emp_name like '김%';
-------------------------------------------------
--=> 김이 첫글자고 두번째는 무엇이와도 좋고 길이에 제한없는 문자패턴을 골라라.
--=> 문자패턴 안의 %는 무엇이 와도 좋고 길이에 제한없음의 의미이다.


--<77> employee 테이블에서 성이 황씨인 직원을 검색하면?
-- 황씨가 없으므로 이, 이미, 로 대체.

select * from employee
where
	substr(emp_name, 1, 1) = '이'
	and
	substr(emp_name, 1, 2) != '이미'

------------------------------------

select * from employee
where
	emp_name like '이%'
	and
	emp_name not like '이미%';


--<78> employee 테이블에서 이름이 2자인 직원을 검색하면?

select * from employee
where
  length(emp_name) = 2

--length(컬럼명) => 컬럼명 안의 문자데이터의 길이를 0이상의 정수로 리턴해주는 함수



--<79> employee 테이블에서 이름이 김으로 끝나는 직원을 검색하면?
-- 김으로 끝나는게 없어서 '만'으로 대체.

select * from employee
where
	emp_name like '%만'

----------------------------------------------------------

select * from employee where substr(emp_name, length(emp_name), 1) = '만';



--<80> employee 테이블에서 성이 김씨이고 3글자인 직원을 검색하면?

select * from employee
where
	(emp_name like '김%') and length(emp_name) = 3

----------------------------------------------------

select * from employee
where substr(emp_name, 1, 1) = '김'
and length(emp_name) = 3;

----------------------------------------------------

select * from employee
where emp_name like '김__'
and length(emp_name) = 3;


--<81> employee 테이블에서 이름에 김이란 문자를 가진 직원을 검색하면?

select * from employee
where emp_name like '%김%'


--<82> employee 테이블에서 성이 김씨가 아닌 직원을 검색하면?

select * from employee
where
emp_name not like '김%'

--------------------------

select * from employee
where
substr(emp_name,1,1) != '김'


--<83> employee 테이블에서 이름중간에만 김이 들어간 직원을 검색하면?
-- 김이 없어서 '부' 로 대체.

select * from employee
where
substr(emp_name,2,1) = '부'

---------------------------------------------------

select * from employee where emp_name like '_부_'

---------------------------------------------------

select * from employee where emp_name like '%부%'
and emp_name not like '부%'
and emp_name not like '%부';


--<84> employee 테이블에서 여자 직원을 검색하라.

select * from employee

where
 substr(jumin_num,7,1) = '2' or substr(jumin_num,7,1) = '4'

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
--만약 주민번호 중간에 - 가 있다면 아래처럼 해도 된다.
-------------------------------------------------
select * from employee where
jumin_num like '-2%' or jumin_num like '-4%';


--<85> employee 테이블에서 1960년대, 1970년대 출생자 중 남자만 검색하라.

select * from employee

where
	(decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,1)||'0' = '1960'
	or decode(substr(jumin_num,7,1),'1','19','2','19','20')||substr(jumin_num,1,1)||'0' = '1970')

	and (substr(jumin_num,7,1) = '1' or substr(jumin_num,7,1) = '3');



select * from employee where
(substr(jumin_num,1,1) = '6' or substr(jumin_num,1,1) = '7')
and substr(jumin_num,7,1) = '1';
---------------------------------------------------------
select * from employee where
(substr(jumin_num,1,1) in('6','7') ) and substr(jumin_num,7,1) = '1';
---------------------------------------------------------
select * from employee where
(jumin_num like '6_____1%') or (jumin_num like '7_____1%');



--<86> 기타 함수 정리하면?

-----------------------------------
숫자함수
-----------------------------------
	-------------
	abs(n)
	-------------
		▶ 숫자 n의 절대값을 반환
		select
		 abs(-100)
		from
		 dual;
	-------------
	floor(n)
	-------------
		▶ 숫자 n이 정수면 그대로 반환하고, 실수면 실수보다 작으면서
			제일 가까운 정수를 반환.
		▶ 좌표계에서 쿵 찍어서 왼쪽 정수값
			소수를 버려서 작아짐.

		select
		 floor(11.111)
		from
		 dual;

		select
		 floor(-11.111)
		from
		 dual;

	-------------
	ceil(n)
	-------------
		▶ 숫자 n이 정수면 그대로 반환하고, 실수면 실수보다 크면서
			제일 가까운 정수를 반환.
		▶ 좌표계에서 쿵 찍어서 오른쪽 정수값

		select
		 ceil(11.111)
		from
		 dual;

 		select
		 ceil(-11.111)
		from
		 dual;

	-------------
	round(n,m)
	-------------
		▶ 숫자 n에서 소수 m+1 자리에서 반올림한 수 리턴
		select
		 round(11.151, 1)
		from
		 dual;
	-------------
	trunc(n,m)
	-------------
		▶ 숫자 n에서 소수 m+1 자리부터 버림
		select
		 trunc(11.151, 1)
		from
		 dual;

	-------------
	sign(n)
	-------------
		▶ n>0 이면 1, n<0 이면 -1, n=0 이면 0을 반환
	select
		 sign(11)
	from
		 dual;


	select
		 sign(-11)
	from
		 dual;

	-------------
	mod(n,m)
	-------------
		▶ n/m 후 나머지 값을 반환
		select
			mod(5,2)  "5/2"
			,mod(7,1) "7/1"
			,mod(10,7) "10/7"
		from dual;
	-------------
	power(n,m)
	-------------
		▶ n의 m승을 반환
		select
		 power(2,2) "2의 2승"
		from
		 dual;


-----------------------------------
문자함수
-----------------------------------
	-------------
	chr(n)
	-------------
		▶ 정수 n을 ascii(아스키) 문자기호로 리턴한다
		select
		 chr(70)
		from
		 dual;
	-------------
	upper(s)
	-------------
		▶ 문자열 s를 대문자로 변환시켜 리턴한다
		select
		 upper('day')
		from
		 dual;


	-------------
	lower(s)
	-------------
		▶ 문자열 s를 소문자로 변환시켜 리턴한다
		select
		 lower('DAY')
		from
		 dual;



	-------------
	length(s)
	-------------
		▶ 문자열 s의 길이를 리턴한다
		select
		 length('DAY')
		from
		 dual;



	-------------
	substr(s, n1, n2)
	-------------
		▶ 문자열 s에서 n1번째 자리부터 n2개 까지의 문자를 리턴한다
		▶ n2 생략 시 마지막까지 문자를 리턴한다
		▶ n1이 0일 경우, 1로 바꿔 실행된다
		▶ 자리수는 n>0 경우 왼쪽부터, n1<0 경우 오른쪽부터 셈한다
		-------------
		select substr( 'You are not alone', 9, 3 ) from dual;
		select substr( 'You are not alone', 5) from dual;
		-------------
		select substr( 'You are not alone', 0, 5 ) from dual;
		select substr( 'You are not alone', -5, 2 ) from dual;
		select substr( 'You are not alone', 5, 0 ) from dual;
	-------------
	trim(s)
	-------------
		▶ 문자열 s1의 맨 좌구측의 공백을 제거하여 리턴한다
			제거 후 또 있으면 계속 제거 후 리턴한다
	-------------
	replace( s1, s2, s3 ) ***
	-------------
		▶문자열 s1에서 s2를 s3로 수정해서 리턴한다.
		▶<예> select replace(addr, '서울특별시','서울시')  from employee
		-------------------------------
		select replace( 'You are not alone', 'You', 'We' ) from dual;
		select replace( 'You are not alone', 'not' ) from dual;
		select replace( 'You are not alone', 'not', '' ) from dual;
		-------------------------------
		select translate( 'You are not alone', 'You', 'We' ) from dual;
	-------------
	initcap( s )
	-------------
		▶문자열 s에서 각 단어의 첫 문자만 대문자로 변환하고 나머지는
		  모두 소문자로 리턴한다.
		▶select  initcap( 'abc def' ) from dual;
	-------------
	lpad( s1, n, s2 )
	-------------
		▶n 자리 만큼 확보하고 s1을 오른쪽 정렬 후 왼쪽에 생긴 빈 공백에
		  문자열 s2를 채워 리턴한다.
		▶select lpad( 'abc', 7, '#' ) from dual;
	-------------
	rpad( s1, n, s2 )
	-------------
		▶n 자리 만큼 확보하고 s1을 왼쪽 정렬 후 오른쪽에 생긴 빈 공백에
		  문자열 s2를 채워 리턴한다.
		▶select rpad( 'abc', 7, '#' ) from dual;
	-------------
	instr( s1, s2, n1, n2 )  ***
	-------------
		▶( s1:타겟문자, s2:찾을문자, 에서 n1:검색시작위치, n2:몇번째에서 )
		<주의>오라클에서 위치를 따질 때 시작은 0이 아니라 1이다.
		▶문자열 s1 에서 문자열 s2 가 있는 위치 반환. (자바의 indexOf(~) 와 비슷한 기능)
		select
			instr( 'Every Sha-la-la-la Every wo-o-wo-o', 'la' ),
			instr( 'Every Sha-la-la-la Every wo-o-wo-o', 'la', 1),
			instr( 'Every Sha-la-la-la Every wo-o-wo-o', 'la', 1, 2),
			instr( 'Every Sha-la-la-la Every wo-o-wo-o', 'la', 12, 2)
		from dual;


--<87> join(조인) 이 뭡니까?


	▶2개 이상의 테이블로부터 연관성있는 [컬럼]을 복사해서 횡으로 붙이는 작업을 말한다.
	▶예> 아래 직원번호와 직원명은 employee 테이블 소속이고, 소속부서명은 dept 테이블소속이다
	-----------------------------------
	직원번호      직원명     소속부서
	-----------------------------------
	   1          홍길동      총무부


--<88> join(조인) 의 종류?

-------------------------------------------------
inner join
-------------------------------------------------
	▶조인 조건에 맞는 행만 포함하는 조인. 대부분이 내부조인이다. (=내부조인 이라고도 한다)
-------------------------------------------------
outer join
-------------------------------------------------
	▶조인 조건에 만족하지 못한 행도 출력하는 조인이다. 쪼까 어렵다. 시험문제 타겟..
-------------------------------------------------
self join
-------------------------------------------------
	▶1개의 테이블을 2개 이상으로 보고 하는 조인이다. 쪼까 어렵다
-------------------------------------------------
cross join
-------------------------------------------------
	▶2개 이상 테이블에서 각각의 행이 모두 연결되는 조인이다. 연결 조건이 생략된다.
	▶잘 사용되지 않는 조인이다.
-------------------------------------------------


--<89> join(조인)에는 ANSI 조인형식과 오라클 조인이 있다는데 뭡니까?

-------------------------------------------------
▶ANSI 조인
-------------------------------------------------
	모든 DB 업체에서 공용으로 사용되는 조인이다.
-------------------------------------------------
▶오라클 조인
-------------------------------------------------
	오라클에서만 사용되는 조인이다.



--<90> 직원번호, 직원명, 소속부서명 검색?

--직원번호와 직원명은 employee 테이블 소속이고, 소속부서명은 dept 테이블 테이블 소속이다.
--2개 테이블로 부터 연관성 있는 [컬럼]을 복사해서 횡으로 붙이는 작업. 즉, 조인이 필요하다.


--조인 조건에 맞는 행만 포함하는 조인 오라클 inner join
select
	e.emp_no
	,e.emp_name
	,d.dep_name
from
 employee e, dept d
where
  e.dep_no = d.dep_no


----------------------------
-- ANSI inner 조인

select
	e.emp_no
	,e.emp_name
	,d.dep_name
from
	employee e inner join dept d
on
	e.dep_no=d.dep_no



--<91> 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면? <조건>담당직원이 있는 고객만 출력<inner join>

--<주의>담당직원이 있는 고객만 나와야하므로 즉, 조건에 맞는 행만 나와야하므로 inner 조인이다.

--inner join
select
	c.cus_name
	,c.tel_num
	,e.emp_name
	,e.jikup
from
 customer c, employee e
where
 c.emp_no = e.emp_no

--ANSI join
select
	c.cus_name
	,c.tel_num
	,e.emp_name
	,e.jikup
from
 customer c inner join employee e
on
	c.emp_no = e.emp_no


--<92> 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면?
--<조건>10번부서의 담당직원이 있는 고객만 출력<inner join>

--inner join
select
	c.cus_name
	,c.tel_num
	,e.emp_name
	,e.jikup
from
 customer c, employee e
where
 c.emp_no = e.emp_no
 and
 e.dep_no = '10'
-- <주의>오라클 조인에서 where 절에 조인 조건과 행을 골라내는 조건이 같이 나올수 있다. and 로 연결하면된다.



--ANSI join
select
	c.cus_name
	,c.tel_num
	,e.emp_name
	,e.jikup
from
 customer c inner join employee e
on
	c.emp_no = e.emp_no
where
 e.dep_no = 10

-- <주의>ANSI 조인에서 on 절에 조인조건을 쓰고, where 절에 행을 골라내는 조건을 쓴다.



--<93> 고객명, 고객전화번호, 담당직원명, 담당직원직급을 출력하면?
--<조건>연봉이 3000만원 이상인 담당직원이 있는 고객만 포함.

--inner join
select
	c.cus_name
	,c.tel_num
	,e.emp_name
	,e.jikup
	,e.salary "직원연봉"
from
 customer c, employee e
where
 c.emp_no = e.emp_no
 and
 e.salary >= 3000

--ANSI join
select
	c.cus_name
	,c.tel_num
	,e.emp_name
	,e.jikup
	,e.salary "직원연봉"
from
 customer c inner join employee e
on
	c.emp_no = e.emp_no
where
	e.salary >= 3000


--<94> [직원명], [직원직급], [직원부서명], [담당고객명], [고객전화]를 출력하면?
--<조건>직원 이름 오름차순 정렬

select
	e.emp_name
	,e.jikup
	,d.dep_name
	,c.cus_name
	,c.tel_num
from
	employee e, customer c, dept d
where
	e.emp_no = c.emp_no and e.dep_no = d.dep_no
order by
	e.emp_name asc;


-- ANSI join
select
	e.emp_name
	,e.jikup
	,d.dep_name
	,c.cus_name
	,c.tel_num
from
	(employee e inner join customer c on e.emp_no = c.emp_no)
	inner join dept d on e.dep_no = d.dep_no
order by
	e.emp_name asc;


--<95> 직원명, 직원직급, 소속부서명, 연봉등급 을 출력하면?
--연봉등급 오름차순, 직급높은순서 오름차순, 나이높은 순서 내림 유지 요망

select
	e.emp_name
	,e.jikup
	,d.dep_name
	,s.sal_grade_no
from
	employee e, dept d, salary_grade s
where
	e.dep_no = d.dep_no and (e.salary >= s.min_salary and e.salary <= s.max_salary)

	e.dep_no = d.dep_no and (e.salary between s.min_salary and s.max_salary)














































