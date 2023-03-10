DROP TABLE EMP01 PURGE;

CREATE TABLE EMP01 AS SELECT * FROM EMP WHERE DEPTNO=10;


MERGE INTO EMP01 A USING(SELECT EMPNO,SAL,JOB FROM EMP WHERE DEPTNO=10) B
ON(A.EMPNO=B.EMPNO) WHEN MATCHED THEN UPDATE SET A.SAL=SAL+SAL*0.01
WHEN NOT MATCHED THEN INSERT (A.EMPNO,SAL,JOB) VALUES(B.EMPNO,B.SAL,B.JOB);

ROLLBACK;

MERGE INTO EMP01 A USING(SELECT EMPNO,SAL,JOB FROM EMP WHERE DEPTNO=20) B
ON(A.EMPNO=B.EMPNO) WHEN MATCHED THEN UPDATE SET A.SAL=SAL+SAL*0.01
WHEN NOT MATCHED THEN INSERT (A.EMPNO,SAL,JOB) VALUES(B.EMPNO,B.SAL,B.JOB);

CREATE TABLE EMP01 AS SELECT * FROM EMP;

MERGE INTO (SELECT EMPNO,SAL,JOB FROM EMP01 WHERE DEPTNO=10)
A USING(SELECT EMPNO,SAL,JOB FROM EMP WHERE DEPTNO=20) B
ON(A.EMPNO=B.EMPNO) WHEN MATCHED THEN UPDATE SET A.SAL=SAL+SAL*0.01
WHEN NOT MATCHED THEN INSERT (A.EMPNO,SAL,JOB) VALUES(B.EMPNO,B.SAL,B.JOB);

MERGE INTO EMP01 A USING(SELECT EMPNO,SAL,JOB FROM EMP WHERE ENAME='KING' AND DEPTNO=10) B
ON(A.EMPNO=B.EMPNO) WHEN MATCHED THEN UPDATE SET A.SAL=8000 DELETE WHERE A.DEPTNO=10
WHEN NOT MATCHED THEN INSERT (A.EMPNO,SAL,JOB) VALUES(B.EMPNO,B.SAL,B.JOB);

SET SERVEROUTPUT ON

DECLARE
    --변수 선언
    var VARCHAR2(15);
BEGIN
    --코드 작성
    DBMS_OUTPUT.PUT_LINE('Hello Oracle~');
    SELECT '안녕 PL/SQL' INTO var
    FROM DUAL;
    --출력함수
    DBMS_OUTPUT.PUT(var||' ');
    DBMS_OUTPUT.PUT_LINE('hello');
    DBMS_OUTPUT.PUT_LINE('PL/SQL');
END;
/--SQLDEVELOPER에서는 생략 가능하지만 SQLPLUS에서는 생략불가. 실행하라는 의미


DECLARE
--변수선언
va INTEGER:=2**2*3**2;
vb POSITIVE:=5; --0미포함 양수
vc SIGNTYPE; -- -1,0,1,NULL만 가능
vd NATURALN := 0; --0포함 양수, NULL불가
ce constant VARCHAR2(20):='상수 테스트';
BEGIN
--실행부 DBMS_OUTPUT을 이용한 변수값 출력
--에러 ce:='상수값 변경';
DBMS_OUTPUT.PUT_LINE('va = '||VA||', vb = '|| vb ||', vc = '|| vc ||', vd = '|| vd);
DBMS_OUTPUT.PUT_LINE('va = '|| TO_CHAR(va));
DBMS_OUTPUT.PUT_LINE('상수 ce = '|| ce);
END;
/

DECLARE VEMPNO NUMBER(4); VENAME VARCHAR2(10);
BEGIN VEMPNO:=7788; VENAME:='SMITH';
DBMS_OUTPUT.PUT_LINE('사번 / 이름 / BOOLEAN');
DBMS_OUTPUT.PUT_LINE('--------------------------');
DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME); END;
/

--SET TIMING ON

DECLARE
   --테이블의 컬럼의 데이터타입과 일치시켜 주는 것이 좋다. 에러 예방
   --스칼라 변수 선언
   VEMPNO NUMBER(4);
   VENAME VARCHAR2(10);
   VDEPTNO NUMBER(2);
   VDNAME VARCHAR2(14);
BEGIN
   --테이블 안의 데이터를 받아오는 경우 select절 안에 into를 이용한다.
   --select절 컬럼의 데이터타입, 개수, 순서와 
   --INTO절의 변수의 데이터타입, 개수, 순서가 일치해야 한다.
   SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
   --변수 대소문자 구분 안 함.
   INTO vempno, vename , vdeptno , vdname -- INTO는 한줄만 가져올수있다.
   FROM EMP E, DEPT D
   WHERE E.DEPTNO = D.DEPTNO AND E.ENAME = 'SMITH';

   DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 부서번호 / 부서명'); 
   DBMS_OUTPUT.PUT_LINE('------------------------------------');
   DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME || ' / ' || VDEPTNO || ' / ' || VDNAME );
END;
/