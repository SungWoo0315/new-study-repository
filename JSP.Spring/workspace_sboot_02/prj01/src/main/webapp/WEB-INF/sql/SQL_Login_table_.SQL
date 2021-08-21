

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


commit;

