-- ��������???�������� ������ ���� ���� �� �Ʒ� SQL���� �ۼ����ּ��� ��������???��������
--============================================================================--
-- [1] '240724' ���ڿ��� '2024�� 7�� 24��'�� ǥ���غ���
select TO_CHAR(to_date('240724'), 'YYYY"��" FMMM"��" DD"��"') FROM DUAL;
-- [2] ������ �¾ �� ��ĥ°���� Ȯ���غ��� (���糯¥ - �������)
SELECT CEIL(SYSDATE - TO_DATE(19990224))FROM DUAL;

-- [3] ���� ������ �ٲ㺸��
-- bElIVe iN YoURseLF.      -->  Belive in yourself.
SELECT CONCAT(UPPER(SUBSTR('bElIVe iN YoURseLF.', 1, 1)), LOWER(SUBSTR('bElIVe iN YoURseLF.', 2))) 
FROM DUAL;

-- [4] ������ 7�������� ������� �Ի���� ��� �� ��ȸ (�Ʒ��� ���� ���)
/*
------------------------------------------------------------
    ����     |   �Ի��   |   �Ի� �����|
         7�� |       4�� |          2��|
         7�� |       9�� |          1��|
         ...
         9�� |       6�� |          1��|
------------------------------------------------------------
*/
SELECT LPAD(SUBSTR(EMP_NO, 3, 2) || '��', 8) "����", 
        LPAD(EXTRACT(MONTH FROM HIRE_DATE) || '��', 8) AS "�Ի��",
        LPAD(COUNT(*) || '��', 10) "�Ի� �����"
FROM EMPLOYEE
WHERE TO_NUMBER(SUBSTR(EMP_NO, 3, 2)) >= 7  -- ������ 7�� ������ ����� ����
GROUP BY SUBSTR(EMP_NO, 3, 2), EXTRACT(MONTH FROM HIRE_DATE)
ORDER BY ����, 2;
-- [5] �����μ� ����� ���, �����, �μ���, ���޸� ��ȸ
-- ���(EMPLOYEE), DEPARTMENT(�μ�), ����(JOB) -> JOIN (���� ���̺��� ��ħ)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE)
WHERE DEPT_TITLE LIKE '%����%';
