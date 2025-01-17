/* 
    GROUP BY절
    : 그룹 기준을 제시할 수 있는 구문
    : 여러 개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용
*/
-- 전체 사원의 급여 총 합
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 부서별 급여 총 합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE;
-- 결과 행 개수가 다르다.
-- DEPT_CODE는 23줄인데 SUM은 1줄이니까
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 각 부서의 총합을 구한다

-- 부서별 사원 수 조회
SELECT DEPT_CODE, COUNT(*)  -- 3
FROM EMPLOYEE               -- 1
GROUP BY DEPT_CODE;         -- 2

-- 부서코드가 D6, D9, D1인 각 부서별 급여 총 합, 사원 수 조회
SELECT DEPT_CODE, SUM(SALARY), COUNT(*) -- 4
FROM EMPLOYEE                           -- 1
WHERE DEPT_CODE IN ('D6', 'D9', 'D1')   -- 2
GROUP BY DEPT_CODE                      -- 3
ORDER BY DEPT_CODE;                     -- 5

-- 각 직급별 총 사원수/보너스를 받는 사원수/급여합/평균급여/최저급여/최고급여 조회(단, 직급코드 오름차순)
SELECT JOB_CODE, COUNT(*) "총 사원수", COUNT(BONUS) "보너스받는"
        , SUM(SALARY) "급여합", ROUND(AVG(SALARY)) "평균급여", MIN(SALARY) "최저급여", MAX(SALARY) "최고급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 남자 사원수, 여자 사원수 조회
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') "성별", COUNT(*) "사원 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- 부서 내 직급별 사원수, 급여 총합 조회
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- 부서코드 기준으로 그룹화하고, 그 내에서 직급코드 기준으로 세부그룹화를 함
ORDER BY DEPT_CODE;
----------------------------------------------------------------------------------
/*
    HAVING 절
    : 그룹에 대한 조건을 제시할 때 사용되는 구문 (보통 그룹함수식을 가지고 조건을 작성함)
*/
-- 각 부서별 평균 급여 조회(부서코드, 평균 급여 > 반올림처리)
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 각 부서별 평균 급여가 300만원 이상인 부서만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000; -- WHERE절에서는 그룹함수 사용 불가

-- 직급 별 직급코드, 총 급여합 조회(단, 직급별 급여 합이 1000만원 이상인 직급만 조회)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 부서별 보너스를 받는 사원이 없는 부서의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
-- WHERE BONUS IS NULL --부서 상관 없이 보너스가 NULL 인 사원들을 먼저 걸러냄 -> 해당 부서에 보너스가 있는 사원이 있을 수도 있음
GROUP BY DEPT_CODE -- 그룹화한 후에 COUNT 함수를 사용하여 BONUS 받는 사원이 없는 조건을 제시해야함
HAVING COUNT(BONUS) = 0;
-----------------------------------------------------------------------------
/*
    실행 순서
    
(5)    SELECT * | 조회하고자 하는 컬럼 AS "별칭" | 함수식 | 연산식 
(1)    FORM  조회하고자 하는 테이블 | DUAL
(2)    WHERE 조건식(연산자들을 활용하여 작성)
(3)    GROUP BY 그룹화할 기준이 되는 컬럼 | 함수식
(4)    HAVING 조건식 (그룹함수를 활용하여 작성)
(6)    ORDER BY 컬럼 | 별칭 | 컬럼순서 | [ASC|DESC] |[NULLS FIRST] | [NULLS LAST]
*/
---------------------------------------------------------------------------------
/*
    집합 연산자
    : 여러 개의 쿼리문을 하나의 쿼리문으로 만드러주는 연산자
    
    - UNION : 합집함 OR (두 쿼리문을 수행한 결과값을 더해줌)
    - INTERSECT : 교집합 AND (두 쿼리문을 수행한 결과값의 중복된 부분을 추출)
    - UNION ALL : 합집합 + 교집합 (중복되는 부분이 두번 조회될 수 있다)
    - MINUS : 차집합 (선행 결과값에 후행 결과값을 뺀 나머지)
*/
-- **UNION**
-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원들의 사번, 이름, 부서코드, 급여 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- **  교칩합 **
-- 부서코드가 D5이고 급여가 300만원 초과인 사원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ** UNION ALL **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ** MINUS **
-- 선행 결과 값에서 후행 결과 값을 뺀 나머지
-- 부서코드가 D5인 사원들 중 급여가 300만원 초과인 사원들을 제외하고 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

/*
집합 연산자 사용 시 주의사항
1) 쿼리문들의 컬럼 개수가 동일해야 함
2) 컬럼 자리마다 동일한 타입으로 작성해야함
3) 정렬하고자 한다면 ORDER BY절은 마지막에 작성해야함D
*/