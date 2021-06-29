--<2021-06-29>

-- 연봉이 보안사항인데 abc 계정이 연봉만 빼고 보여주고 싶을때.
-- select 권한을 빼앗아 버리면 다른정보를 조회 못하기 때문에
-- view를 사용해서 보여 줄 수 있다.
-- 보안상 연봉을 빼고 보여주고싶을때.

SELECT * FROM EMPLOYEE;


-- view 생성
create view employee_vw1 as
	select
		emp_no, emp_name, dep_no, jikup, hire_date, jumin_num, phone_num, mgr_emp_no
	from
		employee;

SELECT * FROM employee_vw1;



-- <137>로 view 생성
-- 보안과 상관없이 엄청 긴 select문을 재 사용할때 view 저장하고 사용하면 편하다.
create view dept_info as
	select
		d.dep_no          "부서번호"
		,d.dep_name       "부서명"
		,count(distinct(e.emp_no))  "직원수"
		,count(c.emp_no)           "관리고객수"
	from
		employee e, dept d, customer c
	where
		d.dep_no = e.dep_no(+)
		and
		e.emp_no = c.emp_no(+)
	group by
		d.dep_no, d.dep_name;

SELECT * FROM dept_info;  -- where 도 적용 가능.




-- <147>
insert into employee_vw1 (
	emp_no, emp_name, dep_no, jikup, hire_date, jumin_num, phone_num, mgr_emp_no
)values(
	(select nvl(max(emp_no), 0)+1 from employee_vw1) -- 맨처음 들어갈때 null 이 뜰수 있기 때문에 nvl 써준다.
		, '이승엽', 40, '과장', to_date('1990-09-01', 'YYYY-MM-DD'), '7811231452719', '01090056376', 1
);

COMMIT;

SELECT * FROM employee_vw1;

-- <148>

update employee_vw1 set jikup='부장' where emp_name='이승엽' and jumin_num='7811231452719'

-- 변경되었는지 확인.
select * from employee;
select * from employee_vw1;

COMMIT;

-- <149>

delete from employee_vw1 where jumin_num='7811231452719';

-- 삭제되었는지 확인.
select * from employee;
select * from employee_vw1;


-- <150>
-- 뷰 삭제.
drop view employee_vw1;



-- <152>
insert into dept values(60, '전략부', '부산');
--------------------------------------------
create view dept_vw1 as
	select dep_no, dep_name, loc from dept
	where dep_no=60 with check option;

SELECT * FROM dept_vw1

<문> update dept_vw1 set dep_no=70 where dep_no=60; 을 실행하면? -- with check option 때문에 실행되지 않는다.

<문> insert into dept_vw1 values(70, '미래부', '대구'); 을 실행하면? -- with check option 때문에 실행되지 않는다.


-- <153>
create view employee_vw6 as
select emp_no, emp_name, dep_no, jikup, salary from employee where salary>=3000
with check option;

SELECT * FROM employee_vw6;

<문> update employee_vw6 set salary=salary*0.95 where salary>=3000 을 실행하면?? -- with check option 때문에 실행되지 않는다.
-- 5% 깍으면 3000 미만으로 내려가기 때문에 where 조건에 위배되어서 실행되지 않는다.
-- 5% 깍아도 3000 밑으로 내려가지 않으면 실행된다.


-- <155>
-- 생성한 뷰의 정보 검색 방법
select view_name, text from user_views;


-- <156>






-- <161>

select distinct emp_no from customer where emp_no is not null






-- <162>


select emp_no from employee order by salary desc, decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4) asc, hire_date asc, jumin_num asc;


select * from ( select rownum RNUM, zxcvb.* from (

		--select count(*)+1 from employee e2 where e2.salary>salary

		select * from employee order by salary desc, decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4) asc, hire_date asc, jumin_num asc

	) zxcvb where rownum<=5 ) where RNUM>=2;












