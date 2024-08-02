/*
    JOIN
    : �ΰ� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
     ��ȸ����� �ϳ��� �����(RESULT SET)�� ����
     
    * ������ �����ͺ��̼� (RDB)������ �ּ����� �����͸� ������ ���̺� ����
     �ߺ������� �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� ������
     
     => ������ �����ͺ��̽����� �������� �̿��� ���̺��� "����"�� �δ� ���
     (�� ���̺��� �����(�ܷ�Ű)�� ���ؼ� �����͸� ��Ī���� ��ȸ��)
     
     JOIN�� ũ�� "����Ŭ ���� ����" �� "ANSI ����" (�̱�����ǥ����ȸ)
------------------------------------------------------------------------------     
            ����Ŭ ���� ����         |            ANSI ����
------------------------------------------------------------------------------
              � ����             |            ���� ����
            (EQUAL JOIN)                      (INNER JOIN) --> JOIN USING/ON
------------------------------------------------------------------------------
              ���� ����             |   ���� �ܺ� ���� (LEFT OUTER JOIN)
            (LEFT OUTER)              ������ �ܺ� ���� (RIGHT OUTER JOIN)
            (RIGHT OUTER)              ��ü �ܺ� ���� (FULL OUTER JOIN)
------------------------------------------------------------------------------
          ��ü ����(SELF JOIN)      |             JOIN ON
       �� ���� (NON EQUAL JOIN)
------------------------------------------------------------------------------

*/
-- ��ü ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- �μ��ڵ�, �μ��� ��ȸ(�μ� ������ ����� ���̺� : DEPARTMENT)
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

-- �����ڵ�, ���޸� ��ȸ (���� ���� : JOB)
SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    * �����(EQAUL JOIN) / ��������(INNER JOIN)
    => �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ(=> ��ġ���� �ʴ� ���� ��ȸ �� ����)
*/
-- ����Ŭ ���� ���� --
/*
    FROM���� ��ȸ�ϰ��� �ϴ� ���̺��� ���� (, �� ����)
    WHERE���� ��Ī��ų �÷��� ���� ������ �ۼ�
*/
-- ����� ���, �̸�, �μ����� ��ȸ (�μ� �ڵ� �÷� => EMPLOYEE : DEPT_CODE, DEPARTMENT: DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- > NULL (EMPLOYEE.DEPT_CODE) , �����ú�(D3), �ؿܿ���3��(D7), ����������(D4) -> DEPARTMENT �����ʹ� ���ܵ�
--= ���� ���̺��� �����ϴ� ����� ��ȸ���� ���ܵ�

-- ����� ���, �̸�, ���޸��� ��ȸ (�����ڵ� �÷� => EMPLOYEE: JOB_CODE, JOB: JOB_CODE)
-- �� ���̺��� �÷����� ������ ��� ��Ī�� ���������ν� ������ �� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- ANSI ���� --
/*
    FROM���� ������ �Ǵ� ���̺��� �ϳ� �ۼ�
    JOIN���� �����ϰ����ϴ� ���̺��� ��� + ��Ī��Ű���� �ϴ� ������ �ۼ�
     - JOIN USING   : �÷����� ���� ���
     - JOIN ON      : �÷����� ���ų� �ٸ� ���
*/
-- ���, �����, �μ��� ��ȸ (EMPLOYEE : DEPT_CODE, DEPARTMENT: DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
    
-- ���, �����, ���޸� ��ȸ (EMPLOYEE : JOB_CODE, JOB : JOB_CODE)
-- JOIN USING ���� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE);
-- JOIN ON ���� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
    
-- �븮 ������ ����� ���, �����, ���޸�, �޿� ��ȸ
-- ** ����Ŭ ���� ��� **
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '�븮';

-- **ANSI ���� ���**
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE) 
WHERE JOB_NAME = '�븮';
--------------------------------����-----------------------------
-- [1] �μ��� �λ�������� ������� ���, �����, ���ʽ� ��ȸ
-- ** ����Ŭ ���� **
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '�λ������';
-- ** ANSI ���� **
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE 
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

-- [2] �μ�(DEPARTMENT)�� ����(LOCATION) ������ �����Ͽ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
-- ** ����Ŭ ���� **
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
-- ** ANSI ���� **
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
    
-- [3] ���ʽ��� �޴� ������� ���, �����, ���ʽ� ����, �μ��� ��ȸ
-- ** ����Ŭ ���� **
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;
-- ** ANSI ���� **
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE 
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
WHERE BONUS IS NOT NULL;

--[4] �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿� ��ȸ
-- ** ����Ŭ ���� **
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND NOT DEPT_TITLE = '�ѹ���';
-- ** ANSI ���� **
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE NOT DEPT_TITLE ='�ѹ���';
--------------------------------------------------------------------------------
/*
    �������� / �ܺ����� (OUTER JOIN)
    : �� ���̺��� JOIN�� ��ġ���� �ʴ� �൵ �����Ͽ� ��ȸ�ϴ� ����
      ��, �ݵ�� LEFT / RIGHT�� �����ؾ� �� (������ �Ǵ� ���̺�)
*/
-- ��� ����� �����, �μ���, �޿�, ���� ������ ��ȸ
-- * LEFT JOIN : �� ���̺� �� ���ʿ� �ۼ��� ���̺��� �������� ����

-- ** ����Ŭ ���� **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- ** ANSI ���� **
SELECT EMP_NAME, DEPT_TITLE, SALARY ,SALARY*12 ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- * RIGHT JOIN : �� ���̺� �� �����ʿ� �ۼ��� ���̺� �������� ����
-- ** ����Ŭ ���� **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- ** ANSI ����**
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE
    RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- * FULL JOIN : �� ���̺��� ���� ��� ���� ��ȸ�ϴ� ���α��� (����Ŭ ���� ���� X)
-- ** ANSI ���� **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12 ����
FROM EMPLOYEE
    FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-------------------------------------------------------------------------------
/*
    �� ����(NON EQUAL JOIN)
    : ��Ī ��ų �÷��� ���� ���� �ۼ� �� '='�� ������� �ʴ� ����
    
    * ANSI ���������� JOIN ON�� ��밡�� *
*/
-- ����� ���� �޿� ��� ��ȸ (�����, �޿�, �޿����)
-- ���(EMPLOYEE), �޿���� (SAL_GRADE)
--  * ����Ŭ ���� *
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- * ANSI ���� *
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
    JOIN SAL_GRADE ON SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
--------------------------------------------------------------------------------
/*
    ��ü ����(SELF JOIN)
    : ���� ���̺��� �ٽ� �ѹ� �����ϴ� ����
*/
-- ��ü ����� ���, �����, �μ��ڵ�, ������, ��������, ��� �μ��ڵ� ��ȸ
-- ������� (EMPLOYEE), ���(���) (EMPLOYEE) --> ���̺���� �����ϹǷ� "��Ī"�� �ο�
-- * ����Ŭ ���� *
SELECT E.EMP_ID ���, E.EMP_NAME �����, E.DEPT_CODE �μ��ڵ�,
        M.EMP_ID ������, M.EMP_NAME "��� �����", M.DEPT_CODE "��� �μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;   -- ����� �����ȣ�� ����� �������� �־� ��������� ��ȸ

-- *ANSI ���� *
SELECT E.EMP_ID ���, E.EMP_NAME �����, E.DEPT_CODE �μ��ڵ�,
        M.EMP_ID ������, M.EMP_NAME "��� �����", M.DEPT_CODE "��� �μ��ڵ�"
FROM EMPLOYEE E
    JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
    -- LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID; ����� ���� ��� ������ ��ȸ�ϰ� �Ҷ�
--------------------------------------------------------------------------------
/*
    ���� ����
    : 2�� �̻��� ���̺��� �����ϴ� ��
*/
-- ���, �����, �μ���, ���޸� ��ȸ
-- EMPLOYEE / DEPARTMENT / JOB
-- * ����Ŭ ���� *
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID
        AND E.JOB_CODE = J.JOB_CODE;
        
-- * ANSI ���� *
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
   -- JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
    JOIN JOB USING (JOB_CODE);
    
-- ���, �����, �μ���, ������ ��ȸ
-- EMPLOYEE : �μ� �ڵ� - DEPT_CODE
-- DEPATMENT : �μ��ڵ� - DEPT_ID, �����ڵ� - LOCATION_ID
-- LOCATION : �����ڵ� - LOCAL_CODE

-- * ����Ŭ ���� *
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE;
    
-- * ANSI ���� *
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID      -- EMPLOYEE ���̺�� DEPARTMENT ���̺� ����
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;  -- DEPARTMENT ���̺�� LOCATION ���̺� ����
--------------------------------------------------------------------------------
-- 1) ���, �����, �μ���, ������, ������ ��ȸ
-- ��� EMPLOYEE / �μ� DEPARTMENT / ���� LOCATION / ���� NATIONAL
-- * ����Ŭ ���� *
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
        AND LOCATION_ID = LOCAL_CODE
        AND L.NATIONAL_CODE = N.NATIONAL_CODE;
-- * ANSI ���� *
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
    
-- 2) ���, �����, �μ���, ���޸�, ������, �޿���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT, JOB J, NATIONAL N, SAL_GRADE, LOCATION L
WHERE   DEPT_CODE = DEPT_ID
        AND E.JOB_CODE = J.JOB_CODE
        AND SALARY BETWEEN MIN_SAL AND MAX_SAL
        AND LOCATION_ID = LOCAL_CODE
        AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- ���� JOB / �޿���� SAL_GRADE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
    JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE);