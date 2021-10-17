
/*중분류 TV 테이블*/
create table ID_t_sub_category(
    category_code,
    t_sub_category_code varchar2(20),
    t_sub_category_name VARCHAR2(200) NOT NULL UNIQUE,
    PRIMARY KEY(t_sub_category_code),
    foreign key(category_code) references ID_categories(category_code)
);
/*소분류 TV 테이블*/
create table ID_t_sub_sub_category(
    t_sub_sub_category_code varchar2(50),
    t_sub_category_code,
    t_sub_sub_category_name varchar2(50) not null,
    primary key(t_sub_sub_category_code),
    foreign key(t_sub_category_code) references ID_t_sub_category(t_sub_category_code)
);
/*제품 테이블*/
create table ID_t_items(
   category_code,
   t_sub_category_code,
   t_sub_sub_category_code,
   brand_code,
   t_item_code varchar2(20),
   t_item_name varchar2(200) not null,
   t_build_day date,
   energy_grade_code,
   t_power_consum varchar2(20) not null,
   color_code,
   t_item_size_x number(5) default 0,
   t_item_size_y number(5) default 0,
   t_item_size_z number(5) default 0,
   t_discontinued varchar2(10) default 'false',
   t_pic varchar2(200),
   primary key(t_item_code),
   foreign key(t_sub_category_code) references ID_t_sub_category(t_sub_category_code),
   foreign key(category_code) references ID_categories(category_code),
   foreign key(brand_code) references brand(brand_code),
   foreign key(energy_grade_code) references energy_grade(energy_grade_code),
   foreign key(color_code) references color(color_code),
   foreign key(t_sub_sub_category_code) references ID_t_sub_sub_category(t_sub_sub_category_code)
);
/* 입고일 날짜 저장 테이블 */
create table ID_t_input_date (
    t_input_date_no number(5),
    t_item_code,
    t_input_date date not null,
    t_stock_in_cnt number(4) not null,
    primary key(t_input_date_no),
    foreign key(t_item_code) references ID_t_items(t_item_code)
);
/* 출고일 날짜 저장 테이블 */
create table ID_t_output_date (
    t_output_date_no number(5),
    t_item_code,
    t_output_date date not null,
    t_stock_out_cnt number(4) not null,
    primary key(t_output_date_no),
    foreign key(t_item_code) references ID_t_items(t_item_code)
);

drop table ID_t_output_date;
drop table ID_t_input_date;
drop table ID_t_items;
drop table ID_t_sub_sub_category ;
drop table ID_t_sub_category;
drop table ID_categories ;
drop table brand;
drop table color;
drop table energy_grade;


commit
rollback

select * from ID_t_items



-- 중분류 카테고리 insert
insert into ID_t_SUB_CATEGORY (category_code, t_sub_category_code, t_sub_category_name) values(2,1,'TV') ;


-- 소분류 카테고리 insert
insert into ID_t_SUB_SUB_CATEGORY (t_sub_category_code, t_sub_sub_category_code, t_sub_sub_category_name) values(1,1,'QLED') ;
insert into ID_t_SUB_SUB_CATEGORY (t_sub_category_code, t_sub_sub_category_code, t_sub_sub_category_name) values(1,2,'mini LED') ;
insert into ID_t_SUB_SUB_CATEGORY (t_sub_category_code, t_sub_sub_category_code, t_sub_sub_category_name) values(1,3,'OLED') ;




select * from ID_t_SUB_CATEGORY

select * from ID_t_SUB_SUB_CATEGORY

commit