@echo off
chcp 866 >nul
echo ����ன�� ���㦥���...
::echo %cd%

set QTDIR = %cd%\tools\Qt\Qt5.11.1\5.11.1
set PATH=%cd%\tools\Qt\Qt5.11.1\5.11.1\bin;%cd%\tools\Qt\Qt5.11.1\Tools\mingw530_32\bin;%cd%\tools\7-Zip;%PATH%

echo ���ઠ...
rmdir /S /Q "%cd%\build\win\obj"
qmake -config release "CONFIG+=release_win build_free"
mingw32-make clean
mingw32-make -j2

echo ���ઠ �����襭�
echo ��娢 ����� �� ��� "build/win/vesc_tool_windows.zip"

cd ../..

echo ������ ���� ������� ��� ��室�
pause >NUL
exit /B