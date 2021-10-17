
/*중분류 모바일 테이블*/
create table ID_m_sub_category(
    category_code,
    m_sub_category_code varchar2(20),
    m_sub_category_name VARCHAR2(200) NOT NULL UNIQUE,
    PRIMARY KEY(m_sub_category_code),
    foreign key(category_code) references ID_categories(category_code)
);
/*소분류 모바일 테이블*/
create table ID_m_sub_sub_category(
    m_sub_sub_category_code varchar2(50),
    m_sub_category_code,
    m_sub_sub_category_name varchar2(50) not null,
    primary key(m_sub_sub_category_code),
    foreign key(m_sub_category_code) references ID_m_sub_category(m_sub_category_code)
);
/*제품 테이블*/
create table ID_m_items(
   category_code,
   m_sub_category_code,
   m_sub_sub_category_code,
   brand_code,
   m_item_code varchar2(20),
   m_item_name varchar2(200) not null,
   m_build_day date,
   energy_grade_code,
   m_power_consum varchar2(20) not null,
   color_code,
   m_item_size_x number(5) default 0,
   m_item_size_y number(5) default 0,
   m_item_size_z number(5) default 0,
   m_discontinued varchar2(10) default 'false',
   m_pic varchar2(200),
   primary key(m_item_code),
   foreign key(m_sub_category_code) references ID_m_sub_category(m_sub_category_code),
   foreign key(category_code) references ID_categories(category_code),
   foreign key(brand_code) references brand(brand_code),
   foreign key(energy_grade_code) references energy_grade(energy_grade_code),
   foreign key(color_code) references color(color_code),
   foreign key(m_sub_sub_category_code) references ID_m_sub_sub_category(m_sub_sub_category_code)
);
/* 입고일 날짜 저장 테이블 */
create table ID_m_input_date (
    m_input_date_no number(5),
    m_item_code,
    m_input_date date not null,
    m_stock_in_cnt number(4) not null,
    primary key(m_input_date_no),
    foreign key(m_item_code) references ID_m_items(m_item_code)
);
/* 출고일 날짜 저장 테이블 */
create table ID_m_output_date (
    m_output_date_no number(5),
    m_item_code,
    m_output_date date not null,
    m_stock_out_cnt number(4) not null,
    primary key(m_output_date_no),
    foreign key(m_item_code) references ID_m_items(m_item_code)
);

drop table ID_m_output_date;
drop table ID_m_input_date;
drop table ID_m_items;
drop table ID_m_sub_sub_category ;
drop table ID_m_sub_category;
drop table ID_categories ;
drop table brand;
drop table color;
drop table energy_grade;


commit
rollback

select * from ID_m_items




-- 중분류 카테고리 insert
insert into ID_m_SUB_CATEGORY (category_code, m_sub_category_code, m_sub_category_name) values(4,1,'휴대폰') ;
insert into ID_m_SUB_CATEGORY (category_code, m_sub_category_code, m_sub_category_name) values(4,2,'태블릿') ;



-- 소분류 카테고리 insert
insert into ID_m_SUB_SUB_CATEGORY (m_sub_category_code, m_sub_sub_category_code, m_sub_sub_category_name) values(1,1,'삼성전자') ;
insert into ID_m_SUB_SUB_CATEGORY (m_sub_category_code, m_sub_sub_category_code, m_sub_sub_category_name) values(1,2,'애플') ;
insert into ID_m_SUB_SUB_CATEGORY (m_sub_category_code, m_sub_sub_category_code, m_sub_sub_category_name) values(1,3,'기타') ;

insert into ID_m_SUB_SUB_CATEGORY (m_sub_category_code, m_sub_sub_category_code, m_sub_sub_category_name) values(2,4,'안드로이드') ;
insert into ID_m_SUB_SUB_CATEGORY (m_sub_category_code, m_sub_sub_category_code, m_sub_sub_category_name) values(2,5,'윈도우') ;
insert into ID_m_SUB_SUB_CATEGORY (m_sub_category_code, m_sub_sub_category_code, m_sub_sub_category_name) values(2,6,'아이패드') ;


select * from ID_m_SUB_CATEGORY

select * from ID_m_SUB_SUB_CATEGORY


commit