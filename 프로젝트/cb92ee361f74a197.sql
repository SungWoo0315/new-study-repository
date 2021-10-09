/*가전 소분류 테이블*/
CREATE TABLE gajun_smallCategories(
    small_categori_code varchar2(20),
    small_categori_name VARCHAR2(20) NOT NULL UNIQUE,
    PRIMARY KEY(small_categori_code)
);
/*가전 대분류 테이블*/
create table gajun_bigCategories(
    big_categori_code varchar2(20),
    big_categori_name VARCHAR2(20) NOT NULL UNIQUE,
    small_categori1,
    small_categori2,
    small_categori3,
    PRIMARY KEY(big_categori_code),
    foreign key(small_categori1) references gajun_smallCategories(small_categori_code),
    foreign key(small_categori2) references gajun_smallCategories(small_categori_code),
    foreign key(small_categori3) references gajun_smallCategories(small_categori_code)
)
/* 가전 테이블(품목) */
create table gajun(
    gajun_code varchar2(20),
    gajun_big_categori_code,
    primary key(gajun_code),
    foreign key(gajun_big_categori_code) references gajun_bigCategories(big_categori_code)
)
/*색상 테이블*/
create table color(
color_code varchar2(20),
color_name varchar2(20) not null unique,
primary key(color_code)
);
/*에너지소비등급 테이블*/
create table MEPS(
MEPS_code varchar2(20),
MEPS_rating varchar2(20) not null unique,
primary key(MEPS_code)
);
/*브랜드 테이블*/
create table brand(
brand_code varchar2(20),
brand_name varchar2(20) not null unique,
primary key(brand_code)
);
/*제품 테이블*/
create table gajun_items(
   big_categori_code,
   small_categori_code,
   brand_code,
   item_code varchar2(20),
   item_name varchar2(20) not null,
   input_day date default sysdate,
   output_day date,
   build_day date,
   MEPS_code,
   power_consum varchar2(20) not null,
   color_code,
   stock number(4) default 0,
   whatsize varchar(2),
   discontinued varchar2(10) default 'false',
   primary key(item_code),
   foreign key(small_categori_code) references gajun_smallCategories(small_categori_code),
   foreign key(brand_code) references brand(brand_code),
   foreign key(MEPS_code) references MEPS(MEPS_code),
   foreign key(color_code) references color(color_code),
   foreign key(big_categori_code) references gajun_bigCategories(big_categori_code)
);
commit
rollback
drop table      gajun
drop table gajun_bigCategories
drop table gajun_smallCategories
drop table gajun_items

