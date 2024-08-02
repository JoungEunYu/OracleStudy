-- [Basic SELECT]

-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. �� ��� ����� "�а� ��", "�迭"���� ǥ���ϵ��� �Ѵ�.
SELECT DEPARTMENT_NAME "�а� ��", CATEGORY "�迭"
FROM TB_DEPARTMENT;

-- 2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
SELECT DEPARTMENT_NAME || '�� ������ ' || COUNT(*) || '�� �Դϴ�.'
FROM TB_DEPARTMENT
    LEFT JOIN TB_STUDENT USING (DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME;

-- 3. "������а�"�� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�.
-- �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�Ƴ����� ����)
SELECT STUDENT_NAME
FROM TB_DEPARTMENT
    JOIN TB_STUDENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '������а�'
    AND SUBSTR(STUDENT_SSN, 8, 1) = 2
    AND ABSENCE_YN = 'Y';
    
-- 4. ���������� ���� ���� ��� ��ü�ڵ��� ã�� �̸��� �Խ��ϰ��� �Ѵ�.
-- �� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME DESC;

-- 5. ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <= 30;

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.
-- �׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
-- ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT WHERE DEPARTMENT_NO IS NULL;

-- 8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�,
-- ���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

-- 10. 02�й� ���� �����ڵ��� ������ ������� �Ѵ�. 
-- ������ ������� ������ �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE STUDENT_ADDRESS LIKE '����%' 
    AND ABSENCE_YN = 'N' 
    AND EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002;
    
--------------------------------------------------------------------------------
-- [Additional SELECT - �Լ�]

-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������
-- ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ����� "�й�", "�̸�", "���г⵵"�� ǥ�õǵ��� �Ѵ�.)
SELECT STUDENT_NO "�й�", STUDENT_NAME �̸�, ENTRANCE_DATE AS ���г⵵
FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO = 002
ORDER BY STUDENT_NAME;

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. �� ������ �̸���
-- �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��غ���.  (�̶� �ùٸ��� �ۼ��� SQL������ �������
-- ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) > 3 OR LENGTH(PROFESSOR_NAME) < 3;

-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL������ �ۼ��Ͻÿ�.
-- �� �̋� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�.
-- (��, ���� �� 2000�� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. 
-- ���̴� '��'���� ����Ѵ�.
SELECT PROFESSOR_NAME, 
    EXTRACT(YEAR FROM SYSDATE )- EXTRACT(YEAR FROM TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6), 'RRMMDD')) "����"
FROM TB_PROFESSOR;

-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- ��� ����� "�̸�"�� �������� �Ѵ� (���� 2���� ����� ������ ���ٰ� ���� �Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME, 2) �̸�
FROM TB_PROFESSOR;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? 
-- �̶�, 19�쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
SELECT STUDENT_NO STUDENT_NAME
FROM TB_STUDENT
WHERE ;

-- 6. 2020�� ũ���������� ���� �����α�?
SELECT TO_CHAR(TO_DATE('20201225', 'YYYYMMDD'), 'DAY') FROM DUAL;
-- �ݿ���

-- 7. TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')�� ����
-- ��� ��� ������ �ǹ��ұ�? �� TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')
-- �� ���� �� �� �� �� �� ���� �ǹ��ұ�
-- TO_DATE('99/10/11', 'YY/MM/DD') -> 2099�� 10�� 11��
-- TO_DATE('49/10/11', 'YY/MM/DD') -> 2049�� 10�� 11��
-- TO_DATE('99/10/11', 'RR/MM/DD') -> 1999�� 10�� 11��
-- TO_DATE('49/10/11', 'RR/MM/DD') -> 2049�� 10�� 11��

-- 8. �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ� �ִ�.
-- 2000�⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��ϼ�
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO, 1, 1) != 'A';

-- 9. �й��� A517178�� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ��, �̶� ��µǴ� ȭ���� ����� "����"�̶�� ������ �ϰ�,
-- ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
SELECT ROUND(AVG(POINT), 1) ����
FROM TB_STUDENT
    JOIN TB_GRADE USING(STUDENT_NO)
WHERE STUDENT_NAME = '�ѾƸ�';

-- 10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)"�� ���·� ����� ����� �������
-- ��µǵ��� �Ͻÿ�.
SELECT DEPARTMENT_NO, COUNT(*)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11. ���� ������ �������� ���� �л� ���� ��� ���� �Ǵ� �� �˾Ƴ��� SQL���� �ۼ��Ͻÿ�
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�,
-- ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
SELECT SUBSTR(TERM_NO, 1, 4) �⵵, ROUND(AVG(POINT), 1) "�⵵ �� ����"
FROM TB_GRADE
    JOIN TB_STUDENT USING (STUDENT_NO)
WHERE STUDENT_NAME = '����'
GROUP BY SUBSTR(TERM_NO, 1, 4);

-- 13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL������ �ۼ��Ͻÿ�.
SELECT DEPARTMENT_NO "�а��ڵ��" , COUNT(CASE WHEN ABSENCE_YN = 'Y' THEN 1 END) "���л� ��"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 14. �� ���б��� �ٴϴ� �������� �л����� �̸��� ã���� �Ѵ�. � SQL������ ����ϸ� ����??
SELECT STUDENT_NAME "�����̸�", COUNT(STUDENT_NAME) "������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NAME) > 1;

-- 15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ����
-- , �� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ( ��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
SELECT SUBSTR(TERM_NO, 1, 4) �⵵, SUBSTR(TERM_NO, 5, 2) �б�, AVG(POINT) ����
FROM TB_GRADE
    JOIN TB_STUDENT USING (STUDENT_NO)
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2);

-------------------------------------------------------------------------------
-- [Additional SELECT - Option]

-- 1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� �����
-- "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT STUDENT_NAME "�л� �̸�", STUDENT_ADDRESS "�ּ���"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

-- 2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

-- 3. �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�,
-- �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�.
-- ��, ���������� "�л��̸�", "�й�", "������ �ּ�"�� ��µǵ��� �Ѵ�.
SELECT STUDENT_NAME "�л��̸�", STUDENT_NO "�й�", STUDENT_ADDRESS "������ �ּ�"
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%' AND (STUDENT_ADDRESS LIKE '��⵵%' OR STUDENT_ADDRESS LIKE '������%')
ORDER BY STUDENT_NAME;

-- 4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��ض�
-- (���а��� '�а��ڵ�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�Ƴ����� ����)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���а�'
ORDER BY PROFESSOR_SSN;

-- 5. 2004�� 2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�.
-- ������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��϶�.
SELECT STUDENT_NO, TO_CHAR(POINT, 'FM9.0') "POINT"
FROM TB_STUDENT
    JOIN TB_GRADE USING (STUDENT_NO)
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC;

-- 6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL���� �ۼ��϶�.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;
