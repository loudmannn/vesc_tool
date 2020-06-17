@echo off
chcp 866 >nul
set PATH=%cd%\tools\Qt\Qt5.11.1\5.11.1\bin;%cd%\tools\wget\bin;%cd%\tools\7-Zip;%PATH%

echo Данный скрипт скачивает и настраивает Qt5 для сборки проекта...

echo Скачивание Qt5...

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
		echo Архив с Qt уже скачан...
	)
)

IF %size% EQU %maxbytesize% (
	IF EXIST "%~dp0tools\Qt\Qt5.11.1\5.11.1\bin" (
		echo Архив уже распакован...
	) ELSE (
		echo Распаковка Qt5...
		7z x %zipFile% -o%~dp0tools
		IF EXIST "%~dp0tools\Qt\Qt5.11.1\5.11.1\bin" (
			echo Распаковка Завершена...
		) ELSE (
			echo Не удалось распаковать архив, удалите %zipFile% и запустите этот скрипт заново...
		)
	)
) ELSE (
	echo %zipFile% поврежден, удалите его и запустите этот скрипт заново
)


echo Настройка окружения...
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


echo Первичная конфигурация проекта...
qmake -config release "CONFIG+=release_win build_free"

echo Qt5 Static успешно скачан и настроен...

echo Нажмите любую клавишу для выхода
pause >NUL
exit /B

:setsize
set size=%~z1