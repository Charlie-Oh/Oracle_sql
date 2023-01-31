DECLARE
--테이블의 컬럼의 데이터 자료형을 자동으로 매칭시켜 준다
--%TYPE키워드: 해당 변수에 자동으로 테이블의 컬럼의 자료형을 가져옴
--레퍼런스 변수 선언
VEMPNO EMP.EMPNO%TYPE;
VENAME EMP.ENAME%TYPE;
VDEPTNO DEPT.DEPTNO%TYPE;
VDNAME DEPT.DNAME%TYPE;
BEGIN
--여러 줄을 받는 쿼리문인 경우 에러, ROW값 1개만 받을 수 있다
SELECT E.EMPNO,E.ENAME,D.DEPTNO,D.DNAME
INTO VEMPNO,VENAME,VDEPTNO,VDNAME FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.ENAME='SMITH';
DBMS_OUTPUT.PUT_LINE('사번/이름/부서번호/부서명');
DBMS_OUTPUT.PUT_LINE('--------------------');
DBMS_OUTPUT.PUT_LINE(VEMPNO||'/'||VENAME||'/'||VDEPTNO||'/'||VDNAME); END;
/

DECLARE VNUM1 NUMBER:=1; VNUM2 NUMBER:=2;
BEGIN IF VNUM1>=VNUM2 THEN
DBMS_OUTPUT.PUT_LINE(VNUM1||'이(가)'||VNUM2||'보다 큰 수입니다.');
ELSE DBMS_OUTPUT.PUT_LINE(VNUM2||'이(가)'||VNUM1||'보다 큰 수입니다.');
END IF; END;
/

DECLARE V_SAL NUMBER:=0; V_DEPTNO NUMBER:=0;
BEGIN V_DEPTNO:=ROUND(DBMS_RANDOM.VALUE(10,30),-1);
SELECT MAX(SAL) AS SAL INTO V_SAL FROM EMP WHERE DEPTNO=V_DEPTNO;
DBMS_OUTPUT.PUT_LINE(V_SAL);
IF V_SAL BETWEEN 1 AND 1000 THEN DBMS_OUTPUT.PUT_LINE('낮음');
ELSIF V_SAL BETWEEN 1001 AND 2000 THEN DBMS_OUTPUT.PUT_LINE('중간');
ELSIF V_SAL BETWEEN 2001 AND 3000 THEN DBMS_OUTPUT.PUT_LINE('높음');
ELSE DBMS_OUTPUT.PUT_LINE('최상위'); END IF; END;
/

DECLARE V_SAL EMP.SAL%TYPE:=0; V_DEPTNO EMP.DEPTNO%TYPE:=0;
	V_COMM EMP.COMM%TYPE:=0;
BEGIN V_DEPTNO:=ROUND(DBMS_RANDOM.VALUE(10,30),-1);
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO = '||V_DEPTNO);
SELECT SAL,COMM INTO V_SAL,V_COMM FROM EMP
WHERE DEPTNO=V_DEPTNO AND ROWNUM=1;
DBMS_OUTPUT.PUT_LINE('V_SAL = '||V_SAL||', V_COMM = '||V_COMM);
IF V_COMM>0 AND V_COMM IS NOT NULL THEN
	IF V_COMM>100 THEN DBMS_OUTPUT.PUT_LINE('총 급여액(연봉+인센티브):'||
	(V_SAL+V_COMM)); END IF;
ELSE DBMS_OUTPUT.PUT_LINE('총 급여액(연봉+인센티브):'||V_SAL); END IF; END;
/


DECLARE VEMP EMP%ROWTYPE; ANNSAL NUMBER(7,2);
--%ROWYTYPE속성으로 로우를 저장할 수 있는 레퍼런스 변수 선언
BEGIN SELECT * INTO VEMP FROM EMP WHERE ENAME='SMITH';
--여러줄을 받는 쿼리문인 경우 에러, ROW값 1개만 받을 수 있다

IF(VEMP.COMM IS NULL) THEN VEMP.COMM:=0; END IF;
--변수를 테이블의 %ROWTYPE으로 하였기에 각 컬럼명으로 접근시에는 변수명.컬럼명으로 접근할 수 있다

ANNSAL:=VEMP.SAL*12+1.156+VEMP.COMM;
--소수점 둘째 자리수에서 반올림 됨

DBMS_OUTPUT.PUT_LINE('사번/이름/연봉');
DBMS_OUTPUT.PUT_LINE('------------------');
DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO||'/'||VEMP.ENAME||'/'||ANNSAL); END;
--자바 객체 개념과 유사
/


DECLARE VEMP EMP%ROWTYPE; VDNAME VARCHAR2(14);
BEGIN SELECT * INTO VEMP FROM EMP WHERE ENAME='SMITH';
IF(VEMP.DEPTNO=10) THEN VDNAME:='ACCOUNTING';
ELSIF(VEMP.DEPTNO=20) THEN VDNAME:='RESEARCH';
ELSIF(VEMP.DEPTNO=30) THEN VDNAME:='SALES';
ELSIF(VEMP.DEPTNO=40) THEN VDNAME:='OPERATIONS'; END IF; 
DBMS_OUTPUT.PUT_LINE('사번/이름/연봉');
DBMS_OUTPUT.PUT_LINE('------------------');
DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO||'/'||VEMP.ENAME||'/'||VDNAME); END;
/


DECLARE V_EMPNO NUMBER(4):=8888; V_DEPTNO NUMBER(2);
V_ENAME VARCHAR2(10):='XMAN'; V_JOB VARCHAR2(9); V_SAL NUMBER(7,2);
BEGIN V_DEPTNO:=20;
IF V_JOB IS NULL THEN V_JOB:='신입'; END IF;
IF V_JOB='신입' THEN V_SAL:=2000;
ELSIF V_JOB IN('MANAGER','ANALYST') THEN V_SAL:=3500;
ELSE V_SAL:=2500; END IF;
INSERT INTO EMP01(DEPTNO,EMPNO,ENAME,SAL,JOB)
VALUES(V_DEPTNO,V_EMPNO,V_ENAME,V_SAL,V_JOB); COMMIT;--자동커밋이 아님 END;
/


DECLARE V_TOTAL NUMBER:=14; V_MAX NUMBER:=10; V_ORDER BOOLEAN;
BEGIN V_ORDER:=NVL(V_TOTAL,1)>V_MAX;
DBMS_OUTPUT.PUT_LINE('BAL = '||
CASE WHEN V_ORDER THEN 'True' ELSE 'False' END); END;
/


DECLARE V_PI PLS_INTEGER; V_VC VARCHAR2(10); V_ORDER BOOLEAN;
BEGIN DBMS_OUTPUT.PUT_LINE('V_PI = '||V_PI);
DBMS_OUTPUT.PUT_LINE('V_VC = '||V_VC);
--값으로 TRUE,FALSE,NULL가능. BOOLEAN자료형은 DBMS_OUTPUT으로 바로 출력 불가
V_ORDER:=TRUE; --에러:V_ORDER:='TRUE';
--에러: DBMS_OUTPUT.PUT_LINE(V_ORDER);
DBMS_OUTPUT.PUT_LINE('BAL = '||CASE WHEN V_ORDER=TRUE THEN 'TRUE' WHEN
V_ORDER=FALSE THEN 'FALSE' ELSE 'NULL' END); END;
/


DECLARE N NUMBER:=1;
BEGIN LOOP DBMS_OUTPUT.PUT_LINE(N); N:=N+1; IF N>5 THEN
EXIT; -- BREAK의 기능을 함. END LOOP로 감.
END IF; END LOOP; END;
/


DECLARE K INT:=1;
BEGIN LOOP DBMS_OUTPUT.PUT_LINE(K); K:=K+1; EXIT WHEN K>10;
END LOOP; END;
/


DECLARE CNT NUMBER:=1; STAR VARCHAR2(10):=NULL;
BEGIN LOOP STAR:=STAR||'*'; CNT:=CNT+1;
DBMS_OUTPUT.PUT_LINE(STAR);
IF CNT>5 THEN EXIT; END IF; END LOOP; END;
/


BEGIN FOR N IN REVERSE 1..5 LOOP
DBMS_OUTPUT.PUT_LINE(N); END LOOP; END;
/


--DECLARE생략가능
BEGIN
--N:변수가 아닌 인덱스임
--IN 쿼리를 통해 참조는 가능하지만 직접 대입하여 값 변경 불가
FOR N IN 1..5 LOOP
--에러: N:=N+1;
DBMS_OUTPUT.PUT_LINE(N);
END LOOP;
END;
/


DECLARE VNUM NUMBER:=3;
BEGIN FOR I IN 1..9 LOOP
CONTINUE WHEN MOD(I,2)=0;
--CONTINUE:LOOP머리로 돌아감
DBMS_OUTPUT.PUT_LINE(I); END LOOP; END;
/


BEGIN FOR I IN 1..9 LOOP IF MOD(I,2)=0 THEN CONTINUE; END IF;
DBMS_OUTPUT.PUT_LINE(I); END LOOP; END;
/


DECLARE VDEPT DEPT%ROWTYPE;
BEGIN DBMS_OUTPUT.PUT_LINE('부서번호/부서명/지역명');
DBMS_OUTPUT.PUT_LINE('-----------------');
FOR CNT IN 1..4 LOOP --값이 한줄 리턴인 경우만 가능
SELECT DISTINCT*INTO VDEPT FROM DEPT WHERE DEPTNO=10*CNT;
DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO||'/'||VDEPT.DNAME||'/'||VDEPT.LOC);
END LOOP; END;
/


DECLARE N NUMBER:=1;
BEGIN WHILE N<=5 LOOP
DBMS_OUTPUT.PUT_LINE(N); N:=N+1; END LOOP; END;
/


BEGIN <<BUN>> FOR I IN 1..5 LOOP DBMS_OUTPUT.PUT_LINE(I);
FOR K IN 1..3 LOOP DBMS_OUTPUT.PUT_LINE(K); IF I=3 THEN EXIT BUN; 
END IF; END LOOP;
DBMS_OUTPUT.PUT_LINE('I하단부'); END LOOP; END;
/


DECLARE VNUM NUMBER:=2;
BEGIN <<GUBUN>> --라벨을 붙일수있다
FOR I IN 1..9 LOOP DBMS_OUTPUT.PUT_LINE(VNUM||'*'||I||' = '||VNUM*I);
IF VNUM<9 AND I=9 THEN VNUM:=VNUM+1;
DBMS_OUTPUT.PUT_LINE('');
GOTO GUBUN; --라벨로 돌아가기
ELSIF VNUM=9 AND I=9 THEN EXIT; END IF; END LOOP; END;
/


--(EVEN=짝수, ODD=홀수)
DECLARE VNUM NUMBER:=2;
BEGIN <<EVEN>> LOOP IF MOD(VNUM,2)=0 THEN
DBMS_OUTPUT.PUT_LINE(VNUM||'는 짝수'); VNUM:=VNUM+1;
ELSE GOTO ODD; END IF;
IF VNUM=10 THEN EXIT; END IF; END LOOP;

<<ODD>> LOOP IF MOD(VNUM,2)=1 THEN
DBMS_OUTPUT.PUT_LINE(VNUM||'는 홀수'); VNUM:=VNUM+1;
ELSE GOTO EVEN; END IF;
IF VNUM=10 THEN EXIT; END IF; END LOOP; END;
/