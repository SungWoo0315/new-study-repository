

-- 2021-08-21

-- 비동기 방식에 쓰일 로그인 아이디, 암호 담긴 테이블 작성,
-- 테이블에 연동해서 확인 할 아이디, 암호 insert 해주기.

create table login(
	login_no		number(3)									 		 -- 정수 0~999 까지 저장.
	,login_id		varchar2(20) not null unique	 -- 로그인 아이디 저장
	,pwd				varchar2(20) not null					 -- 암호
	,primary key(login_no)										 -- PK 선언.
);

insert into login values(1,'abc', '123');
insert into login values(2,'xyz', '123');
insert into login values(3,'tom', '123');
insert into login values(4,'lsw0315', 'lsw0315');


select * from login

delete from login where LOGIN_NO = 4

commit;


---
--board 테이블 생성

create table board (
b_no        number(9)                        			--> 게시판 글 고유번호

,subject     varchar2(100)     not null           --> 글 제목
,writer      varchar2(30)     not null            --> 글쓴이 이름
,content     varchar2(2000)   not null            --> 글 내용
,pwd         varchar2(12)     not null            --> 암호
,email       varchar2(30)                         --> 이메일

,reg_date    date            default sysdate      --> 등록일
,readcount   number(5)       default 0            --> 조회수

,group_no    number(9)       not null             --> 게시판 글의 소속 그룹번호. 정렬 시 사용.
,print_no    number(9)       not null             --> 같은 그룹번호 내에서 화면 출력 순서 번호. 정렬 시 사용.

,print_level number(9)       not null             --> 같은 그룹번호 내에서 댓글 들여쓰기 레벨 단계 번호. 부모 자식 관계를 알 수 있다.

,primary key(b_no)
)



select * from board;







