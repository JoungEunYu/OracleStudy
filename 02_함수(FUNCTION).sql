/*
    �Լ� (FUNCTION)
    : ���޵� �÷����� �о �Լ��� ������ ����� ��ȯ
    
    - ������ �Լ� : N���� ���� �о N���� ������� ���� (�ึ�� ������ ����� ��ȯ)
    - �׷� �Լ� : N���� ���� �о 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ��� ������ ����� ��ȯ)
    
    * SELECT���� ������ �Լ��� �׷��Լ��� �Բ� ����� �� ����
     => ��� ���� ������ �ٸ��� ������
     
    * �Լ����� ����� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/
--========================������ �Լ�=================================================
/*
    ����Ÿ���� ������ ó�� �Լ� 
     => VARCHAR2(n), CHAR(n)
     
     LENGTH(�÷��� | '���ڿ�') : �ش� ���ڿ��� ���ڼ��� ��ȯ
     LENGTHB(�÷��� | '���ڿ�') : �ش� ���ڿ��� ����Ʈ���� ��ȯ
     
     => ������, ����, Ư������ ���ڴ� 1byte
        �ѱ��� ���ڴ� 3byte '��', '��', '��' ����
*/
-- '����Ŭ' �ܾ��� ���ڼ��� ����Ʈ���� Ȯ���غ��� -> |  3   |   9   |
SELECT LENGTH('����Ŭ') ���ڼ�, LENGTHB('����Ŭ') ����Ʈ��
FROM DUAL;

--'ORACLE' �ܾ��� ���ڼ��� ����Ʈ�� -> |   6   |   6   |
SELECT LENGTH('ORACLE') ���ڼ�, LENGTHB('ORACLE') ����Ʈ��
FROM DUAL;

-- EMPLOYEE ���̺��� �����, �����(���ڼ�), �����(����Ʈ��), �̸���, �̸���(���ڼ�), �̸���(����Ʈ��)
SELECT EMP_NAME �����, LENGTH(EMP_NAME) ������ڼ�, LENGTHB(EMP_NAME) �������Ʈ��,
EMAIL �̸���, LENGTH(EMAIL) �̸��ϱ��ڼ�, LENGTHB(EMAIL) �̸��Ϲ���Ʈ��
FROM EMPLOYEE;
---------------------------------------------------------------------------------------------
/*
    INSTR : ���ڿ��κ��� Ư�� ������ ������ġ�� ��ȯ
    
    [ǥ����]
        INSTR(�÷� | '���ڿ�', 'ã�����ϴ� ����' [, ã�� ��ġ�� ���۰�, ����])
        => �Լ� ���� ����� ����Ÿ��(NUMBER)
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;  -- ���ʿ� �ִ� ù��° B�� ��ġ : 3
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- ã�� ��ġ�� ���۰�(�⺻��) : 1
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- �������� ���۰����� �����ϸ� �ڿ������� ã�´�. �ٸ�, ��ġ�� ���� ���� �տ������� �о ����� ��ȯ
                                                 -- ���ʿ� �ִ� ù��° B�� ��ġ : 10
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- ������ ������ ���� ���۰��� �����ؾ� ��
                                                   -- ���ʿ� �ִ� �ι�° B�� ��ġ : 9

-- ��� ���� �� �̸��Ͽ� _ �� ù��° ��ġ, @�� ��ġ ��ȸ (�̸���, _ ��ġ, @��ġ
SELECT EMAIL, INSTR(EMAIL, '_') "_ ��ġ", INSTR(EMAIL, '@') "@ ��ġ"
FROM EMPLOYEE;
------------------------------------------------------------------------------------------
/*
    SUBSTR : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    
    [ǥ����]
        SUBSTR(���ڿ�|�÷�, ������ġ[, ����(����)])
        => 3��° ���� �κ��� �����ϸ� ���ڿ� ������ ����
*/
SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL;    -- 10��° ��ġ���� ������ ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL;  -- 8��° ��ġ���� 3���ڸ� ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL;    -- �ڿ��� 3��° ��ġ���� ������ ���� => PER
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL; -- �ڿ������� 9��° �ڸ� ��ġ���� 3���� ���� => DEV

-- ����� �� ������鸸 ��ȸ (�̸�, �ֹι�ȣ)
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN '2';


-- ����� �� ������鸸 ��ȸ (�̸�, �ֹι�ȣ), �̸��� ������ ������ ����
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1
ORDER BY EMP_NAME;

-- ��� ���� �� �����, �̸���, ���̵�(�̸��Ͽ��� @ �ձ����� ��) ��ȸ
-- [1] �̸��Ͽ��� '@'�� ��ġ�� ã�� => INSTR �Լ� ���
-- [2] �̸��� �÷��� ������ 1��° ��ġ���� '@'��ġ(1���� Ȯ��) ������ ����(-1)
SELECT EMP_NAME �����, EMAIL �̸���, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1)
FROM EMPLOYEE;
---------------------------------------------------------------------------------
/*
    LPAD / RPAD : ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
                  ���ڿ��� �����̰����ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���� ���̸�ŭ ���ڿ��� ��ȯ
                  
    [ǥ����]
            LPAD(���ڿ�|�÷�, ��������[, �����Ϲ���])
            RPAD(���ڿ�|�÷�, ��������[, �����Ϲ���])
            * �����Ϲ��� ���� �� �⺻������ �������� ä����
*/
-- ��� ���� �� ������� ������ �������� ä���� �� 20���̷� ��ȸ
SELECT EMP_NAME �̸�, LPAD(EMP_NAME, 20) "���� �ȳ� �̸�"
FROM EMPLOYEE;

SELECT EMP_NAME �̸�, RPAD(EMP_NAME, 20) "������ ���� �̸�"
FROM EMPLOYEE;

-- ��� ���� �̸�, �̸��� �����������Ͽ� ��ȸ
SELECT EMP_NAME �̸�, LPAD(EMAIL, 20) "�̸��� ������ ����"
FROM EMPLOYEE;

-- ��� ���� �̸�, �̸��� �����������Ͽ� ��ȸ
SELECT EMP_NAME �̸�, RPAD(EMAIL, 20) "�̸��� ���� ����"
FROM EMPLOYEE;

SELECT EMP_NAME �̸�, RPAD(EMAIL, 20, '#') �̸���
FROM EMPLOYEE;
SELECT EMP_NAME �̸�, LPAD(EMAIL, 20, '#') �̸���
FROM EMPLOYEE;

SELECT RPAD('000202-1', 14, '*') FROM DUAL;

-- ������� �����, �ֹι�ȣ ��ȸ ('XXXXXX-X******' �������� ��ȸ)
SELECT EMP_NAME �̸�, RPAD(SUBSTR(EMP_NO, 1, 8), LENGTH(EMP_NO), '*') "���� �ֹι�ȣ"
FROM EMPLOYEE;
-------------------------------------------------------------------------------
/*
    LTRIM / RTRIM : ���ڿ����� Ư�� ���ڸ� ������ �� �������� ��ȯ
    
    [ǥ����]
            LTRIM(���ڿ�|�÷�[, �����ϰ����ϴ� ���ڵ�]) ������ ���� ������ ���� ����
            RTRIM(���ڿ�|�÷�[, �����ϰ����ϴ� ���ڵ�]) ������ ���� ������ ���� ����
*/
SELECT LTRIM('        H I') FROM DUAL; -- ���ʺ���(�տ�������) �ٸ� ���ڰ� ���� ������ ���� ����
SELECT RTRIM('H I              ') FROM DUAL; -- �����ʺ��� �ٸ� ���ڰ� ���� ������ ���� ����(I�� ������)

SELECT LTRIM('321321HI123', '123') FROM DUAL;

SELECT LTRIM('KKHHII', '123') FROM DUAL;

/*
    TRIM : ���ڿ� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ �� ������ ���� ��ȯ

    [ǥ����]
            TRIM([LEADING | TRAILING | BOTH] [������ ����] FROM ���ڿ� | �÷�)
            * ������ ���� ���� �� ���� ����
            * �⺻ �ɼ��� BOTH(����)
*/
SELECT TRIM('   H I             ') FROM DUAL;
SELECT TRIM('L' FROM 'LLLLHLILLLLL') FROM DUAL;

SELECT TRIM(LEADING 'L' FROM 'LLLLHLILLLLL') FROM DUAL; -- LTRIM�� ������ ! (���ʿ��� ����)
SELECT TRIM(TRAILING 'L' FROM 'LLLLHLILLLLL') FROM DUAL; -- RTRIM�� ������ ! (�����ʿ��� ����)
SELECT TRIM(BOTH 'L' FROM 'LLLLHLILLLLL') FROM DUAL; -- ���ʿ��� ����

/*
    LOWER / UPPER / INITCAP
    
        - LOWER : ���ڿ��� ��� �ҹ��ڷ� �����Ͽ� ��ȯ
        - UPPER : ���ڿ��� ��� �빮�ڷ� �����Ͽ� ��ȯ
        - INITCAP : ���� �������� ù ���ڸ��� �빮�ڷ� �����Ͽ� ��ȯ
*/
-- 'I think so i am'
SELECT LOWER('I think so i am') FROM DUAL;

SELECT UPPER('I think so i am') FROM DUAL;

SELECT INITCAP('I think so i am') FROM DUAL;
----------------------------------------------------------------------------------
/*
    CONCAT : ���ڿ� �ΰ��� ���޹޾� �ϳ��� ��ģ �� ���ڿ� ��ȯ
    
    [ǥ����]
         CONCAT(���ڿ�1, ���ڿ�2)
*/
-- 'KH' ' L������' ���� �ΰ��� �ϳ��� ���ļ� ��ȸ
SELECT CONCAT('KH', ' L������') FROM DUAL;
SELECT 'KH' || ' L������' FROM DUAL;

SELECT '���ϴ�' || 23 FROM DUAL;

SELECT CONCAT(EMP_NAME, '��') FROM EMPLOYEE;
-- �����ȣ�� {�����}�� �� �ϳ��� ���ڿ��� ��ȸ => EX) "200�����ϴ�"
SELECT CONCAT(CONCAT(EMP_ID, EMP_NAME), '��') "�������" FROM EMPLOYEE;
------------------------------------------------------------------------------------------
/*
    REPLACE : Ư�� ���ڿ����� Ư�� �κ��� �ٸ� �κ����� ��ü�Ͽ� ���ڿ� ��ȯ
    
    [ǥ����]
        REPLACE(���ڿ�|�÷���, ã�����ڿ�, �����ҹ��ڿ�)
*/
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;

-- ��� ���̺��� �̸��� ���� ��  'or.kr' �κ��� 'kh.or.kr' ������ �����Ͽ� ��ȸ
SELECT REPLACE(EMAIL, '@or.kr', '@kh.or.kr') FROM EMPLOYEE;
-================================================================================
/*
    [ ���� Ÿ���� ������ ó�� �Լ� ]
*/
/*
    ABS : ������ ���밪�� �����ִ� �Լ�
*/
SELECT ABS(-10) "-10�� ���밪" FROM DUAL;

SELECT ABS(-7.7) "-7.7�� ���밪" FROM DUAL;
--------------------------------------------------------------------------------
/*
    MOD : �� ���� ���� ������ ���� �����ִ� �Լ�
    
    MOD(����1, ����2) --> ����1 % ����2 �� ���� ��
*/
-- 10�� 3���� ���� �������� ���غ��ٸ�
SELECT MOD(10, 3) FROM DUAL;

SELECT MOD(10.9, 3) FROM DUAL;
------------------------------------------------------------------------------------------------
/*
    ROUND : �ݿø��� ���� �����ִ� �Լ�
    
    ROUND(����[, ��ġ]) : ��ġ => �Ҽ��� N���� �ڸ�
*/
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, 3) FROM DUAL;

SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;
SELECT ROUND(123.456, -3) FROM DUAL;
--=> ��ġ���� ����� �����Ҽ��� �Ҽ��� �ڷ� ��ĭ�� �̵�, ������ �����Ҽ��� �Ҽ��� ���ڸ��� �̵�
------------------------------------------------------------------------------------------
/*
    CEIL : �ø�ó���� ���� �����ִ� �Լ�
    
    CEIL(����)
*/
SELECT CEIL(123.456) FROM DUAL; -- ��� : 124

/*
    FLOOR : ����ó���� ���� �����ִ� �Լ�
    
    FLOOR(����)
*/
SELECT FLOOR(123.456) FROM DUAL; -- ��� : 123

/*
    TRUNC : ����ó���� ���� �����ִ� �Լ�(��ġ ���� ����)
    
    TRUNC(����[, ��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL;    -- ��� : 123
SELECT TRUNC(123.456, 1) FROM DUAL; -- ��� : 123.4
SELECT TRUNC(123.456, -1) FROM DUAL;-- ��� : 120
-================================================================================
/*
    [��¥ ������ Ÿ�� ó�� �Լ�]
*/
-- SYSDATE : �ý����� ���� ��¥ �� �ð��� ��ȯ
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : �� ��¥ ������ ���� ���� ��ȯ
-- [ǥ����] MONTHS_BETWEEN(��¥A, ��¥B) : ��¥A - ��¥B => ���� �� ���
SELECT EMP_NAME, HIRE_DATE, CONCAT(CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)), '������') "�ټӰ�����"
FROM EMPLOYEE;

-- ���� �������� �� ���� ��..
SELECT CONCAT(CEIL(MONTHS_BETWEEN(SYSDATE, '24/06/11')), '������') FROM DUAL;

-- ������� ��� ������ '24/11/25'
SELECT CONCAT(FLOOR(MONTHS_BETWEEN('24/11/25', SYSDATE)), '���� ���Ҵ�.') FROM DUAL;

---------------

-- ADD_MONTHS : Ư�� ��¥�� N���� ���� ���ؼ� ��ȯ
-- [ǥ����] ADD_MONTHS(��¥, ���� ���� ��)

-- ���� ��¥�� ���� 4���� �� ��ȸ
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 4) "4���� ��" FROM DUAL;

-- ������̺��� �����, �Ի���, �Ի��� + 3���� "����������" ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) "����������"
FROM EMPLOYEE;

--------------
-- NEXT_DAY : Ư�� ��¥ ���� ���� ����� ������ ��¥�� ��ȯ
-- [ǥ����] NEXT_DAY(��¥, ����(����|����))
--    * 1 : �Ͽ���, 2 : ������, 3: ȭ����, 4: ������, 5: �����, 6: �ݿ���, 7: �����

-- ���� ��¥ ���� ���� ����� �ݿ����� ��¥ ��ȸ
SELECT NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;

-- ��� ���� : KOREAN / AMERICAN
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
---------------------------------------------
-- LAST_DAY : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
-- [ǥ����] LAST_DAY(��¥)

-- �̹��� ������ ��¥ ��ȸ
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- ������̺��� �����, �Ի���, �Ի��� ���� ��������¥, �Ի��� ���� �ٹ��ϼ� ��ȸ
SELECT EMP_NAME "�����", HIRE_DATE "�Ի���", LAST_DAY(HIRE_DATE) "�Ի��� ���� ������ ��¥",
LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;
----------------------------------
/*
    EXTRACT : Ư�� ��¥�κ��� �⵵/��/�� ���� �����ؼ� ��ȯ���ִ� �Լ�
    
    [ǥ����]
        EXTRACT(YEAR FROM ��¥) : ��¥���� �⵵�� ����
        EXTRACT(MONTH FROM ��¥) : ��¥���� ���� ����
        EXTRACT(DAY FROM ��¥) : ���ڿ��� �ϸ� ����
*/
-- ���� ��¥ ����, ����, ��, ���� ���� �����Ͽ� ��ȸ
SELECT SYSDATE
        , EXTRACT(YEAR FROM SYSDATE) "����"
        , EXTRACT(MONTH FROM SYSDATE) "��"
        , EXTRACT(DAY FROM SYSDATE) "��"
FROM DUAL;
-- ��� ���̺� �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ(+ �Ի�⵵>�Ի��>�Ի��� ������ �������� ����)
SELECT EMP_NAME, HIRE_DATE, EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵", EXTRACT(MONTH FROM HIRE_DATE) "�Ի��",
EXTRACT(DAY FROM HIRE_DATE) "�Ի���"
FROM EMPLOYEE
--ORDER BY �Ի�⵵ ASC, �Ի�� ASC, �Ի��� ASC;
ORDER BY 2, 3, 4;
--=============================================================================
/*
    ����ȯ �Լ� : ������Ÿ���� �������ִ� �Լ� 
        - ���� / ���� / ��¥
*/
/*
    TO_CHAR : ���� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ ��ȯ�����ִ� �Լ�
    
    [ǥ����]
        TO_CHAR(����|��¥[, ����])
*/
-- ����Ÿ�� --> ����Ÿ��
SELECT 1234 "����Ÿ���ǵ�����", TO_CHAR(1234) "���ڷ� ������ ������" FROM DUAL;
-- ���� Ÿ���� ������ ����, ����Ÿ���� ���� ���ķ� �⺻������ �Ǿ�����.

SELECT TO_CHAR(1234, '999999999') "���˵�����" FROM DUAL;
-- => '9' : ������ŭ �ڸ����� Ȯ��. ������ ����. ��ĭ�� �������� ä��.
 
SELECT TO_CHAR(1234, '00000000') "���˵�����" FROM DUAL;
-- => '0' : ������ŭ �ڸ����� Ȯ��. ������ ����. ��ĭ�� 0���� ä��.

SELECT TO_CHAR(1234, 'L9999999') "���˵�����" FROM DUAL;
-- => ���� ������ ������ ���� ȭ������� ���� ǥ��. ���� KOREAN�̹Ƿ� ��ȭ�� ǥ�õ�!

SELECT TO_CHAR(1234, '$99999999') "���˵�����" FROM DUAL;

SELECT TO_CHAR(1000000, 'L9,999,999') "���˵�����" FROM DUAL;

-- ������� �����, ����, ������ ��ȸ (ȭ�����, 3�ھ� �����Ͽ� ǥ�õǵ���)
SELECT EMP_NAME "�����", TO_CHAR(SALARY, 'L9,999,999')"����", 
TO_CHAR(SALARY*12, 'L99,999,999') "¬©�� ����"
FROM EMPLOYEE;
---------------------------------------------------------------------------------
-- ��¥Ÿ�� --> ����Ÿ��
SELECT SYSDATE, TO_CHAR(SYSDATE) "���ڷκ�ȯ" FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; --12�ð���
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- AM, PM : ����/�������� ǥ��(����ð� �������� ����)
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; --24�ð���
/*
    HH : �� ���� (HOUR)
        => HH24 : 24�ð���
    MI : �� ���� (MINUTE)
    SS : �� ���� (SECOND)
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY')
FROM DUAL;
-- DAY : �������� (X����) => '�Ͽ���', '������', ..., '�����'
-- DY : ��������(X) => '��', '��', 'ȭ, '��', ... '��'

SELECT TO_CHAR(SYSDATE, 'MON')FROM DUAL;
-- MON, MONTH : �� ���� (X��) => '1��', '2��', '3��', '4��', ... '12��'

-- ������̺��� �����, �Ի糯¥ ��ȸ (��, �Ի糯¥ ���� "XXXX�� XX�� XX��")
SELECT EMP_NAME "�����", TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') "�Ի糯¥"
FROM EMPLOYEE;
-- => ǥ���� ����(����)�� ū����ǥ("")�� ��� ����(����)�� �°� �����ؾ���
/* �⵵�� ���õ� ����
    YYYY : �⵵�� 4�ڸ��� ǥ�� -> 50�� ���� ���� ��¥�� 2000���� �ν� -> 205X
    YY   : �⵵�� 2������ ǥ��
    RRRR : �⵵�� 4�ڸ��� ǥ�� -> 50�� �̻��� 1900���� �ν� -> 195X
    RR   : �⵵�� 4�ڸ��� ǥ��
*/
/* ���� ���õ� ����
    MM : �� ������ 2�ڸ��� ǥ��
    MON / MONTH : �� ������ 'X��' �������� ǥ�� -> ��� ������ ���� �ٸ����� ����� 'JULY' 
*/
SELECT TO_CHAR(SYSDATE, 'MM') "���ڸ�ǥ��", TO_CHAR(SYSDATE, 'MON') "����ǥ��1"
, TO_CHAR(SYSDATE, 'MONTH') "����ǥ��2" FROM DUAL;

/* �ϰ� ���õ� ����
   DD : �� ������ 2�ڸ��� ǥ��
   DDD : �ش� ��¥�� �� �� ���� ���° �ϼ�
   D : �������� => ����Ÿ�� (1: �Ͽ���, ... , 7 : �����)
        -> DAY : "X����" ǥ��
           DY  : "X" ǥ�� '��', ... '��'
*/
SELECT TO_CHAR(SYSDATE, 'DD'), TO_CHAR(SYSDATE, 'DDD'), TO_CHAR(SYSDATE, 'D')
, TO_CHAR(SYSDATE, 'DAY'), TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
-------------------------------------------------------------------------------------------
/*
    TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ �����ϴ� �Լ�
    
    [ǥ����]
            TO_DATE(����|����[, ����]) => ��¥Ÿ��
*/
SELECT TO_DATE(20240719) FROM DUAL;
SELECT TO_DATE(240719) FROM DUAL; -->�ڵ����� 50�� �̸��� 20XX���� ����
SELECT TO_DATE(880719) FROM DUAL; --> �ڵ����� 50�� �̻��� 19XX���� ����

SELECT TO_DATE(020222) FROM DUAL; --> ���ڴ� 0���� �����ϸ� �ȵ�
SELECT TO_DATE('020222') FROM DUAL; --> 0�� ���۵Ǵ� ��� ����Ÿ������ ���� 

SELECT TO_DATE('20240719 104900' FROM DUAL; --> YYYYMMDD HHMISS �� ��쿡�� ������ �����ؾ� ��.
SELECT TO_DATE('20240719 104900', 'YYYYMMDD. HH24MISS') FROM DUAL;
----------------------------------------------------------------------------------
/*
    TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ��������ִ� �Լ�
    
    [ǥ����]
        TO_NUMBER(����[,����]; : ���ڿ� ���� ������ ���� (��ȣ�� ���Եǰų� ȭ������� ���ԵǴ� ���...)
*/
SELECT TO_NUMBER('01234567789') FROM DUAL;
SELECT '10000' + '500' FROM DUAL; -- �ڵ����� ���� => ���� Ÿ������ ��ȯ�Ǿ� ��� ���� �����
SELECT '10,000' + '500' FROM DUAL;
SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;
----------------------------------------------------------------------------------------
/*
    NULL ó�� �Լ�
*/
/*
    NVL: �ش� �÷��� ���� NULL�� ��� �ٸ� ������ ����� �� �ֵ��� ��ȯ���ִ� �Լ�
    
    [ǥ����]
            NVL(�÷�, �ش� �÷��� ���� NULL�� ��� ����� ��)
*/
-- ������̺��� �����, ���ʽ� ������ ��ȸ (��, ���ʽ� ���� NULL�� ��� 0���� ��ȸ
SELECT EMP_NAME, NVL(BONUS, 0) "���ʽ�"
FROM EMPLOYEE;

-- ��� ���̺��� �����, ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "���ʽ� ���� ����"
FROM EMPLOYEE;

/*
    NVL2 : �ش� �÷��� NULL�� ��� ǥ���� ���� �����ϰ�,
            NULL�� �ƴ� ���(�����Ͱ� ������ ���) ǥ���� ���� ����
            
    [ǥ����] 
        NVL2(�÷�, �����Ͱ� �����ϴ� ��� ����� ��, NULL�� ��� ����� ��)
*/
-- �����, ���ʽ� ����(O/X) ��ȸ
SELECT EMP_NAME, NVL2(BONUS, 'O', 'X')
FROM EMPLOYEE;

-- �����, �μ��ڵ�, �μ���ġ����('�����Ϸ�', '�̹���') ��ȸ
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') "�μ���ġ����"
FROM EMPLOYEE;

-- NULLIF : �� ���� ��ġ�ϸ� NULL, ��ġ���� �ʴ´ٸ� �񱳴��1 ��ȯ
-- [ǥ����] NULLIF(�񱳴��1, �񱳴��2)
SELECT NULLIF('999','999') FROM DUAL;
SELECT NULLIF('999','555') FROM DUAL;
