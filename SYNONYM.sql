-- SALGRADE 동의어로 GUBUN를 생성하고 동의어로 조회
CREATE SYNONYM GUBUN
FOR SALGRADE;

SELECT *
FROM GUBUN;

-- 동의어 삭제
DROP SYNONYM GUBUN;

-- 연습문제
CREATE SYNONYM EMPLOYEE
FOR EMP;





