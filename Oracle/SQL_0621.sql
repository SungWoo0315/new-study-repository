

--<90>

select
        employee.emp_no
        ,employee.emp_name
        ,dept.dep_name
    from
        employee, dept
    where
        employee.dep_no=dept.dep_no

-- º°Äª ¹öÀü.
select
            e.emp_no
            ,e.emp_name
            ,d.dep_name
        from
            employee e, dept d
        where
            e.dep_no=d.dep_no
