-- �Լ� �ι�° ����
/*
    �����Լ�
      DECODE(�񱳴��(�÷�/�����/�Լ���), �񱳰�1, �����1, �񱳰�2, �����2,...)
    
      -- �ڹٿ��� switch
      switch(�񱳴��) {
      case �񱳰�1 : �����;
      case �񱳰�2 : �����;
      ...
      }
*/
-- ���, �����, �ֹι�ȣ, ���� ��ȸ(1,3: '��', 2,4 : '��', �׿� '�˼�����')
SELECT EMP_ID ���, EMP_NAME �����, EMP_NO �ֹι�ȣ
        , DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��', '����', 4, '����', '�˼�����') ����
FROM EMPLOYEE;

-- �����, �����޿�, �λ�� �޿� ��ȸ
SELECT EMP_NAME �����, JOB_CODE �����ڵ�, SALARY �����޿�
        , DECODE(JOB_CODE, 'J7', SALARY + (SALARY * 0.1)
        , 'J6', SALARY + (SALARY * 0.15)
        , 'J5', SALARY + (SALARY * 0.2)
        , SALARY + (SALARY * 0.05)) "�λ�� �޿�"
FROM EMPLOYEE;
/*
    CASE WHEN THEN : ���ǽĿ� ���� ������� ��ȯ���ִ� �Լ�
    
    [ǥ����]
        CASE
            WHEN ���ǽ�1 THEN �����1
            WHEN ���ǽ�2 THEN �����2
            ...
            ELSE �����
        END
*/
-- �����, �޿�, �޿��� ���� ��� ��ȸ
/*
    500���� �̻� '���'
    350���� �̻� '�߱�'
    �׿� '�ʱ�'
*/
SELECT EMP_NAME �����, SALARY �޿�, 
        CASE
            WHEN SALARY >= 5000000 THEN '���'
            WHEN SALARY >= 3500000 THEN '�߱�'
            ELSE '�ʱ�'
        END "�޿��� ���� ���"
FROM EMPLOYEE;
--=============================================================================
-------------------- �׷� �Լ� ---------------------
/*
    SUM : �ش� �÷��� ������ �� ���� ��ȯ���ִ� �Լ�
    
    [ǥ����]
        SUM(����Ÿ���÷�)
*/
-- ��ü ������� �� �޿��� ��ȸ
SELECT SUM(SALARY) FROM EMPLOYEE;
--- 'XXX,XXX,XXX' �������� ǥ���Ѵٸ�..?
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') �ѱ޿� FROM EMPLOYEE;

-- ���ڻ������ �� �޿�
SELECT SUM(SALARY)"���ڻ������ �� �޿�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- ���ڻ������ �� �޿�
SELECT SUM(SALARY)"���ڻ������ �� �޿�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- �μ��ڵ尡 'D5'�� ������� �� ����
SELECT SUM(SALARY * 12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

/*
    AVG : �ش� �÷��� ������ ����� ��ȯ���ִ� �Լ�
    
    [ǥ����]
        AVG(����Ÿ���÷�)
*/
-- ��ü ������� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY)) "��ձ޿�" FROM EMPLOYEE;

/*
    MIN : �ش� �÷��� ���� �� ���� ���� �� ��ȯ���ִ� �Լ�
    
    [ǥ����] MIN(���Ÿ��)
*/
SELECT MIN(EMP_NAME)"����Ÿ�� �ּڰ�", MIN(SALARY)"����Ÿ�� �ּڰ�", MIN(HIRE_DATE)"��¥Ÿ�� �ּڰ�"
FROM EMPLOYEE;

/*
    MAX : �ش� �÷��� ���� �� ���� ū ���� ��ȯ���ִ� �Լ�
    
    [ǥ����] MAX(���Ÿ��)
*/
SELECT MAX(EMP_NAME)"����Ÿ�� �ִ�", MAX(SALARY)"����Ÿ�� �ִ�", MAX(HIRE_DATE)"��¥Ÿ�� �ִ�"
FROM EMPLOYEE;

/*
    COUNT : ���� ������ ��ȯ���ִ� �Լ� (��, ������ ���� ��� �ش� ���ǿ� �´� ���� ������ ��ȯ)
    
    [ǥ����]
        COUNT(*) : ��ȸ�� ����� ��� ���� ������ ��ȣ��
        COUNT(�÷�) : �ش� �÷����� NULL�� �ƴ� �͸� ���� ������ ���� ��ȯ
        COUNT(DISTINCT �÷�) : �ش� �÷����� �ߺ��� ������ ���� ���� ������ ���� ��ȯ
                => �ߺ� ���� �� NULL�� �������� �ʰ� ������ ������
*/
-- ��ü ��� �� ��ȸ
SELECT COUNT(*) "��ü ��� ��" FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(BONUS) FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- �μ� ��ġ ���� ��� �� ��ȸ
SELECT COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE; -- 6��

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE; -- 7��
