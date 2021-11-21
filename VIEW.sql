-- 뷰 생성
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPT;

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP;

SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=30;

CREATE VIEW EMP_VIEW30
AS 
SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=30;

SELECT * 
FROM EMP_VIEW30;

DESC EMP_VIEW30;


CREATE VIEW EMP_VIEW20
AS 
SELECT EMPNO, ENAME, DEPTNO, MGR
FROM EMP_COPY
WHERE DEPTNO=20;

SELECT *
FROM EMP_VIEW20;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;

-- 데이터 삽입
INSERT INTO EMP_VIEW30
VALUES(8000, 'ANGEL', 30);

SELECT * FROM EMP_VIEW30;

SELECT * FROM EMP_COPY;

-- 뷰의 구조 변경
CREATE OR REPLACE
VIEW EMP_VIEW(사원번호, 사원명, 급여, 부서번호)
AS 
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP_COPY;

SELECT * 
FROM EMP_VIEW
WHERE 부서번호=30;

CREATE VIEW VIEW_SAL
AS
SELECT DEPTNO, SUM(SAL) AS "SalSum", AVG(SAL) AS "SalAvg"
FROM EMP_COPY
GROUP BY DEPTNO;

-- 복합뷰
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;

CREATE VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;

SELECT * 
FROM EMP_VIEW_DEPT;


CREATE VIEW SAL_VIEW
AS
SELECT DEPTNO, MAX(SAL) MAX_SAL, MIN(SAL) MIN_SAL
FROM EMP
GROUP BY DEPTNO;

-- 뷰 삭제
DROP VIEW VIEW_SAL;

-- 뷰 생성 옵션
CREATE OR REPLACE VIEW EMP_VIEW30
AS 
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
FROM EMP_COPY
WHERE DEPTNO=30;

CREATE OR REPLACE VIEW EMPLOYEES_VIEW
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMPLOYEES
WHERE DEPTNO=30;

CREATE OR REPLACE FORCE VIEW NOTABLE_VIEW
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMPLOYEES
WHERE DEPTNO=30;

CREATE OR REPLACE NOFORCE VIEW EXISTTABLE_VIEW
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMPLOYEES
WHERE DEPTNO=30;

CREATE OR REPLACE VIEW EMP_VIEW30
AS 
SELECT EMPNO, ENAME, DEPTNO, SAL
FROM EMP_COPY
WHERE DEPTNO=30;

SELECT * FROM EMP_VIEW30;

UPDATE EMP_VIEW30 
SET DEPTNO=20
WHERE SAL >= 1200; 

CREATE OR REPLACE VIEW VIEW_CHK30 
AS 
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
FROM EMP_COPY
WHERE DEPTNO=30 WITH CHECK OPTION;

SELECT * 
FROM VIEW_CHK30;

UPDATE VIEW_CHK30 
SET DEPTNO=20 
WHERE SAL>=1200;

SELECT * 
FROM EMP_COPY;

CREATE OR REPLACE VIEW VIEW_READ30
AS 
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
FROM EMP_COPY
WHERE DEPTNO=30 WITH READ ONLY;

UPDATE VIEW_READ30 
SET COMM=2000;

--PSEUDO COLUMN
SELECT JOB, ENAME, SAL
FROM EMP
WHERE ROWID IN (SELECT MAX(ROWID) FROM EMP GROUP BY JOB);

-- 중복된 데이터 제거
SELECT *
FROM EMP_COPY;

DELETE FROM EMP_COPY a
WHERE ROWID > ANY(SELECT ROWID FROM EMP_COPY b
                        WHERE b.deptno = a.deptno);
                       
SELECT *
FROM EMP_COPY;

-- 인라인 뷰
SELECT * FROM (SELECT * FROM tCity) A;

-- ROWNUM 조회
SELECT ROWNUM, EMPNO, ENAME, HIREDATE
FROM EMP;

-- 데이터 정렬
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
ORDER BY HIREDATE;

-- 정렬과 ROWNUM 조회를 같이 수행 
SELECT ROWNUM, EMPNO, ENAME, HIREDATE
FROM EMP
ORDER BY HIREDATE;

-- TOP-N 조회
CREATE OR REPLACE VIEW VIEW_HIRE
AS
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
ORDER BY HIREDATE;

SELECT ROWNUM, EMPNO, ENAME, HIREDATE
FROM VIEW_HIRE;

SELECT ROWNUM, EMPNO, ENAME, HIREDATE
FROM VIEW_HIRE
WHERE ROWNUM<=5;

-- 인라인 뷰를 이용해서 해결
SELECT EMPNO, ENAME, HIREDATE
FROM ( SELECT ROWNUM RNUM, EMPNO, ENAME, HIREDATE
FROM (SELECT EMPNO, ENAME, HIREDATE FROM EMP
ORDER BY HIREDATE))
WHERE RNUM <=5;

-- OFFSET ~ FETCH를 이용한 해결
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
ORDER BY HIREDATE  OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

====================================================

CREATE OR REPLACE VIEW EMP_VIEW
AS 
SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP;

SELECT *
FROM EMP_VIEW
WHERE DEPTNO = 10;

CREATE OR REPLACE VIEW SAL_TOP3_VIEW
AS 
SELECT RNUM RANKING, EMPNO, ENAME, SAL
FROM (SELECT ROWNUM RNUM, EMPNO, ENAME, SAL FROM(SELECT EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC, ENAME DESC))
WHERE RNUM <= 3;

SELECT *
FROM SAL_TOP3_VIEW;

-- 임시 테이블
CREATE GLOBAL TEMPORARY TABLE TGTT( 
	NAME VARCHAR(20) PRIMARY KEY, 
	SCORE INT
);

-- 임시 테이블에 데이터 삽입
INSERT INTO TGTT VALUES ('asepa', 95);
INSERT INTO TGTT VALUES ('redvelvet', 90);
INSERT INTO TGTT VALUES ('girlsgeneration', 93);

-- manual commit 모드이면 데이터가 조회됨
-- auto commit 모드이면 데이터가 조회되지 않음
SELECT * 
FROM TGTT;

-- commit
COMMIT;

-- 데이터가 조회되지 않음
SELECT * 
FROM TGTT;


-- 세션이 유지되는 동안 데이터를 유지하는임시 테이블 생성
DROP TABLE TGTT;

CREATE GLOBAL TEMPORARY TABLE TGTT (
NAME VARCHAR(20) PRIMARY KEY,
SCORE INT
) ON COMMIT PRESERVE ROWS;


-- 임시 테이블에 데이터 삽입
INSERT INTO TGTT VALUES ('asepa', 95);
INSERT INTO TGTT VALUES ('redvelvet', 90);
INSERT INTO TGTT VALUES ('girlsgeneration', 93);

-- commit
COMMIT;

-- 데이터가 조회됨
SELECT * 
FROM TGTT;


-- 순차적 처리
-- 임시 테이블 생성
CREATE GLOBAL TEMPORARY TABLE TASKFORCE 
AS SELECT * FROM TSTAFF;

SELECT *
FROM TASKFORCE;

-- 2016년 이전 입사자 중 월급 상위 10명 선발
INSERT INTO TASKFORCE SELECT * FROM (SELECT * FROM TSTAFF
WHERE JOINDATE <= '20160101' ORDER BY SALARY DESC) WHERE ROWNUM <= 10;

SELECT *
FROM TASKFORCE;

-- 선발된 남직원의 평균 성취도보다 낮은 남직원은 제외
DELETE FROM TASKFORCE 
WHERE SCORE < (SELECT AVG(SCORE) FROM TASKFORCE WHERE GENDER = '남') AND GENDER = '남';

SELECT *
FROM TASKFORCE;

-- 전체 직원의 평균 월급보다 낮은 여직원은 제외
DELETE FROM TASKFORCE 
WHERE SALARY < (SELECT AVG(SALARY) FROM TSTAFF) AND GENDER = '여';

SELECT *
FROM TASKFORCE;

-- 월급 300 넘으면서 아직도 대리인 직원 제외
DELETE FROM TASKFORCE 
WHERE SALARY > 300 AND GRADE = '대리';

SELECT *
FROM TASKFORCE;

-- 월급 380 넘으면서 과장인 직원은 경험이 풍부하므로 포함
INSERT INTO TASKFORCE 
SELECT * 
FROM TSTAFF 
WHERE SALARY > 380 AND GRADE = '과장';

SELECT *
FROM TASKFORCE;

-- 결과셋 재활용
-- 영업부 남자직원 조회
SELECT NAME, SALARY, SCORE 
FROM TSTAFF 
WHERE DEPART = '영업부' AND GENDER = '남';

-- 영업부 남자직원 중 평균 월급 이상인 직원을 조회
SELECT * FROM (
SELECT NAME, SALARY, SCORE
FROM TSTAFF WHERE DEPART = '영업부' AND GENDER = '남') A
WHERE SALARY >= (
SELECT AVG(SALARY) FROM (
SELECT NAME, SALARY, SCORE FROM TSTAFF WHERE DEPART = '영업부' AND GENDER = '남') B);

-- 임시 테이블로 해결
CREATE GLOBAL TEMPORARY TABLE TEMP AS SELECT NAME, SALARY, SCORE FROM TSTAFF WHERE 1=0; 

INSERT INTO TEMP 
SELECT NAME, SALARY, SCORE FROM TSTAFF WHERE DEPART = '영업부' AND GENDER = '남';

SELECT *
FROM TEMP;

SELECT *
FROM TEMP
WHERE SALARY >= (SELECT AVG(SALARY) FROM TEMP);

-- CTE 를 이용한 해결
WITH TEMP AS
(SELECT NAME, SALARY, SCORE FROM TSTAFF WHERE DEPART = '영업부' AND GENDER = '남') 
SELECT * FROM TEMP WHERE SALARY >= (SELECT AVG(SALARY) FROM TEMP);

WITH TEMP(이름, 월급, 성취도) AS
(SELECT NAME, SALARY, SCORE FROM TSTAFF WHERE DEPART = '영업부' AND GENDER = '남') 
SELECT * FROM TEMP WHERE 월급 >= (SELECT AVG(월급) FROM TEMP);


-- 두 개 이상의 CTE 테이블 사용 
WITH MAN AS
(SELECT NAME, SALARY, SCORE FROM TSTAFF WHERE DEPART = '영업부' AND GENDER = '남'), 
WOMAN AS
(SELECT NAME, SALARY, SCORE FROM TSTAFF WHERE DEPART = '영업부' AND GENDER = '여') 
SELECT * FROM WOMAN WHERE SALARY >= (SELECT avg(SALARY) FROM MAN);

-- CTE를 활용하는 CTE
WITH MAN AS
(SELECT NAME, SALARY, SCORE FROM TSTAFF WHERE DEPART = '영업부' AND GENDER = '남'),  
GOODMAN AS
(SELECT NAME, SALARY, SCORE FROM MAN WHERE SCORE > 70)
SELECT * 
FROM GOODMAN;


-- 복잡한 구문을 CTE로 간결하게 사용
WITH SHOPPING AS
(SELECT M.MEMBER, M.ADDR, O.ITEM, O.NUM, O.ORDERDATE FROM TMEMBER M INNER JOIN TORDER O ON M.MEMBER = O.MEMBER)
SELECT * 
FROM SHOPPING 
WHERE NUM >= (SELECT AVG(NUM) FROM SHOPPING);

-- 위의 내용을 뷰로 생성
CREATE VIEW VTEMP AS
(SELECT M.MEMBER, M.ADDR, O.ITEM, O.NUM, O.ORDERDATE FROM TMEMBER M INNER JOIN TORDER O ON M.MEMBER = O.MEMBER);

SELECT * 
FROM VTEMP 
WHERE NUM >= (SELECT AVG(NUM) FROM VTEMP);

-- 팩토리얼
WITH TFACT(num, sum) AS (
SELECT 1 AS num, 1 AS sum FROM DUAL
UNION ALL
SELECT num + 1, sum * (num + 1) FROM TFACT T WHERE T.num < 10)
SELECT * FROM TFACT;