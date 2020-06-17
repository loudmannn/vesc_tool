@echo off
chcp 866 >nul
set PATH=%cd%\tools\Qt\Qt5.11.1\5.11.1\bin;%cd%\tools\wget\bin;%cd%\tools\7-Zip;%PATH%

echo ����� �ਯ� ᪠稢��� � ����ࠨ���� Qt5 ��� ᡮન �஥��...

echo ���稢���� Qt5...

SET downloadUrl=http://mechsys.ru/Qt.7z
SET zipFile=%~dp0tools\Qt-Static.7z

set /A maxbytesize=835724206
::set /A maxbytesize=1606762350
set /A minbytesize=0
IF EXIST %zipFile% (
	call :setsize %zipFile%
) ELSE (
	set /A size=0
)

::echo %size%

IF %size% EQU %minbytesize% (
	wget --no-check-certificate -O %zipFile% %downloadUrl% 
) ELSE (
	IF %size% LSS %maxbytesize% (
		wget --no-check-certificate --continue -O %zipFile% %downloadUrl% 
	) ELSE (
		echo ��娢 � Qt 㦥 ᪠砭...
	)
)

IF %size% EQU %maxbytesize% (
	IF EXIST "%~dp0tools\Qt\Qt5.11.1\5.11.1\bin" (
		echo ��娢 㦥 �ᯠ�����...
	) ELSE (
		echo ��ᯠ����� Qt5...
		7z x %zipFile% -o%~dp0tools
		IF EXIST "%~dp0tools\Qt\Qt5.11.1\5.11.1\bin" (
			echo ��ᯠ����� �����襭�...
		) ELSE (
			echo �� 㤠���� �ᯠ������ ��娢, 㤠��� %zipFile% � ������� ��� �ਯ� ������...
		)
	)
) ELSE (
	echo %zipFile% ���०���, 㤠��� ��� � ������� ��� �ਯ� ������
)


echo ����ன�� ���㦥���...
::echo %~dp0
set CURDIR=%~dp0
set "CURDIR=%CURDIR:\=/%"
set QT_PATH=%~dp0tools/Qt/Qt5.11.1/5.11.1
set QT_PATH_PRINT=%CURDIR%tools/Qt/Qt5.11.1/5.11.1
::echo %QT_PATH%
::copy NUL %QT_PATH%\bin\qt.conf
::CHCP 866& FindStr /? >%QT_PATH%\bin\qt.conf
echo [Paths]> %QT_PATH%\bin\qt.conf
echo Prefix = %QT_PATH_PRINT%>> %QT_PATH%/bin/qt.conf


echo ��ࢨ筠� ���䨣���� �஥��...
qmake -config release "CONFIG+=release_win build_free"

echo Qt5 Static �ᯥ譮 ᪠砭 � ����஥�...

echo ������ ���� ������� ��� ��室�
pause >NUL
exit /B

:setsize
set size=%~z1