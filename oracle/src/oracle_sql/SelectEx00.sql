select * from emp;
select * from emp where empno = 7654;
select empno,ename,hiredate from emp where job='SALESMAN' order by empno;
select * from emp where empno=7900 or empno=7902;
select * from emp where empno not in (7900, 7902);
select * from emp where ename in ('SMITH','WARD');
select empno,ename,sal,job from emp where mgr=7698;
select empno,ename,sal from emp where hiredate>='81/12/01';