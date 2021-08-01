---------------------------- 数据类型 ---------------------------- CREATE type mood AS enum ( 'sad', 'ok', 'happy' );
SELECT
	* 
FROM
	mood;
CREATE type WEEK AS enum ( 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' );
CREATE TABLE person ( NAME text, current_mood mood );
INSERT INTO person
VALUES
	( 'hzc', 'sad' );
SELECT
	* 
FROM
	person;
UPDATE person 
SET current_mood = 'ok' 
WHERE
	NAME = 'hzc';
CREATE TABLE sal_emp ( NAME text, pay_by_quarter INTEGER [], SCHEDULE text [][] );
CREATE TABLE sal_emp2 ( NAME text, pay_by_quarter INTEGER array [ 4 ], SCHEDULE text [][] );
INSERT INTO sal_emp
VALUES
	( 'Bill', '{10000, 10000, 10000, 10000}', '{{"meeting", "lunch"}, {"training", "presentation"}}' );
INSERT INTO sal_emp
VALUES
	( 'Carol', '{20000, 25000, 25000, 25000}', '{{"breakfast", "consulting"}, {"meeting", "lunch"}}' );
SELECT
	* 
FROM
	sal_emp;
SELECT NAME 
FROM
	sal_emp 
WHERE
	pay_by_quarter [ 1 ] <> pay_by_quarter [ 2 ];
UPDATE sal_emp 
SET pay_by_quarter = '{25000,25000,27000,27000}' 
WHERE
	NAME = 'Carol';
SELECT
	* 
FROM
	sal_emp 
WHERE
	10000 = ALL ( pay_by_quarter );
SELECT
	* 
FROM
	( SELECT pay_by_quarter, generate_subscripts ( pay_by_quarter, 1 ) AS s FROM sal_emp ) AS foo 
WHERE
	pay_by_quarter [ 3 ] = 10000;
CREATE type complex AS ( r DOUBLE PRECISION, i DOUBLE PRECISION );
CREATE type inventory_item AS ( NAME text, supplier_id INTEGER, price NUMERIC );
CREATE TABLE on_hand ( item inventory_item, count INTEGER );
INSERT INTO on_hand
VALUES
	( '("test", 1, 1.99)', 1 );
INSERT INTO on_hand
VALUES
	( '("test2", 2, 1.09)', 2 );
SELECT
	* 
FROM
	on_hand;
SELECT
	( item ).NAME 
FROM
	on_hand 
WHERE
	( item ).price > 1.88;
SELECT
	( on_hand.item ).NAME 
FROM
	on_hand 
WHERE
	( on_hand.item ).price > 1.88;
CREATE TABLE reservation ( room INT, during tsrange );
INSERT INTO reservation
VALUES
	( 1, '[2021-07-01 14:30, 2021-08-30 15:30]' );
SELECT
	* 
FROM
	reservation;
	
-- 包含
SELECT
	int4range ( 10, 20 ) @> 3;
	
-- 重叠
SELECT
	numrange ( 11.1, 22.2 ) && numrange ( 20.0, 30.0 );

-- 提取上边界
SELECT
	upper(
	int8range ( 15, 25 ));

-- 计算交叉
SELECT
	lower(
	int8range ( 15, 25 ));

-- 范围是否为空
SELECT
	int4range ( 10, 20 ) * int4range ( 15, 25 );

-- 范围是否为空
SELECT
	isempty (
	numrange ( 1, 5 ));
	
-- 包括3，不包括7，并且包括二者之间的所有点
SELECT
	'[3,7)' :: int4range;
	
-- 只包括单一值4
SELECT
	'[4,4]' :: int4range;
	
-- 不包括点（被标准化为‘空’
SELECT '[4,4)':: int4range;


---------------------------- 创建数据库 ---------------------------- 
CREATE DATABASE dbname;


---------------------------- 删除数据库 ---------------------------- 
DROP DATABASE IF EXISTS dbname;


