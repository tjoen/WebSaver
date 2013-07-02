:: screensaver build script
::
::   %1  source content directory path
::   %2  output screensaver file path or caption file path or icon file path
::   %3  output screensaver file path or icon file path
::   %4  output screensaver file path


@ECHO OFF
@SETLOCAL


:: set vars
SET root=%~dp0..

:: projects
SET scrgen=ScrGen

:: paths
SET scrgen_exe=%root%\Binaries\%scrgen%.exe
SET scrgen_bat=%root%\Build\scrgen.bat

:: set args count
SET argc=0
FOR %%x IN (%*) DO SET /A argc+=1

:: set args
IF %argc%==1 (
	SET src=%~1
	SET /P out="Output screensaver file path: "
	CALL:trimext %out%
) ELSE IF %argc%==2 (
	SET src=%~1
	SET out=%~n2.scr
) ELSE IF %argc%==3 (
	SET src=%~1
	SET cap=%~2
	SET out=%~n3.scr
) ELSE IF %argc%==4 (
	SET src=%~1
	SET cap=%~2
	SET ico=%~3
	SET out=%~n4.scr
)

:: start build
@ECHO.
@ECHO Screensaver build started.

:: build scrgen if not exist
IF NOT EXIST %scrgen_exe% CALL %scrgen_bat%
@ECHO.

:: check paths exist
SET ERROR=0
CALL:checkexist %scrgen_exe% 
IF %ERROR% NEQ 0 EXIT /B

:: delete old output
IF DEFINED out CALL:trydelete %out%

:: run scrgen
@ECHO Starting %scrgen%...
@%scrgen_exe% %src% %cap% %ico% %out%
IF %ERRORLEVEL% NEQ 0 EXIT /B
@ECHO %scrgen% successfully finished.
@ECHO.

:: end build
@ECHO Screensaver build successfully completed.
GOTO:EOF


:trimext
	IF NOT [%~n1]==[] SET out=%~n1.scr
GOTO:EOF

:: delete file if exists
:trydelete
	IF EXIST %~1 DEL /Q %~1
GOTO:EOF

:: check file exists with error
:checkexist
	IF NOT EXIST %~1 (
		SET ERROR=1
		@ECHO File does not exist %~1
	)
GOTO:EOF