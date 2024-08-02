-- 다음 사용자 계정 접속 후 아래 내용을 작성해주세요.
-- ID/PW  :  C##TESTUSER / 1234

-- 1) 관리자 계정으로 접속
-- 2) 사용자 계정 추가 쿼리문 실행
CREATE USER C##TESTUSER IDENTIFIED BY "1234";
-- 3) 추가한 계정에 권한 설정 (최소권한 : 접속 - CONNECT / 데이터 관리 - RESOURCE)
GRANT CONNECT, RESOURCE TO C##TESTUSER;

-- CHAR 2000B
-- VARCHAR2 4000B

-- 아래 내용을 추가하기 위한 테이블을 생성해주세요.
-- 각 컬럼별 설명을 추가해주세요.
--=========================================================
/*
	- 학생 정보 테이블 : STUDENT
	- 제약 조건
	  - 학생 이름, 생년월일은 NULL값을 허용하지 않는다.
	  - 이메일은 중복을 허용하지 않는다.
	- 저장 데이터
		+ 학생 번호 ex) 1, 2, 3, ...
		+ 학생 이름 ex) '김말똥', '아무개', ...
		+ 이메일    ex) 'kim12@kh.or.kr', 'dogdog@kh.or.kr', ...
		+ 생년월일  ex) '24/07/25', '00/02/20', '88/12/25', ...
*/
CREATE TABLE STUDENT (
    ST_NO NUMBER,
    ST_NAME VARCHAR2(100) NOT NULL,
    EMAIL VARCHAR2(100) UNIQUE, -- 컬럼레벨방식
    BIRTH DATE NOT NULL
    
-- , UNIQUE(EMAIL) --테이블 레벨 방식
);

COMMENT ON COLUMN STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN STUDENT.ST_NAME IS '학생 이름';
COMMENT ON COLUMN STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN STUDENT.BIRTH IS '생년월일';

INSERT INTO STUDENT
    VALUES(1, '기다운', 'KIDAWUN@KH.OR.KR', '95/04/01');
INSERT INTO STUDENT
    VALUES(2, NULL, 'INCHANG@KH.OR.KR', NULL); --> ST_NAME 컬럼이 NOT NULL 제약에 위배됨
INSERT INTO STUDENT
    VALUES(3, '조건웅', 'KIDAWUN@KH.OR.KR', '99/09/28'); --> EMAIL 컬럼이 UNIQUE 제약에 위배됨

DROP TABLE STUDENT;
------------------------------------------------------------
/*
	- 도서 정보 테이블 : BOOK
	- 제약 조건
	  - 제목과 저자명은 NULL값을 허용하지 않는다.
	  - ISBN 번호는 중복을 허용하지 않는다.
	- 저장 데이터
	  + 도서 번호 ex) 1, 2, 3, ...
	  + 제목 ex) '삼국지', '어린왕자', '코스모스', ...
	  + 저자 ex) '지연', '생텍쥐페리', '칼 세이건', ...
	  + 출판일 ex) '14/02/14', '22/09/19', ...
	  + ISBN번호 ex) '9780394502946', '9780152048044', ...
*/
CREATE TABLE BOOK (
    BK_NO NUMBER,
    BK_TITLE VARCHAR(200) NOT NULL,
    BK_AUTHOR VARCHAR(20) NOT NULL,
    PUB_DATE DATE,
    ISBN VARCHAR(20) CONSTRAINT ISBN_UQ UNIQUE
);

COMMENT ON COLUMN BOOK.BK_NO IS '도서 번호';
COMMENT ON COLUMN BOOK.BK_TITLE IS '도서 제목';
COMMENT ON COLUMN BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN BOOK.PUB_DATE IS '출판일';
COMMENT ON COLUMN BOOK.ISBN IS '일련 번호';
DROP TABLE BOOK;

INSERT INTO BOOK
    VALUES(1, '어린왕자', '생텍쥐페리', '24/07/25', '9780394502946');
INSERT INTO BOOK
    VALUES(2, '어린왕자2', '생텍쥐페리', '34/07/25', '9780394502946');
COMMIT;
------------------------------------------------------------