
/*색상 테이블*/
create table color(
color_code varchar2(20),
color_name varchar2(200) not null unique,
primary key(color_code)
);
/*에너지소비등급 테이블*/
create table energy_grade(
energy_grade_code varchar2(20),
energy_grade_name varchar2(200) not null unique,
primary key(energy_grade_code)
);
/*브랜드 테이블*/
create table brand(
brand_code varchar2(20),
brand_name varchar2(200) not null unique,
primary key(brand_code)
);
/* 가전/TV/모바일/PC */
create table BO_ID_categories(
    category_code varchar2(20),
    category_name varchar2(200) not null,
    primary key(category_code)
);
/*가전 대분류 테이블*/
create table BO_ID_g_sub_category(
    category_code,
    g_sub_category_code varchar2(20),
    g_sub_category_name VARCHAR2(200) NOT NULL UNIQUE,
    PRIMARY KEY(g_sub_category_code),
    foreign key(category_code) references BO_ID_categories(category_code)
);
/*제품종류*/
create table BO_ID_g_sub_sub_category(
    g_sub_sub_category_code varchar2(50),
    g_sub_category_code,
    g_sub_sub_category_name varchar2(50) not null,
    primary key(g_sub_sub_category_code),
    foreign key(g_sub_category_code) references BO_ID_g_sub_category(g_sub_category_code)
);
/*제품 테이블*/
create table BO_ID_g_items(
   pic varchar2(200),
   g_sub_category_code,
   g_sub_sub_category_code,
   category_code,
   brand_code,
   g_item_code varchar2(20),
   g_item_name varchar2(200) not null,
   build_day date,
   energy_grade_code,
   power_consum varchar2(20) not null,
   color_code,
   g_item_size_x number(5) default 0,
   g_item_size_y number(5) default 0,
   g_item_size_z number(5) default 0,
   discontinued varchar2(10) default 'false',
   primary key(g_item_code),
   foreign key(g_sub_category_code) references BO_ID_g_sub_category(g_sub_category_code),
   foreign key(category_code) references BO_ID_categories(category_code),
   foreign key(brand_code) references brand(brand_code),
   foreign key(energy_grade_code) references energy_grade(energy_grade_code),
   foreign key(color_code) references color(color_code),
   foreign key(g_sub_sub_category_code) references BO_ID_g_sub_sub_category(g_sub_sub_category_code)
);
/* 입고일 날짜 저장 테이블 */
create table BO_ID_input_date (
    input_date_no number(5),
    g_item_code,
    input_date date not null,
    stock_in_cnt number(4) not null,
    primary key(input_date_no),
    foreign key(g_item_code) references BO_ID_g_items(g_item_code)
);
/* 출고일 날짜 저장 테이블 */
create table BO_ID_output_date (
    output_date_no number(5),
    g_item_code,
    output_date date not null,
    stock_out_cnt number(4) not null,
    primary key(output_date_no),
    foreign key(g_item_code) references BO_ID_g_items(g_item_code)
);

drop table BO_ID_output_date;
drop table BO_ID_input_date;
drop table BO_ID_g_items;
drop table BO_ID_g_sub_sub_category ;
drop table BO_ID_g_sub_category;
drop table BO_ID_categories ;
drop table brand;
drop table color;
drop table energy_grade;


commit
rollback

select * from BO_ID_g_items

DROP TABLE BRAND
DROP TABLE COLOR
DROP TABLE GAJUN
DROP TABLE GAJUN_BIGCATEGORIES

DROP TABLE GAJUN_ITEMS

DROP TABLE GAJUN_SMALLCATEGORIES
DROP TABLE MEPS

-- ==========================================================
-- INSERT 시작.

-- 대분류 카테고리 insert -----------
insert into BO_ID_CATEGORIES (category_code, category_name) values(1,'가전') ;
insert into BO_ID_CATEGORIES (category_code, category_name) values(2,'TV')   ;
insert into BO_ID_CATEGORIES (category_code, category_name) values(3,'PC')   ;
insert into BO_ID_CATEGORIES (category_code, category_name) values(4,'모바일');

select * from bo_id_categories

commit

-- 중분류 카테고리 insert
insert into BO_ID_G_SUB_CATEGORY (category_code, g_sub_category_code, g_sub_category_name) values(1,1,'계절가전') ;
insert into BO_ID_G_SUB_CATEGORY (category_code, g_sub_category_code, g_sub_category_name) values(1,2,'주방가전') ;
insert into BO_ID_G_SUB_CATEGORY (category_code, g_sub_category_code, g_sub_category_name) values(1,3,'생활가전') ;

select * from BO_ID_G_SUB_CATEGORY

commit

-- 소분류 카테고리 insert
insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(1,1,'에어컨') ;
insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(1,2,'공기청정') ;
insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(1,3,'난방기기') ;

insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(2,4,'냉장고') ;
insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(2,5,'전기밥솥') ;
insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(2,6,'에어프라이어') ;

insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(3,7,'세탁기') ;
insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(3,8,'건조기') ;
insert into BO_ID_G_SUB_SUB_CATEGORY (g_sub_category_code, g_sub_sub_category_code, g_sub_sub_category_name) values(3,9,'청소기') ;

select * from BO_ID_G_SUB_SUB_CATEGORY

commit

-- 에너지 효율등급 insert

insert into energy_grade (energy_grade_code, energy_grade_name) values(1,'1등급') ;
insert into energy_grade (energy_grade_code, energy_grade_name) values(2,'2등급') ;
insert into energy_grade (energy_grade_code, energy_grade_name) values(3,'3등급') ;
insert into energy_grade (energy_grade_code, energy_grade_name) values(4,'4등급') ;
insert into energy_grade (energy_grade_code, energy_grade_name) values(5,'5등급') ;

select * from energy_grade

commit

-- 브랜드 insert

insert into brand (brand_code, brand_name) values(1,'삼성전자');
insert into brand (brand_code, brand_name) values(2,'LG전자');
insert into brand (brand_code, brand_name) values(3,'캐리어');
insert into brand (brand_code, brand_name) values(4,'위니아딤채');
insert into brand (brand_code, brand_name) values(5,'파세코');
insert into brand (brand_code, brand_name) values(6,'위닉스');
insert into brand (brand_code, brand_name) values(7,'홍진테크');
insert into brand (brand_code, brand_name) values(8,'유니맥스');
insert into brand (brand_code, brand_name) values(9,'신일전자');
insert into brand (brand_code, brand_name) values(10,'샤오미');
insert into brand (brand_code, brand_name) values(11,'캐로스');
insert into brand (brand_code, brand_name) values(12,'한일전기');
insert into brand (brand_code, brand_name) values(13,'롯데하이마트');
insert into brand (brand_code, brand_name) values(14,'스타리온');
insert into brand (brand_code, brand_name) values(15,'쿠쿠');
insert into brand (brand_code, brand_name) values(16,'쿠첸');
insert into brand (brand_code, brand_name) values(17,'PN풍년');
insert into brand (brand_code, brand_name) values(18,'락앤락');
insert into brand (brand_code, brand_name) values(19,'422');
insert into brand (brand_code, brand_name) values(20,'이마트');
insert into brand (brand_code, brand_name) values(21,'오쿠');
insert into brand (brand_code, brand_name) values(22,'보토');
insert into brand (brand_code, brand_name) values(23,'에어메이드');
insert into brand (brand_code, brand_name) values(24,'리빙센스');
insert into brand (brand_code, brand_name) values(25,'재원전자');
insert into brand (brand_code, brand_name) values(26,'노와');
insert into brand (brand_code, brand_name) values(27,'리빙코리아');
insert into brand (brand_code, brand_name) values(28,'자일렉');
insert into brand (brand_code, brand_name) values(29,'키친아트');
insert into brand (brand_code, brand_name) values(30,'중산물산');

insert into brand (brand_code, brand_name) values(31,'위니아전자');
insert into brand (brand_code, brand_name) values(32,'미디어');
insert into brand (brand_code, brand_name) values(33,'다이슨');

select * from brand

commit

--계절가전 - 에어컨
삼성전자
LG전자
캐리어
위니아딤채
파세코

-- 계절가전 - 공기청정
LG전자
삼성전자
위닉스
위니아딤채

--계절가전 - 난방기기
홍진테크
유니맥스
신일전자
샤오미
캐로스
한일전기

--주방가전 - 냉장고
LG전자
삼성전자
캐리어
위니아딤채
롯데하이마트
스타리온

--주방가전 - 전기밥솥
쿠쿠
쿠첸
PN풍년
위니아딤채

--주방가전 - 에어프라이어
락앤락
422
이마트
쿠쿠
오쿠
보토
에어메이드
리빙센스
재원전자
노와
리빙코리아
자일렉
키친아트
중산물산

-- 생활가전 - 세탁기
미디어
-- 생활가전 - 건조기
위니아전자
-- 생활가전 - 청소기
다이슨



-- 컬러 insert

insert into color (color_code, color_name) values(1,'에어리화이트');
insert into color (color_code, color_name) values(2,'new NFD Gray');
insert into color (color_code, color_name) values(3,'화이트');
insert into color (color_code, color_name) values(4,'메탈화이트');
insert into color (color_code, color_name) values(5,'브라운 캔버스우드');
insert into color (color_code, color_name) values(6,'Serene Green');
insert into color (color_code, color_name) values(7,'웨딩스노우');
insert into color (color_code, color_name) values(8,'로맨틱로즈');
insert into color (color_code, color_name) values(9,'카밍베이지');
insert into color (color_code, color_name) values(10,'카밍그린');
insert into color (color_code, color_name) values(11,'클린화이트');
insert into color (color_code, color_name) values(12,'크리미스노우');
insert into color (color_code, color_name) values(13,'아이언그레이');
insert into color (color_code, color_name) values(14,'밀크티라떼');
insert into color (color_code, color_name) values(15,'뉴메탈샤인');
insert into color (color_code, color_name) values(16,'네이처그린');
insert into color (color_code, color_name) values(17,'실버');
insert into color (color_code, color_name) values(18,'그레이');
insert into color (color_code, color_name) values(19,'베이지');
insert into color (color_code, color_name) values(20,'민트그린');
insert into color (color_code, color_name) values(21,'몰타그린');
insert into color (color_code, color_name) values(22,'소프트 베이지');
insert into color (color_code, color_name) values(23,'퓨어 화이트');
insert into color (color_code, color_name) values(24,'레드');
insert into color (color_code, color_name) values(25,'바이메탈');
insert into color (color_code, color_name) values(26,'화이트블랙');


select * from color

commit

delete from color where color_code = 4
drop table color

-- 계절가전 - 에어컨
에어리화이트
new NFD Gray
화이트
메탈화이트
브라운 캔버스우드
Serene Green
웨딩스노우
로맨틱로즈
카밍베이지
카밍그린
클린화이트

-- 계절가전 -공기청정기
크리미스노우
아이언그레이
밀크티라떼
뉴메탈샤인
네이처그린
실버
그레이
베이지

민트그린
몰타그린
소프트 베이지
퓨어 화이트

-- 계절가전 - 난방기기
레드
바이메탈
화이트블랙






