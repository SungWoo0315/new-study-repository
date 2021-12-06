Oracle 날짜/시간 관련 함수 정리

1. Oracle에서의 날짜 특징
 
＊oracle은 세기,년,월,일,시간,분,초의 내부숫자 형식으로 날짜를 저장합니다.
＊디폴트 날짜형식은 'DD-MON-YY' 입니다.
＊SYSDATE는 현재의 날짜와 시간을 리턴하는 함수입니다.(date타입)
ex : 2007-01-07 오후 10:34:00
＊DUAL은 SYSDATE를 보기위해 사용된 dummy table입니다.
 
2. Oracle에서의 날짜연산
 
* 날짜에서 숫자(날수)를 빼거나 더하여 날짜 결과를 리턴합니다. 결과는 날짜형식
* 날짜 사이의 일수를 알기 위하여 2개의 날짜를 뺍니다.
* 시간을 24로 나누어 날짜에 더합니다.
 
날짜 + 숫자 : 날짜 특정한 날로부터 몇일 후의 날짜 계산
날짜 - 숫자 : 날짜 특정한 날로부터 몇일 전의 날짜 계산
날짜 - 날짜 : 숫자 두 날짜 사이의 차이를 숫자로 계산
 
3. Oracle에서의 날짜 컬럼데이타형
 
date 형
 
4. 월과 일을 문자로 출력시 한글로 나오는거 영문으로 나오게 하기
 
오라클 환경 설정에 따라 아래 쿼리를 실행시키면 "7월" 이라고 나올수 있다.
SELECT TO_CHAR(SYSDATE,'mon') FROM DUAL;
 
오라클 환경 설정에 따라 아래 쿼리를 실행시키면 "월요일" 이라고 나올수 있다.
SELECT TO_CHAR(sysdate,'day') FROM DUAL;
 
영문("Jul")으로 출력시키려면 아래 명령으로 환경설정을 변경한다.
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';
 
※ 월요일, 화요일 형식이 아닌 월, 화 형식으로 나타내기
SELECT TO_CHAR(sysdate,'day') FROM DUAL;
 
5. 날짜의 순서결과 데이타형
 
날짜 - 날짜 = 숫자
숫자 + 날짜 = 날짜
(날짜 - 날짜) + 날짜 = 날짜
날짜 + 날짜 = error
 
※ trunc함수를 날짜데이타에 사용하기
 
SELECT SYSDATE FROM DUAL;
--2006-02-08 오전 12:11:05
 
SELECT TRUNC(SYSDATE) FROM DUAL;
SELECT TRUNC(SYSDATE,'DD') FROM DUAL;
--단지 시간을 없애고 날짜만 나오게 한다.
--2006-02-08
 
SELECT TRUNC(SYSDATE,'D') FROM DUAL;
--시간을 없애고 일을 가장최근에 지난 일요일 일로 초기화합니다.(권장)
--2006-02-05
 
SELECT TRUNC(SYSDATE,'D')+1  FROM DUAL;
--시간을 없애고 일을 가장최근에 지난 월요일 일로 초기화합니다.
 
SELECT TRUNC(SYSDATE,'D')-1  FROM DUAL;
--시간을 없애고 일을 가장최근에 지난 토요일 일로 초기화합니다.
 
SELECT TRUNC(SYSDATE,'WW') FROM DUAL;
--시간을 없애고 일을 가장최근에 지난 일요일 일로 초기화합니다.
--2006-02-05
 
SELECT TRUNC(SYSDATE,'MM') FROM DUAL;
--시간을 없애고 일을 1로 초기화합니다.
--2006-02-01
 
SELECT TRUNC(SYSDATE,'Y') FROM DUAL;
SELECT TRUNC(SYSDATE,'YY') FROM DUAL;
SELECT TRUNC(SYSDATE,'YYY') FROM DUAL;
SELECT TRUNC(SYSDATE,'YYYY') FROM DUAL;
--시간을 없애고 년도는 올해 년도와 월과 일을 모두 1 로 변경하여 출력합니다.
ex. 2006-01-01
 
SELECT TO_CHAR(SYSDATE,'YYYYMMDD') FROM DUAL;
SELECT TO_CHAR('20070715') FROM DUAL;
-- 현재 날짜를 YYYYMMDD 형식으로 출력한다.(자주사용)
 
8자리일자와 6자리시간을 문자열로 출력
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD'), TO_CHAR(SYSDATE, 'HH24MISS') FROM DUAL
 
6. 날짜 관련 쿼리 예제
 
해당일이 그달의 몇째주인지 알아내기(w)
SELECT TO_CHAR(TO_DATE('20061224', 'YYYYMMDD'), 'W') FROM DUAL;
 
해당년도의 전체 일수 구하기
SELECT TO_DATE('20001231', 'YYYYMMDD') - TO_DATE('20000101', 'YYYYMMDD') FROM DUAL 
SELECT TO_CHAR (TO_DATE (:YYYY || '1231'), 'DDD') ILSU FROM DUAL
-- 위의 쿼리는 년도를 변수로 사용하였다.
 
UPDATE TAB1 SET LOGDATE = SYSDATE, ISMODIFY = 1 WHERE LOGDATE < SYSDATE-7
--기록된 날짜(LOGDATE)가 현재날짜(SYSDATE)로부터 일주일이 지났으면
--SYSDATE를LOGDATE에 쓰고 날짜가 바뀌었다는 기록을 남기는(ISMODYFY = 1) 쿼리
 
UPDATE TAB1 SET LOGDATE = SYSDATE, ISMODIFY = 1 WHERE LOGDATE < TRUNC(SYSDATE,'D')
기록된 날짜(LOGDATE)가 일요일이 한번이라도 지났다면, 즉 이번주 일요일부터 토요일간의 기록이라면 그대로 두고 그 이상 오래된 경우 현재날짜(SYSDATE)를 LOGDATE에 남기는 쿼리
 
SELECT ENAME,JOB,HIREDATE FROM EMP WHERE HIREDATE BETWEEN '1981-02-20' AND '1981-05-01';
--1981년02월20일부터 1985년05월01일까지의 레코드를 검색한다.(꼭옛날날짜에서최근날짜로검색)
 
SELECT ENAME,(SYSDATE - HIREDATE)/7 WEEK FROM EMP;
--sysdate함수로 현재 날짜시간에서 입사날짜(hiredate)를 빼면 일수가나오고 거기서 7을 나누어
--근무한 주수를 알수있습니다.
 
SELECT * FROM EMP WHERE HIREDATE='1980/12/17';
--날짜 비교는 ''을 이용하여 비교합니다.
 
SELECT MONTHS_BETWEEN(SYSDATE,HIREDATE)/12 ,HIREDATE FROM EMP;
--오늘 날짜에서 입사날짜를 빼서 달수를 구한 후 12을 나누어 근무한 년수를 구할수있다.
 
SELECT MONTHS_BETWEEN(TO_DATE(20011129,'YYYYMMDD'),TO_DATE(20020228,'YYYYMMDD')) FROM DUAL;
--첫번째 날짜에서 두번째 날짜를 빼서 달수로 구한다.
 
SELECT ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12) ,HIREDATE FROM EMP;
--소수점이 있는 결과에서 반올림합니다.
 
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12) ,HIREDATE FROM EMP;
--소수점이 있는 결과에서 버림합니다.
 
※ ADD_MONTHS 함수예제
 
SELECT ADD_MONTHS(HIREDATE,2) FROM EMP;
-- HIREDATE값에 2달를 더하여 출력
 
SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-1), 'YYYYMMDD'),
TO_CHAR(SYSDATE-30, 'HH24MIDD') FROM DUAL;
-- DATE형 현재 날짜시간에서 1달을 뺀후 출력
 
SELECT TO_CHAR(ADD_MONTHS(TO_DATE('20060907230000','YYYYMMDDHH24MISS'), -1),'YYYYMMDDHH24MI') FROM DUAL;
-- CHAR형 현재 날짜시간에서 1달을 뺀후 출력
 
SELECT ADD_MONTHS(TO_DATE('200706'||'01','YYYYMMDD'),-1) FROM DUAL
-- 20070601에서 한달을 뺍니다.
 
SELECT ADD_MONTHS(HIREDATE,-2) FROM EMP;
--입사날짜에서 2달을 빼서 출력합니다.
 
SELECT HIREDATE+100 FROM EMP;
--입사날짜에서 100일을 더합니다.
 
SELECT HIREDATE-100 FROM EMP;
--입사날짜에서 100일을 뺍니다.
 
※ LAST_DAY() 함수
 
해당 날짜에 달에 마지막 일의 날짜를 출력한다.
SELECT LAST_DAY('2006-05-05') FROM DUAL;
--2006-05-31
 
SELECT LAST_DAY(SYSDATE) FROM DUAL;
--2006-05-31 오후 10:35:51
 
※Oracle에서는 날짜함수에(sysdate) 산술연산이 가능합니다.
 
1일->1
1시간->1/24
1분->1/24/60
1초->1/24/60/60
 
SELECT SYSDATE-1 FROM DUAL;
--지금 시간 기준으로 1일전
 
SELECT SYSDATE-(1/24) FROM DUAL;
--지금 시간 기준으로 1시간전
 
SELECT SYSDATE+1/24/60*1 FROM DUAL;
--지금 시간 기주으로 1분전
 
SELECT SYSDATE+1/24/60*10 FROM DUAL;
--지금 시간 기주으로 10분전
 
SELECT TO_DATE(200611210800,'YYYYMMDD HH24MISS')+ 10/24 FROM DUAL;
--10시간을 더한다.
 
SELECT TO_CHAR(TO_DATE('2005-05-05'),'D') FROM ACCOUNT;
--날짜를 숫자형식의 요일로 출력(1-일요일,7-토요일)
 
SELECT TO_CHAR(TO_DATE('2005-05-05'),'DAY') FROM ACCOUNT;
--날짜를 알파벳요일로 출력
 
SELECT TO_CHAR(TO_DATE('2005-05-05'),'YEAR') FROM ACCOUNT;
--날짜를 알파벳년도로 출력
 
SELECT TO_CHAR(TO_DATE('2005-05-05'),'MONTH') FROM ACCOUNT;
-- 월을 영문으로 완벽하게 출력
 
SELECT TO_CHAR(TO_DATE('2005-05-05'),'MON') FROM ACCOUNT;
-- 월을 영문 앞 3글자만 출력
 
SELECT  DECODE(TO_CHAR(TO_DATE('2005-05-05'),'D'),
              '2','1',
              '3','2',
              '4','3',
              '5','4',
              '6','5',
              '7','6',
              '1','7') "요일"
FROM   DUAL;
--날짜의 요일을 숫자로 출력(1-월요일,7-일요일)
 
※ DATE형 컬럼 비교시
 
SELECT * FROM TABLE_NAME WHERE FDATE < to_date('20070711','YYYYMMDD')
 
6. 프로그래밍 언어에서 날짜 검색시 방법
 
날짜 관련 컬럼은 DATE, CHAR(8), NCHAR(8)을 주지만 DATE는 7바이트이다.
DATE형은 아래와 같이 검색 조건을 사용한다.
 
WHERE A_DATE BETWEEN '2005-10-10' AND '2005-10-30';
WHERE A_DATE BETWEEN TO_DATE('2005-10-10') AND TO_DATE('2005-10-30');
 
CHAR(8), NCHAR(8)형은 아래와 같이 검색조건을 사용한다.
 
WHERE A_DATE BETWEEN '20051010' AND '20051030';
 
두가지의 장단점을 알아보자
 
7. 해당 시간이 현재 24시간이 지났는지 알수 있는 쿼리
 
SELECT CASE WHEN SYSDATE - TO_DATE('20070727','YYYYMMDD') >= 1 THEN 'Y' ELSE 'N' END RESUAL FROM DUAL;
 
※ SYSDATE가 날짜형이므로 빼주는 값도 날짜형이어야 합니다.
 
SELECT ROUND(TO_DATE('95/05/25'),'DAY') FROM DUAL
1995/05/28 00:00:00
 
SELECT TRUNC(TO_DATE('95/05/25'), 'DAY') FROM DUAL
1995/05/21 00:00:00
 
문제는 day 함수에 있습니다.
day함수는 요일을 나타내죠.
따라서 to_date('95/05/25')를 day로 표시하면 수요일이 나옵니다.
위에 쿼리는 그걸 반올림하였으니 그 주에 가장 큰 28일이 나왔구요,
아래 쿼리는 그걸 잘라내버렸으니 그 주에 가장 작은 21일이 나온 겁니다.
 
SELECT SYSDATE +  2/24 FROM DUAL;
-- 현재시간의 2시간후에 시간을 출력
 
SELECT SYSDATE -  2/24 FROM DUAL;
-- 현재시간의 2시간전의 시간을 출력
 
SELECT  TO_CHAR(TRUNC(SYSDATE), 'RRRR/MM/DD') A FROM DUAL;
SELECT  TO_CHAR(TRUNC(SYSDATE), 'YYYY/MM/DD') A FROM DUAL;
 
YYYY포맺은 현재를 기준으로 합니다.
 
RRRR기준은 .년도의 뒷자리를 기준으로
2000년도 기준으로 보면
0-49 년은 after year 35/12/12 ->2055/12/12
50-99 년은 before year 51/12/12 ->1951/12/12
가 됨니다.
 
8. 날짜 관련 함수
 
※ SYSDATE 함수
 
현재 시스템 날짜를 출력
SELECT SYSDATE FROM DUAL;
-- ORACLE 10g XE 에서 출력되는 날짜형식
-- 2008-05-17 오후 5:15:17
 
※ LAST_DAY 함수
 
해당 날짜의 달에서 마지막 일을 출력
 
SELECT LAST_DAY(SYSDATE) FROM DUAL;
--2008-05-31 오후 5:16:54
