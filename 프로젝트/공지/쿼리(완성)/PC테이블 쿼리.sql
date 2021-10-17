
/*중분류 PC 테이블*/
create table ID_p_sub_category(
    category_code,
    p_sub_category_code varchar2(20),
    p_sub_category_name VARCHAR2(200) NOT NULL UNIQUE,
    PRIMARY KEY(p_sub_category_code),
    foreign key(category_code) references ID_categories(category_code)
);
/*소분류 PC 테이블*/
create table ID_p_sub_sub_category(
    p_sub_sub_category_code varchar2(50),
    p_sub_category_code,
    p_sub_sub_category_name varchar2(50) not null,
    primary key(p_sub_sub_category_code),
    foreign key(p_sub_category_code) references ID_p_sub_category(p_sub_category_code)
);
/*제품 테이블*/
create table ID_p_items(
   category_code,
   p_sub_category_code,
   p_sub_sub_category_code,
   brand_code,
   p_item_code varchar2(20),
   p_item_name varchar2(200) not null,
   p_build_day date,
   energy_grade_code,
   p_power_consum varchar2(20) not null,
   color_code,
   p_item_size_x number(5) default 0,
   p_item_size_y number(5) default 0,
   p_item_size_z number(5) default 0,
   p_discontinued varchar2(10) default 'false',
   p_pic varchar2(200),
   primary key(p_item_code),
   foreign key(p_sub_category_code) references ID_p_sub_category(p_sub_category_code),
   foreign key(category_code) references ID_categories(category_code),
   foreign key(brand_code) references brand(brand_code),
   foreign key(energy_grade_code) references energy_grade(energy_grade_code),
   foreign key(color_code) references color(color_code),
   foreign key(p_sub_sub_category_code) references ID_p_sub_sub_category(p_sub_sub_category_code)
);
/* 입고일 날짜 저장 테이블 */
create table ID_p_input_date (
    p_input_date_no number(5),
    p_item_code,
    p_input_date date not null,
    p_stock_in_cnt number(4) not null,
    primary key(p_input_date_no),
    foreign key(p_item_code) references ID_p_items(p_item_code)
);
/* 출고일 날짜 저장 테이블 */
create table ID_p_output_date (
    p_output_date_no number(5),
    p_item_code,
    p_output_date date not null,
    p_stock_out_cnt number(4) not null,
    primary key(p_output_date_no),
    foreign key(p_item_code) references ID_p_items(p_item_code)
);

drop table ID_p_output_date;
drop table ID_p_input_date;
drop table ID_p_items;
drop table ID_p_sub_sub_category ;
drop table ID_p_sub_category;
drop table ID_categories ;
drop table brand;
drop table color;
drop table energy_grade;


commit
rollback

select * from ID_p_items




-- 중분류 카테고리 insert
insert into ID_p_SUB_CATEGORY (category_code, p_sub_category_code, p_sub_category_name) values(3,1,'데스크탑') ;
insert into ID_p_SUB_CATEGORY (category_code, p_sub_category_code, p_sub_category_name) values(3,2,'노트북') ;



-- 소분류 카테고리 insert
insert into ID_p_SUB_SUB_CATEGORY (p_sub_category_code, p_sub_sub_category_code, p_sub_sub_category_name) values(1,1,'사무용/인강용') ;
insert into ID_p_SUB_SUB_CATEGORY (p_sub_category_code, p_sub_sub_category_code, p_sub_sub_category_name) values(1,2,'게이밍') ;


insert into ID_p_SUB_SUB_CATEGORY (p_sub_category_code, p_sub_sub_category_code, p_sub_sub_category_name) values(2,3,'비지니스') ;
insert into ID_p_SUB_SUB_CATEGORY (p_sub_category_code, p_sub_sub_category_code, p_sub_sub_category_name) values(2,4,'게이밍') ;



select * from ID_p_SUB_CATEGORY

select * from ID_p_SUB_SUB_CATEGORY


commit