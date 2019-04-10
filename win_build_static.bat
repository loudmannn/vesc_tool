@echo off
chcp 866 >nul
echo Настройка окружения...
::echo %cd%

set QTDIR = %cd%\tools\Qt\Qt5.11.1\5.11.1
set PATH=%cd%\tools\Qt\Qt5.11.1\5.11.1\bin;%cd%\tools\Qt\Qt5.11.1\Tools\mingw530_32\bin;%cd%\tools\7-Zip;%PATH%

echo Сборка...
rmdir /S /Q "%cd%\build\win\obj"
qmake -config release "CONFIG+=release_win build_free"
mingw32-make clean
mingw32-make -j2

echo Сборка завершена
echo Архив лежит по пути "build/win/vesc_tool_windows.zip"

cd ../..

echo Нажмите любую клавишу для выхода
pause >NUL
exit /B