


create table dept(
    dep_no       number(3)       primary key
    ,dep_name    varchar2(20)    not null unique
    ,loc         varchar2(20)    not null
);

insert into dept(dep_no, dep_name, loc) values(10, '총무부', '서울');
insert into dept(dep_no, dep_name, loc) values(20, '영업부', '부산');
insert into dept(dep_no, dep_name, loc) values(30, '전산부', '대전');
insert into dept(dep_no, dep_name, loc) values(40, '자재부', '광주');

commit;

select * from dept;

drop table dept;