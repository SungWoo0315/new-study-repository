


create table dept(
    dep_no       number(3)       primary key
    ,dep_name    varchar2(20)    not null unique
    ,loc         varchar2(20)    not null
    , primary key(dep_no)
);

insert into dept(dep_no, dep_name, loc) values(10, '총무부', '서울');
insert into dept(dep_no, dep_name, loc) values(20, '영업부', '부산');
insert into dept(dep_no, dep_name, loc) values(30, '전산부', '대전');
insert into dept values(40, '자재부', '광주');


select * from dept;

create table employee(
    emp_no      number(3)
    ,emp_name   varchar2(20)    not null
    ,dep_no     number(3)
    ,jikup      varchar2(20)    not null
    ,salary     number(9)       default 0
    ,hire_date  date            default sysdate  --입사일 저장
    ,jumin_num  char(13)        not null unique
    ,phone      varchar2(15)    not null
    ,mgr_emp_no number(3)

    , primary key(emp_no)
    , foreign key(dep_no) references dept(dep_no)
    , constraint employee_mgr_emp_no_fk foreign key(mgr_emp_no) references employee(emp_no)  -- 제약조건에 이름을 부여.
);

select * from employee;






commit;      -- 커밋



--drop table dept;  --테이블 삭제