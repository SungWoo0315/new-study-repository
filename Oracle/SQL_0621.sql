

--<90>

select
        employee.emp_no
        ,employee.emp_name
        ,dept.dep_name
    from
        employee, dept
    where
        employee.dep_no=dept.dep_no


-- ��Ī ����.
select
            e.emp_no
            ,e.emp_name
            ,d.dep_name
        from
            employee e, dept d
        where
            e.dep_no=d.dep_no



-- ANSI inner join
select
	e.emp_no
	,e.emp_name
	,d.dep_name
from
	employee e inner join dept d
on
	e.dep_no=d.dep_no


--<91>

select
	c.cus_name	"����"
	,c.tel_num	"����ȭ��ȣ"
	,e.emp_name	"���������"
	,e.jikup	"�����������"
from
	customer c, employee e
where
	c.emp_no=e.emp_no


--<92>

--Oracle join
select
		c.cus_name	"����"
		,c.tel_num	"����ȭ��ȣ"
		,e.emp_name	"���������"
		,e.jikup	"�����������"
	from
		customer c, employee e
	where
		c.emp_no=e.emp_no and e.dep_no = 10


--ANSI join
select
		c.cus_name	"����"
		,c.tel_num	"����ȭ��ȣ"
		,e.emp_name	"���������"
		,e.jikup	"�����������"
	from
		customer c inner join employee e
	on
		c.emp_no=e.emp_no
	where
		e.dep_no = 10


--<93>

select
	c.cus_name	"����"
	,c.tel_num	"����ȭ��ȣ"
	,e.emp_name	"���������"
	,e.jikup	"�����������"
from
	customer c, employee e
where
	c.emp_no=e.emp_no and e.salary >= 3000;


select
	c.cus_name	"����"
	,c.tel_num	"����ȭ��ȣ"
	,e.emp_name	"���������"
	,e.jikup	"�����������"
from
	customer c inner join employee e
on
	c.emp_no=e.emp_no
where
	e.salary >= 3000;


--<94>

-------------------------------------------------
����Ŭ ����
-------------------------------------------------
select
	e.emp_name	"������"
	,e.jikup	"��������"
	,d.dep_name	"�����μ���"
	,c.cus_name	"������"
	,c.tel_num "����ȭ��ȣ"
from
	 employee e, dept d, customer c
where
	e.dep_no=d.dep_no and e.emp_no=c.emp_no
order by
	e.emp_name asc;
-------------------------------------------------
ANSI ����
-------------------------------------------------
select
	e.emp_name	"������"
	,e.jikup	"��������"
	,d.dep_name	"�����μ���"
	,c.cus_name	"������"
	,c.tel_num "����ȭ��ȣ"
from
	 (employee e inner join dept d on e.dep_no=d.dep_no)
	 inner join customer c on c.emp_no=e.emp_no
order by
	e.emp_name asc;




--<95>
select
	e.emp_name	"������"
	,e.jikup	"��������"
	,d.dep_name	"�ҼӺμ���"
	,s.sal_grade_no "�������"
from
	 employee e, dept d, salary_grade s
where
	e.dep_no=d.dep_no and (e.salary>=s.min_salary and e.salary<=s.max_salary)
order by
	s.sal_grade_no asc
	,decode(e.jikup, '����',1,'����',2, '����',3, '�븮',4,'����',5,6) asc
	,	case
			when substr(e.jumin_num,7,1) in('1','2') then '19'
			else '20'
		end || substr(e.jumin_num,1,6)
		asc;


--ANSI
select
  e.emp_name	"������"
  ,e.jikup	"��������"
  ,d.dep_name	"�ҼӺμ���"
  ,s.sal_grade_no "�������"
from
	 (employee e inner join dept d on e.dep_no=d.dep_no)
	 inner join salary_grade s on (e.salary>=s.min_salary and e.salary<=s.max_salary)
order by
	s.sal_grade_no asc
	,decode(e.jikup, '����',1 ,'����',2, '����',3, '�븮',4,'����',5,6) asc
	,	case
		when substr(e.jumin_num,7,1) in('1','2') then '19'
		else '20'
	end || substr(jumin_num,1,6)
	asc;



























