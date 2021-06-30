--<2021-06-30>

--<165>

create table board (
b_no        number(9)                        --> 게시판 글 고유번호

,subject     varchar2(50)     not null            --> 글 제목
,writer      varchar2(30)     not null            --> 글쓴이 이름
,content     varchar2(2000)   not null            --> 글 내용
,pwd         varchar2(12)     not null            --> 암호
,email       varchar2(30)                         --> 이메일

,reg_date    date            default sysdate     --> 등록일
,readcount   number(5)       default 0           --> 조회수

,group_no    number(9)       not null            --> 게시판 글의 소속 그룹번호. 정렬 시 사용.
,print_no    number(9)       not null            --> 같은 그룹번호 내에서 화면 출력 순서 번호. 정렬 시 사용.

,print_level number(9)       not null            --> 같은 그룹번호 내에서 댓글 들여쓰기 레벨 단계 번호. 부모 자식 관계를 알 수 있다.

,primary key(b_no)
)

select * from board;



--<168>
--단순역순, 정순번호
--내가 해본것.
select
	rownum  as "역순번호"
	,b.*
from
(
select
	rownum  as "정순번호"
	,e.*
from
employee e
order by emp_no desc, "정순번호" asc
) b
order by "역순번호" desc


-- 강사님 정순, 역순번호. 설명
--정순번호
select
	rownum
	,e.*
from
	employee e


--역순번호 --서브쿼리 : 매번 서브쿼리가 실행되어 부하가 걸린다.
select
	(select count(*) from employee) - rownum + 1 no_desc --역순번호(서브쿼리)
	,rownum                                       no_asc
	,e.*
from
	employee e
------------------------------------------------------------------------------
--역순번호 -- 인라인뷰 : 부하를 덜 주게 작성.

select
	 x.cnt - rownum + 1 no_desc --역순번호(서브쿼리)
	,rownum                                       no_asc
	,e.*
from
	employee e, (select count(*) CNT from employee) x


-- 정답.
select
  x.cnt - rownum+1 "번호", b.*
from
(
select
  lpad( ' ', print_level*5, ' ' )||decode(print_no, 0, '', 'ㄴ')||subject "글제목"
  ,writer                                  "글쓴이명"
  ,to_char(reg_date, 'YYYY-MM-DD')         "등록일"
  ,readcount                               "조회수"
from
  board
order by
  group_no desc
  ,print_no asc
) b, (select count(*) CNT from board) x

--------------------------------------------------
select
  x.cnt - rownum+1 "번호", b.*
from
(
select
  lpad( ' ', print_level*10, ' ' )||decode(print_no, 0, '', 'ㄴ')||subject "글제목"
  ,writer                                  "글쓴이명"
  ,to_char(reg_date, 'YYYY-MM-DD')         "등록일"
  ,readcount                               "조회수"
from
  board
order by
  group_no desc
  ,print_no asc
) b, (select count(*) CNT from board) x


	-------------
	lpad( s1, n, s2 )
	-------------
		▶n 자리 만큼 확보하고 s1을 오른쪽 정렬 후 왼쪽에 생긴 빈 공백에
		  문자열 s2를 채워 리턴한다.

select lpad( 'abc', 7, ' ' ) from dual;




































































