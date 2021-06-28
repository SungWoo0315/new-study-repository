<2021-06-28>

--<139>
--inline view

--<140>
select
	e.*
from
	employee e

--rownum 테이블이 자동으로 붙는다.
select
	rownum, e.*
from
	employee e

--order by salary 해주면 일련번호가 꼬인다. 이때 인라인뷰가 필요함.
--salary 정렬하고 rownum이 붙는것이 아니다. 먼저 붙어버리고 정렬되어서 꼬임.
select
	rownum, e.*
from
	employee e
order by salary


select
	rownum, emp_no, emp_name, jikup
from
	employee


select
	rownum, dep_no, dep_name, loc
from
	dept;


select
	rownum, emp_no, emp_name, jikup
from
	employee
where
	rownum<=10
order by
	salary desc


select
	rownum, e.*
from
	employee e
where
	rownum<=10
order by
	salary desc

-- inline view를 써서 정렬해주면 원하는 결과를 얻을수 있다.
select
	rownum, e.*
from
	(select * from employee order by salary desc) e
where
	rownum<=10

-- 위를 활용하여 11행부터 20행까지 조건. 하지만, 나오지 않는다.
-- rownum이 where절에 들어갈때 rownum 1이 들어가서 true 되는 조건만 나올수 있는데,
-- rownum>=11 에서 1이 포함 안되기 때문에 false.
-- 이런식으로는 행 검색을 할 수 없다.
select
	rownum, e.*
from
	(select * from employee order by salary desc) e
where
	rownum>=11 and rownum<=20

--

select
	rownum RNUM, e.*
from
	(select * from employee order by salary desc) e
where
	rownum<=10

-- 11행 부터 20행까지 추출.
select
	*
from
(
select
	rownum RNUM, e.*
from
	(select * from employee order by salary desc) e
where
	rownum<=20
)
where
	RNUM>=11


-- 6행부터 10행까지 추출.
select
	*
from
(
select
	rownum RNUM, e.*
from
	(select * from employee order by salary desc) e
where
	rownum<=10
)
where
	RNUM>=6

--정답은 동일하다. 바깥쪽에선 RNUM 단순 컬럼으로 인식.
select
	*
from
(
select
	rownum RNUM, e.*
from
	(select * from employee order by salary desc) e
)
where
	RNUM>=1 and RNUM<=10;



-- 고객을 나이대로 서열 정리. 6행부터 10행까지.

select * from ( select rownum RNUM, zxcvb.* from (
	select * from customer
	order by
		decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,6) asc
) zxcvb where rownum<=10 ) where RNUM>=6;

-- <새끼문제> 직원 직급 서열중 2행~5행 까지 검색하면?

select * from ( select rownum RNUM, zxcvb.* from (
	select * from employee
	order by
		decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, '사원', 6) asc
) zxcvb where rownum<=5 ) where RNUM>=2;

