
create user king  identified by k123;

grant connect,resource,dba to king;


select to_char(sysdate,'YYYY-MM-DD(DY) HH24"시"', 'NLS_DATE_LANGUAGE = Korean') from dual

select to_char(sysdate,'YYYY-MM-DD(DY) HH24"시"') from dual

  create sequence sq_test
    start with 1
    increment by 1
    minvalue 1
    maxvalue 9999;


    drop sequence sq_test

    -- 시퀀스 현재 값
    SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'sq_test';


 select sq_test.nextval from dual

 SELECT sq_test.CURRVAL FROM DUAL;

 ALTER SEQUENCE sq_test INCREMENT BY 1;

 -- 시퀀스 번호 초기화 방법.
 -- alter 로 마이너스 값 줘서 값을 마이너스로 빼고 다시 increment 값을 1로 변경하면 1씩 증가한다.






 select parameter, value from nls_database_parameters;


--------------------------------------------
--●날짜 데이터는 '년-월-일'  로 입력 가능하게 하기
--------------------------------------------
alter session set nls_date_format = 'yyyy-mm-dd' ;     -- 입력 format을 변경해줌.


ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';


select sysdate from dual


select to_char(sysdate, 'mon') from dual
select to_char(sysdate, 'day') from dual
select to_char(sysdate, 'dy') from dual

commit;