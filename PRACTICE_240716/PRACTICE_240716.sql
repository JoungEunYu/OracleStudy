-- 1. JOB 테이블의 모든 정보 조회
SELECT * FROM JOB;

-- 2. JOB 테이블의 직급 이름 조회
SELECT JOB_NAME FROM JOB;

-- 3. DEPARTMENT 테이블의 모든 정보 조회
SELECT * FROM DEPARTMENT;

-- 4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;

-- 5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;

-- 6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME, SALARY*12, (SALARY + (SALARY * BONUS)) * 12, ((SALARY + (SALARY * BONUS)) * 12) - (SALARY*12 * 0.03)
FROM EMPLOYEE;
-- 연산식에 NULL값이 있으면 결과가 NULL로 표시됨

-- 7. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT EMP_NAME, SALARY, ((SALARY + (SALARY * BONUS)) * 12) - (SALARY*12 * 0.03), HIRE_DATE
FROM EMPLOYEE
WHERE ((SALARY + (SALARY * BONUS)) * 12) - (SALARY*12 * 0.03) >= 50000000;
--  WHERE 실수령액 >= 5000000; -- 오류발생! (WHERE절에서는 SELECT절의 별칭 정보를 알수 없음)
-- 실행 순서 : FROM -> WHERE -> SELECT
-- 8. EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- 9. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 
--     고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND (HIRE_DATE < '02-01-01');
