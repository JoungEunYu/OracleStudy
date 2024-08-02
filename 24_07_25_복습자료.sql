-- ���� ����� ���� ���� �� �Ʒ� ������ �ۼ����ּ���.
-- ID/PW  :  C##TESTUSER / 1234

-- 1) ������ �������� ����
-- 2) ����� ���� �߰� ������ ����
CREATE USER C##TESTUSER IDENTIFIED BY "1234";
-- 3) �߰��� ������ ���� ���� (�ּұ��� : ���� - CONNECT / ������ ���� - RESOURCE)
GRANT CONNECT, RESOURCE TO C##TESTUSER;

-- CHAR 2000B
-- VARCHAR2 4000B

-- �Ʒ� ������ �߰��ϱ� ���� ���̺��� �������ּ���.
-- �� �÷��� ������ �߰����ּ���.
--=========================================================
/*
	- �л� ���� ���̺� : STUDENT
	- ���� ����
	  - �л� �̸�, ��������� NULL���� ������� �ʴ´�.
	  - �̸����� �ߺ��� ������� �ʴ´�.
	- ���� ������
		+ �л� ��ȣ ex) 1, 2, 3, ...
		+ �л� �̸� ex) '�踻��', '�ƹ���', ...
		+ �̸���    ex) 'kim12@kh.or.kr', 'dogdog@kh.or.kr', ...
		+ �������  ex) '24/07/25', '00/02/20', '88/12/25', ...
*/
CREATE TABLE STUDENT (
    ST_NO NUMBER,
    ST_NAME VARCHAR2(100) NOT NULL,
    EMAIL VARCHAR2(100) UNIQUE, -- �÷��������
    BIRTH DATE NOT NULL
    
-- , UNIQUE(EMAIL) --���̺� ���� ���
);

COMMENT ON COLUMN STUDENT.ST_NO IS '�л� ��ȣ';
COMMENT ON COLUMN STUDENT.ST_NAME IS '�л� �̸�';
COMMENT ON COLUMN STUDENT.EMAIL IS '�̸���';
COMMENT ON COLUMN STUDENT.BIRTH IS '�������';

INSERT INTO STUDENT
    VALUES(1, '��ٿ�', 'KIDAWUN@KH.OR.KR', '95/04/01');
INSERT INTO STUDENT
    VALUES(2, NULL, 'INCHANG@KH.OR.KR', NULL); --> ST_NAME �÷��� NOT NULL ���࿡ �����
INSERT INTO STUDENT
    VALUES(3, '���ǿ�', 'KIDAWUN@KH.OR.KR', '99/09/28'); --> EMAIL �÷��� UNIQUE ���࿡ �����

DROP TABLE STUDENT;
------------------------------------------------------------
/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/
CREATE TABLE BOOK (
    BK_NO NUMBER,
    BK_TITLE VARCHAR(200) NOT NULL,
    BK_AUTHOR VARCHAR(20) NOT NULL,
    PUB_DATE DATE,
    ISBN VARCHAR(20) CONSTRAINT ISBN_UQ UNIQUE
);

COMMENT ON COLUMN BOOK.BK_NO IS '���� ��ȣ';
COMMENT ON COLUMN BOOK.BK_TITLE IS '���� ����';
COMMENT ON COLUMN BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN BOOK.PUB_DATE IS '������';
COMMENT ON COLUMN BOOK.ISBN IS '�Ϸ� ��ȣ';
DROP TABLE BOOK;

INSERT INTO BOOK
    VALUES(1, '�����', '�������丮', '24/07/25', '9780394502946');
INSERT INTO BOOK
    VALUES(2, '�����2', '�������丮', '34/07/25', '9780394502946');
COMMIT;
------------------------------------------------------------