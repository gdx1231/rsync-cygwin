@echo off
setlocal enabledelayedexpansion

cygrunsrv.exe -R "rsync"
echo INSTALL rsync
set driver=%cd:~0,1%
set dir=%cd:~2%
set dir=%dir:\=/%
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do call set driver=%%driver:%%i=%%i%%
set path1=/cygdrive/%driver%%dir%

echo #%date% %time% > %cd%\etc\rsyncd.conf
set find=[PATH]
For /f "delims=" %%i in (%cd%\etc\rsyncd.conf.template) do (
	set a=%%i
	set a1=!a:%find%=%path1%!
	echo !a1! >>%cd%\etc\rsyncd.conf
)


set cmd=cygrunsrv.exe -I "rsync" -p %path1%/rsync.exe -a "--config=%path1%/etc/rsyncd.conf --daemon --no-detach" -f "Rsync daemon service"
echo %cmd%
%cmd%