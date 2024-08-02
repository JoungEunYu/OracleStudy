/*
    ������ ��ȸ(����) : SELECT
    
        SELECT ��ȸ�ϰ��� �ϴ� ���� FROM ���̺��;
        SELECT * �Ǵ� �÷���1, �÷���2, ... FROM ���̺��;
        
*/
-- ��� ����� ������ ��ȸ
SELECT * FROM employee;

-- ��� ����� �̸�, �ֹε�Ϲ�ȣ, �ڵ�����ȣ�� ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;

-- JOB ���̺��� �����̸��� ��ȸ
SELECT * FROM JOB;

SELECT JOB_NAME FROM JOB;

-- DEPARTMENT ���̺��� ��� ������ ��ȸ
SELECT * FROM DEPARTMENT;

-- ���� ���̺��� �����, �̸���, ����ó, �Ի���, �޿� ��ȸ
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;

/*
    �ķ����� ��� �����ϱ�
    => SELECT���� �÷��� �ۼ��κп� ��������� �� �� ����!
*/
-- ����̸�, ���� ����(SALARY * 12) ��ȸ 
-- SALARY * 12 : SALARY �÷� �����Ϳ� 12�� ���Ͽ� ��ȸ
SELECT EMP_NAME, SALARY * 12 FROM EMPLOYEE;

-- ����̸�, �޿�, ���ʽ�, ����, ���ʽ� ���� ����(�޿� + (�޿� * ���ʽ�)) * 12) ������ ��ȸ
SELECT EMP_NAME, BONUS, SALARY, (SALARY + (SALARY * BONUS)) * 12 FROM EMPLOYEE;

/*
    - ���� ��¥ �ð� ���� : SYSDATE
    - ���� ���̺�(�ӽ����̺�) : DUAL
*/
-- ���� �ð� ���� ��ȸ
SELECT SYSDATE FROM DUAL; -- YY/MM/DD �������� ��ȸ��!

-- ����̸�, �Ի���, �ٹ��ϼ� (���糯¥ - �Ի���) ��ȸ
-- DATEŸ�� - DATEŸ�� => �Ϸ� ǥ�õ�!
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE FROM employee;

/*
    * �÷��� ��Ī ���� : ������� ����� ��� �ǹ������� ��Ʊ� ������, ��Ī�� �ο��Ͽ� ��Ȯ�ϰ� ����ϰ� ��ȸ
    
    [ǥ����] 1) �÷��� ��Ī
            2) �÷��� AS ��Ī
            3) �÷��� "��Ī"
            4) �÷��� AS "��Ī"
*/
-- ����̸�, �޿�, ���ʽ�, ����, ���ʽ� ���迬������ �� ��Ī �ο��Ͽ� ��ȸ
SELECT EMP_NAME "����̸�", SALARY "�޿�", BONUS AS ���ʽ�, (SALARY + (SALARY * BONUS)) *12 AS "���ʽ� ���Կ���" FROM EMPLOYEE;

/*
    * ���ͷ� : ���Ƿ� ������ ���ڿ� ('')
        -���ν���
> SELECT ���� ����ϴ� ��� ��ȸ�� ��� (RESULT SET)�� �ݺ������� ǥ�õ�
*/

-- �̸�, �޿�, '��' ���
SELECT EMP_NAME �̸�, SALARY �޿�, '��' ���� FROM EMPLOYEE;

/*
    ���� ������ : ||
*/
SELECT SALARY || '��' AS "�޿�" 
FROM EMPLOYEE;

-- ���, �̸�, �޿��� �ѹ��� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT EMP_ID || ' ' || EMP_NAME || ' ' || SALARY AS "�̰�����" FROM EMPLOYEE;

-- XX�� �޿��� XX�� �Դϴ�
SELECT EMP_NAME || '�� �޿��� ' || SALARY || '�� �Դϴ�.' AS "�޿�����" FROM EMPLOYEE;

-- ������̺��� �����ڵ� ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;

/*
    * �ߺ����� : DISTINCT
*/
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- ��� ���̺��� �μ��ڵ� ��ȸ (�ߺ�����)
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE;
-- DISTINCT �� �ѹ��� ��� ����
-- DISTINCT (JOB_CODE, DEPT_CODE) �� �� ������ ��� �ߺ��� ��������
SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;
--===============================================================================
/*
    * WHERE �� : ��ȸ�ϰ��� �ϴ� �����͸� Ư�� ���ǿ� ���� �����ϰ��� �� �� ���
    
    [ǥ����]
        SELECT �÷���, �÷�|������ ���� �����
        FROM ���̺��
        WHERE ����;
        
    - �񱳿�����
        * ��Һ� : >, <, >=, <=
        * ����� 
            - ������ : =
            - �ٸ��� : !=, <>, ^=
*/
-- ������̺��� �μ��ڵ尡 'D9'�� ������� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ������̺��� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- �μ��ڵ尡 D1�� �ƴ� ������� ���� ��ȸ (�����, �޿�, �μ��ڵ�)
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';

-- �޿��� 400���� �̻��� ����� �����, �μ��ڵ�, �޿� ������ ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY >= 4000000;

------------------------------------------�ǽ�-----------------------------------
-- 1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ (��Ī ����)
SELECT EMP_NAME �����, SALARY �޿�, HIRE_DATE �Ի���, SALARY * 12 AS "����"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. ������ 5õ���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ (��Ī ����)
SELECT EMP_NAME �����, SALARY �޿�, SALARY * 12 AS "����", DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000;

-- 3. ���� �ڵ� 'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ (��Ī ����)
SELECT EMP_ID ���, EMP_NAME �����, JOB_CODE �����ڵ�, ENT_YN ��翩��
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 4. �޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ(��Ī ����)
-- �� AND, OR�� ������ ������ �� ����
SELECT EMP_NAME �����, EMP_ID �����ȣ, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
--==================================================================================
/*
    * BETWEEN AND : ���ǽĿ��� ���Ǵ� ����
        => �̻�~������ ������ ���� ������ �����ϴ� ����
        
    [ǥ����]
        �񱳴���÷��� BETWEEN �ּڰ� AND �ִ� 
            ->�ش� �÷��� ���� �ּڰ� �̻��̰� �ִ� ������ ���
*/
-- �޿��� 350���� �̻��̰� 600���� ������ ����� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
-- BETWEEN ����
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

/*
    * NOT : ����Ŭ������ ������������
*/
--�޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� ����� ��� �޿� ��ȸ (NOT X)
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY > 3500000 OR SALARY < 6000000;

--�޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� ����� ��� �޿� ��ȸ (NOT O)
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
-- WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
-- NOT�� BETWEEN �տ� ���̰ų� �ķ��� �տ� �ٿ��� ��밡��

/*
    IN : �񱳴���÷����� ������ ���� �߿� ��ġ�ϴ� ���� �ִ� ��� ��ȸ�ϴ� ������
    
    [ǥ����]
        �񱳴���÷��� IN ('��1', '��2', '��3', ...)
*/

-- �μ��ڵ尡 D6 �̰ų� D8�̰ų� D5�� ������� �����, �μ��ڵ�, �޿��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

-- �μ��ڵ尡 D6 �̰ų� D8�̰ų� D5�� ������� �����, �μ��ڵ�, �޿��� ��ȸ (IN ���)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D5', 'D8');

-- 9. EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� �� 
--     ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND (HIRE_DATE < '02-01-01');

-- IN ���
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D9', 'D5') AND HIRE_DATE < '02-01-01';

--===============================================================================
/*
    LIKE : ���ϰ����ϴ� �÷��� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
        => Ư�� ���� : '%', '_'�� ���ϵ�ī��� ���
            '%' : 0���� �̻�
                ex) �񱳴���÷��� LIKE '����%' => �񱳴���÷��� ���� ���ڷ� "����"�Ǵ� ���� ��ȸ
                    �񱳴���÷��� LIKE '%����' => �񱳴���÷��� ���� ���ڷ� "��"���� ���� ��ȸ
                    �񱳴���÷��� LIKE '%����%' => �񱳴���÷��� ���� ���ڰ� "����"�Ǵ� ���� ��ȸ
            '_' : 1����
                ex) �񱳴���÷��� LIKE '_����' => �񱳴���÷��� ������ ���� �տ� ������ �ѱ��ڰ� �� ��� ��ȸ
                    �񱳴���÷��� LIKE '__����' => �񱳴���÷��� ������ ���� �տ� ������ �α��ڰ� �� ��� ��ȸ
                    �񱳴���÷��� LIKE '_����_' => �񱳴���÷��� ������ ���� ��, �ڿ� ������ �ѱ��ھ� ���� ��� ��ȸ                   
*/
-- ����� �߿� ������ ����� �����, �޿�, �λ��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ��� �̸��� �ϰ� ���Ե� ����� �����, �ֹι�ȣ, ����ó ��ȸ
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ, PHONE ����ó
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ����̸��� ��� ���ڰ� ���� ����� �����, ����ó ��ȸ (�̸� 3���ڸ� �ִٸ�,,,)
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ����� �� ����ó�� 3��° �ڸ��� 1�� ����� ���, �����, ����ó, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ����� �� �̸��Ͽ� 4���� �ڸ��� _�� ����� ���, �̸�, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- ���ϴ� ��� ��ȸ�� ���� ����!
--> ���ϵ�ī��� ���Ǵ� ���ڿ� �÷��� ��� ���ڰ� �����ϱ� ������ ��� ���ϵ� ī��� �ν�
-- ����, ������ ����� ��! (=> ������ ���ϵ�ī�� ����ϱ�! ESCAPE �� ����Ͽ� ��� �� ����)

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';
--===============================================================================
/*
    IS NULL / IS NOT NULL : �÷����� NULL �� ���� ��� NULL���� ���� �� ����ϴ� ������
*/
-- ���ʽ��� ���� �ʴ� ������� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ��� (BONUS�� ���� NULL�� �ƴ�) ���� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- ����� ���� ��� (MANAGER_ID�� ���� NULL)���� �����, ������(MANAGER_ID), �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- �μ� ��ġ�� ���� �ʾ�����, ���ʽ��� �ް� �ִ� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
--================================================================================
/*
    ������ �켱����
     (0) ()
     (1) ��������� : * / + -
     (2) ���Ῥ���� : ||
     (3) �񱳿����� : > < >= <= = != ..
     (4) IS NULL / LIKE '����' / IN
     (5) BETWEEN AND
     (6) NOT
     (7) AND
     (8) OR
*/
-- ���� �ڵ尡 J7 �̰ų� J2�� ����� �߿� �޿��� 200���� �̻��� ����� ��� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >= 2000000;
--===============================================================================
/*
    ORDER BY : SELECT���� ���� ������ �ٿ� �ۼ�, ������� ���� �������� ����

    [ǥ����]
        SELECT ��ȸ�� �÷�, ...
        FROM ���̺��
        WHERE ���ǽ�
        ORDER BY ���ı����̵Ǵ��÷���|��Ī|�÷����� [ASC|DESC] [NULLS FIRST|NULLS LAST]
        
        ASC : �������� ���� (�⺻��)
        DESC : �������� ����
        
        NULLS FIRST  : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �ش� �����͸� �� �տ� ��ġ (DESC�� ��� �⺻��)
        NULLS LAST :  �����ϰ����ϴ� �÷��� ���� NULL�� ��� �ش� �����͸� �� �ڿ� ��ġ (ASC�� ��� �⺻��)
        => NULL ���� ū ������ �з��Ǿ� ���ĵ�!
*/
-- ��� ����� �����, ���� ��ȸ (������ �������� ����)
SELECT EMP_NAME, SALARY*12 ����
FROM EMPLOYEE
ORDER BY ���� DESC;

SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE
ORDER BY SALARY*12 DESC;

SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE
ORDER BY 2 DESC;
-- 2��° �÷�(������ 1��)  

-- ���ʽ� �������� �����غ���
SELECT *
FROM EMPLOYEE
ORDER BY BONUS; --�⺻�� (ASC, NULLS LAST)
-- ORDER BY BONUS ASC;
-- ORDER BY BONUS ASC NULLS LAST;  3�ٴ� ���� ��

-- ORDER BY BONUS DESC; -- NULLS FIRST (DESC ������ ��� �⺻��)

-- ���ʽ��� ��������, �޿��� ��������
SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC, SALARY ASC; -- ���ʽ� ���� �������� �����ϴµ�, ���� ���� ��� �޿��� ���� ������������ ����
