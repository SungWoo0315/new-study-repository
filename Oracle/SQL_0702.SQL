--<2021-07-02>

--<112> 10번 부서 직원들이 관리하는 [고객번호], [고객명], [직원번호]을 검색하면?
--------------------------------------------------------
select
	c.cus_no
	,c.cus_name
	,c.emp_no
from
	customer c
where
	exists( select e.emp_no from employee e
					where e.emp_no = c.emp_no and e.dep_no = 10);
--------------------------------------------------------
select
	c.cus_no
	,c.cus_name
	,c.emp_no
from
	customer c
where
	exists( select 1 from employee e
					where e.emp_no = c.emp_no and e.dep_no = 10);
--------------------------------------------------------
exists 검색 실행 속도가 매우 빠르다.
특정 조건안에 true 를 리턴.
셀렉트 결과물안에 무조건 데이터만 있으면 true 를 리턴

