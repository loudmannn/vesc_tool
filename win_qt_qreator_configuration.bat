@echo off
chcp 866 >nul
set PATH=%cd%\tools\wget\bin;%PATH%

echo ����� �ਯ� ����ࠨ���� QtCreator ��� ᡮન �஥��...

cd %~dp0tools\Qt\Qt5.11.1\Tools\QtCreator\share\qtcreator\QtProject\qtcreator

echo ������� १�ࢭ�� ����� 䠩���...

IF EXIST *.bckup (
		echo १�ࢭ�� ����� �������...
	) ELSE (
		copy toolchains.xml toolchains.xml.bckup
		copy qtversion.xml qtversion.xml.bckup
		copy debuggers.xml debuggers.xml.bckup

		copy %~dp0tools\QtCreatorXML\toolchains.xml toolchains.xml
		copy %~dp0tools\QtCreatorXML\qtversion.xml qtversion.xml
		copy %~dp0tools\QtCreatorXML\debuggers.xml debuggers.xml
	)

echo ��⠭���� ��ࠬ��஢...

set PROJECT_PATH=%~dp0
set "PROJECT_PATH=%PROJECT_PATH:\=/%"

fart -c -- *.xml "#PROJECT_PATH#" %PROJECT_PATH%


echo ���������� ��몠 QtCreator � ��७� �஥��...
set QT_CREATOR_BIN_PATH=%~dp0tools\Qt\Qt5.11.1\Tools\QtCreator\bin
echo %cd%
@mshta vbscript:Execute("Set x=CreateObject(""WScript.Shell"").CreateShortcut(""%~dp0\QtCreator.lnk""):x.TargetPath=""%QT_CREATOR_BIN_PATH%\qtcreator.exe"":x.HotKey=""CTRL+ALT+F"":x.Save():Close()")

echo QtCreator �ᯥ譮 ����஥�...

echo ������ ���� ������� ��� ��室�
pause >NUL
exit /B
