


create table dept(
    dep_no       number(3)       primary key
    ,dep_name    varchar2(20)    not null unique
    ,loc         varchar2(20)    not null
);

select * from dept;


drop table dept;