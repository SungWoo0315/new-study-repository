drop table dept;  -- 테이블 제거


-- 오라클용 테이블생성. 
create table MySQL_TEST.dept(
    dep_no       int                                     -- [부서 번호] 저장 컬럼 선언. 자료형은 숫자형
    ,dep_name    varchar2(20)    not null unique         -- [부서 명] 저장 컬럼 선언. 자료형은 문자형. 제약조건 비지마! 중복마!
    ,loc         varchar2(20)    not null                -- [부서위치] 저장 컬럼 선언. 자료형은 문자형. 제약조건은 비지마!
    , primary key(dep_no)                                -- dep_no 컬럼에 primary key 설정하기.
);

-- mariaDB 용 테이블 생성
CREATE TABLE `MySQL_TEST`.`dept` (
  `dep_no` INT NOT NULL,
  `dep_name` VARCHAR(45) NOT NULL,
  `loc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dep_no`));

-- 테이블에 데이터 입력
insert into dept(dep_no,dep_name,loc) values(10,'총무부','서울');
insert into dept(dep_no,dep_name,loc) values(20,'영업부','부산');
insert into dept(dep_no,dep_name,loc) values(30,'전산부','대전');
insert into dept(dep_no,dep_name,loc) values(40,'자재부','광주');


select * from dept;

commit;

desc dept;


