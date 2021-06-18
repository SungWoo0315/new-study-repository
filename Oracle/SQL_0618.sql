-- 20210618


-- <57>
select * from employee
where
to_char(
        to_date(
            case substr(jumin_num,7,1) when '1' then '19'
            when '2' then '19' else '20' end||substr(jumin_num,1,6)
            , 'YYYYMMDD'
        )
        , 'DY'
        , 'NLS_DATE_LANGUAGE = Korean'
	) = '¼ö';



select * from employee
where
to_char(
	to_date(
      decode(substr(jumin_num,7,1), '1', '19', '2', '19', '20')||substr(jumin_num,1,6), 'YYYYMMDD'
		)
		,'D'
)
= '4';


----

--<58>

select * from employee
	where
		substr(jumin_num,1,1) = '7'
		and
		substr(jumin_num,7,1) = '1' ;


--<59>
select * from employee
where
	(substr(jumin_num,1,1) = '6'
	or
	substr(jumin_num,1,1) = '7'
	)
	and
	(substr(jumin_num,7,1) = '1'
	or
	substr(jumin_num,7,1) = '3'
	);


-<60>






















