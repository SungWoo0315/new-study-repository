
--<2021년 8월 20일>

--<아이디, 암호 테이블 작업>

-- src/main/webapp/WEB-INF/sql 경로에 넣는다.

create table login(
	login_no         number(3)                       -- 정수 0~999 까지 저장.
	,login_id        varchar2(20) not null unique    -- 로그인 아이디 저장
	,pwd             varchar2(20) not null           -- 암호
	,primary key(login_no)

);

insert into login values(1,'abc', '123');
insert into login values(2,'xyz', '123');
insert into login values(3,'tom', '123');

commit;


select * from login



        select count(*) from login where login_id='tom' and pwd='123'

--------------------------------------------------------------------------------

select * from board order by b_no asc

delete from board where b_no >= 5

delete from board


select
    subject
    ,rownum
    ,writer
    ,readcount||''
    ,reg_date
from
    board


--
--조회수 초기화 하는 쿼리
update board set readcount = 0 where b_no=27




select * from board order by b_no -- 테이블 확인

commit

delete from board where b_no = 27






-- 존재 개수 확인, PK 이용.
select count(*) from board where b_no = 1


--자식글 개수 구하기
select
    count(*)
from
    board
where
    group_no=(select group_no from board where b_no = 1)
    and
    print_no=(select print_no+1 from board where b_no = 1)
    and
    print_level=(select print_level+1 from board where b_no =1)


-- like 검색 조건
select
	*
from
	employee
where
	emp_name like '%김%'



-- <패턴> n행~m행 까지 검색하는 select 패턴 정리1

--직급서열대로 정렬.
--11행부터 20행 까지 보여주는 쿼리.

select * from ( select rownum RNUM, zxcvb.* from (

	select
		*
	from
		employee
	order by
		decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, '사원', 6, 7) asc


) zxcvb where rownum<=20 ) where RNUM>=11;



--<패턴> n행~m행 까지 검색하는 select 패턴 정리2

select * from ( select rownum RNUM, zxcvb.* from (


	select
		*
	from
		employee
	order by
		decode(jikup, '사장', 1, '부장', 2, '과장', 3, '대리', 4, '주임', 5, '사원', 6, 7) asc



) zxcvb) where RNUM>=11 and RNUM<=20 ;


--------

select * from ( select rownum RNUM, zxcvb.* from (

	select
		*
	from
		board
	where
		1=1
		and
		subject like '%얀%'
	order by
		group_no desc
		,print_no asc


) zxcvb where rownum<=10 ) where RNUM>=1;







