-- EMP 테이블의 모든 데이터 조회
SELECT * 
FROM EMP;

--EMP Table에서 EMPNO, ENAME, SAL, JOB 를 조회
SELECT EMPNO, ENAME, SAL, JOB
FROM EMP;

--EMP 테이블의 SAL을 300증가 시키기 위해 덧셈 연산자를 사용하고 ENAME, SAL, SAL+300을 조회
SELECT ENAME, SAL, SAL+300
FROM EMP;

-- EMP 테이블에서 EMPNO, ENAME, SAL, COMM, SAL+COMM/100을 조회
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM/100
FROM EMP;

-- EMP 테이블에서 ENAME, SAL, COMM, SAL*12+COMM을 조회(단 COMM이 NULL 이면 0로 계산)
SELECT ENAME, SAL, COMM, SAL * 12 + NVL(COMM,0)
FROM EMP;

--EMP 테이블에서 ENAME를 이름으로 SAL을 급여로 해서 2개 Column의 모든 데이터를 조회 
SELECT ENAME AS 이름, SAL 급여
FROM EMP;

--EMP 테이블에서 ENAME과 JOB을 묶어서 employees로 조회
SELECT ENAME || ' ' || JOB AS "EMPLOYEES"
FROM EMP;

--EMP 테이블에서 ENAME과 JOB을 “KING is a PRESIDENT” 형식으로 조회
SELECT ENAME || ' ' || 'IS A' || ' ' || JOB AS "EMPLOYEES DETAILS"
FROM EMP;

--EMP 테이블에서 ENAME과 SAL을 “KING: 1 Year salary = 60000” 형식으로 조회
SELECT ENAME || ': 1 YEAR SALARY = ' || SAL * 12 MONTHLY
FROM EMP;

--EMP 테이블에서 JOB을 모두 조회
SELECT JOB 
FROM EMP;

-- EMP 테이블에서 JOB을 중복을 제거하고 조회
SELECT DISTINCT JOB 
FROM EMP;

SELECT DISTINCT DEPTNO,JOB
FROM EMP;

SELECT ENAME 이름,JOB 업무,SAL 급여
FROM EMP;


---------------------------------------------------------
참

SELECT *
FROM SALGRADE;

참

SELECT EMPNO,ENAME,SAL * 12 AS "년 봉"
FROM EMP;

SELECT DISTINCT DEPTNO 
FROM DEPT;

SELECT * 
FROM EMP;

SELECT DISTINCT DEPTNO
FROM EMP;

SELECT ENAME || JOB
FROM EMP;

================================================

--EMP 테이블에서 HIREDATE의 오름차순으로 HIREDATE, EMPNO, ENAME, JOB, SAL, DEPTNO 조회 
SELECT HIREDATE, EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
ORDER BY HIREDATE;

--EMP 테이블에서 HIREDATE의 내림차순으로 HIREDATE, EMPNO, ENAME, JOB, SAL, DEPTNO 조회 
SELECT HIREDATE, EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
ORDER BY HIREDATE DESC;

-- 다양한 정렬 방법
SELECT EMPNO, ENAME, JOB, SAL, SAL*12 ANNSAL
FROM EMP
ORDER BY ANNSAL;

SELECT EMPNO, ENAME, JOB, SAL, SAL*12 ANNSAL
FROM EMP
ORDER BY SAL*12;

SELECT EMPNO, ENAME, JOB, SAL, SAL*12 ANNSAL
FROM EMP
ORDER BY 5;

-- EMP 테이블에서 DEPTNO의 오름차순으로 정렬하고 같은 경우 SAL의 내림차순으로 DEPTNO, SAL, EMPNO, ENAME, JOB 조회 
SELECT DEPTNO, SAL, EMPNO, ENAME, JOB
FROM EMP
ORDER BY DEPTNO, SAL DESC;

--EMP 테이블에서 DEPTNO의 오름차순으로 정렬하고 같은 경우 JOB의 오름차순으로 JOB이 같은 경우에는 SAL의 내림차순으로 DEPTNO, JOB, SAL, EMPNO, ENAME, HIREDATE 조회 
SELECT DEPTNO, JOB, SAL, EMPNO, ENAME, HIREDATE
FROM EMP
ORDER BY DEPTNO, JOB, SAL DESC;

-- 인덱스의 내림차순 정렬
SELECT  /*+ INDEX_DESC(EMP) */  EMPNO, ENAME, SAL
FROM EMP;

=====================================================
-- EMP 테이블에서 SAL이 3000 이상인 사원의 EMPNO, ENAME, JOB, SAL을 조회
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL >= 3000;

-- EMP 테이블에서 JOB이 MANAGER 인 사원의 EMPNO, ENAME, JOB, SAL, DEPTNO을 조회
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE JOB = 'MANAGER';

-- EMP 테이블에서 HIREDATE가 1982년 01월 01일 이후 인 사원의 EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO 을 조회
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE HIREDATE >= TO_DATE('1982/01/01', 'YYYY/MM/DD')

-- EMP 테이블에서 SAL이 1300에서 1500 인 사원의 ENAME, JOB, SAL, DEPTNO 을 조회
SELECT ENAME,JOB,SAL,DEPTNO
FROM EMP
WHERE SAL BETWEEN 1300 AND 1500;

-- EMP 테이블에서 EMPNO가 7902,7788,7566인 사원의 EMPNO, ENAME, JOB, SAL, HIREDATE를 조회
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM EMP
WHERE EMPNO IN (7902,7788,7566);

-- EMP 테이블에서 HIREDATE가 1982년인 사원의 EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO 를 조회
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE HIREDATE >= TO_DATE('1982/01/01', 'YYYY/MM/DD') AND
HIREDATE <= TO_DATE('1982/12/31', 'YYYY/MM/DD');

-- EMP 테이블에서 HIREDATE가 1982년인 사원의 EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO 를 조회
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE HIREDATE LIKE '82%';

-- EMP 테이블에서 HIREDATE가 12월인 사원의 EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO 를 조회
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE HIREDATE LIKE '___12%';

-- EMP 테이블에서 COMM 이 NULL사원의 EMPNO, ENAME, JOB, SAL, COMM, DEPTNO를 조회
SELECT EMPNO, ENAME, JOB, SAL, COMM, DEPTNO
FROM EMP
WHERE COMM IS NULL;

-- EMP 테이블에서 SAL이 2800이상이고 JOB이 MANAGER 인 사원의 EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO를 조회
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE SAL >= 2800 AND JOB = 'MANAGER';

SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE JOB = 'MANAGER' AND SAL >= 2800;

-- EMP 테이블에서 SAL이 1100이상이거나 JOB이 MANAGER 인 사원의 EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO를 조회
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP
WHERE SAL >= 1100 OR JOB = 'MANAGER';

-- EMP 테이블에서 JOB이 MANAGER, CLERK, ANALYST가 아닌 사원의 EMPNO, ENAME, JOB, SAL, DEPTNO를 조회
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE JOB NOT IN ('MANAGER','CLERK','ANALYST');

-- EMP 테이블에서 JOB이 SALESMAN 이거나 PRESIDENT이고 SAL이 1500이 넘는 사원의 EMPNO, ENAME, JOB, SAL를 조회
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB = 'SALESMAN' OR JOB = 'PRESIDENT' AND SAL > 1500;


SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE (JOB = 'SALESMAN' OR JOB = 'PRESIDENT') AND SAL > 1500;


==============================================================


SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL >= 3000;

SELECT ENAME, DEPTNO 
FROM EMP
WHERE EMPNO = 7788;

SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE >= '1981/02/20' AND HIREDATE <= '1981/05/05'
ORDER BY HIREDATE;

SELECT *
FROM EMP
WHERE DEPTNO IN(10,20)
ORDER BY ENAME;

SELECT ENAME "EMPLOYEE", SAL "MONTHLY SALARY"
FROM EMP
WHERE SAL >= 1500 AND DEPTNO IN(10,30);

SELECT *
FROM EMP
WHERE HIREDATE >= '1982/01/01' AND HIREDATE <= '1982/12/31'
ORDER BY HIREDATE;

SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

SELECT ENAME, SAL, COMM
FROM EMP 
WHERE COMM >= SAL * 1.1;

SELECT * 
FROM EMP 
WHERE JOB IN('CLERK', 'ANALYST') AND SAL NOT IN(1000,3000,5000);

SELECT ENAME, SAL
FROM EMP 
WHERE ENAME LIKE '%A%' AND ENAME LIKE '%E%';

SELECT ENAME, MGR FROM EMP;
SELECT *
FROM EMP
WHERE ENAME LIKE '%L%L%' AND DEPTNO = 30 OR MGR = 7782;