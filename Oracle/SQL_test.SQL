DESC employee;


DESC dual;


SELECT *
FROM
	dual;


SELECT
	SYSDATE
FROM
	dual;


SELECT
--날짜 포맷
--TO_CHAR(SYSDATE,'YYYYMMDD')			--20191130
--,TO_CHAR(SYSDATE,'YYYY-MM-DD')	--2019-11-30
--,TO_CHAR(SYSDATE,'YYYY/MM/DD')	--2019/11/30
--,TO_CHAR(SYSDATE,'YYYY')				--2019
--,TO_CHAR(SYSDATE,'YY')					--19
--,TO_CHAR(SYSDATE,'MM')					--11
--TO_CHAR(SYSDATE,'MON')					--11월
--,TO_CHAR(SYSDATE,'D')						--7 (주중의 일을 1~7로 표시(일요일 = 1)
--,TO_CHAR(SYSDATE,'DD')					--30
--,TO_CHAR(SYSDATE,'DDD')					--334 (1년기준 일 수)
--,TO_CHAR(SYSDATE,'DAY')					--토요일 (요일 표시)
--,TO_CHAR(SYSDATE,'DY')					--토 (요일을 한자리로 표시)
--,TO_CHAR(SYSDATE,'WW')					-- 48 (일년 기준 주를 00 ~ 53 형태로 표시)
--,TO_CHAR(SYSDATE,'W')						-- 5 (한달 기준 몇번째 주)
--TO_CHAR(SYSDATE,'DL')					--2019년 11월 30일 토요일

--시간 포맷
--,TO_CHAR(SYSDATE,'AM')			--오전
--,TO_CHAR(SYSDATE,'PM')			--오후
--,TO_CHAR(SYSDATE,'HH')			--10 (시간을 0 ~ 12 형태로 표시)
--,TO_CHAR(SYSDATE,'HH24')		--20 (시간을 0 ~ 24 형태로 표시)
--,TO_CHAR(SYSDATE,'MI')			--03 (분을 00 ~ 59 형태로 표시)
--,TO_CHAR(SYSDATE,'SS') 		--10 (초을 01 ~ 59 형태로 표시)

--분기
TO_CHAR(SYSDATE,'Q')       -- 분기.

----세기 포맷
--,TO_CHAR(SYSDATE,'CC')			--21 (세기)
--,TO_CHAR(SYSDATE,'BC')			--서기
FROM
dual;




