@echo off
chcp 866 >nul
set PATH=%cd%\tools\Qt\Qt5.11.1\5.11.1\bin;%cd%\tools\wget\bin;%cd%\tools\7-Zip;%cd%\tools\Qt\Qt5.11.1\Tools\mingw530_32\bin;%PATH%

echo Данный скрипт скачивает и настраивает Qt5 для сборки проекта...

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