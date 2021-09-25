@echo off
setlocal enabledelayedexpansion
TITLE Batch Map Compiler

:: Custom directories if you don't want to manually put in your game directory
set customhladirectory=O:\Games\SteamLibrary\steamapps\common\Half-Life Alyx
set customsboxdirectory=
::set customsteamvrdirectory=
::set customdota2directory=

goto gamequestions

:gamequestions
:: Ask which game they're compiling for
echo What game are you compiling for?
echo 1: Half-Life: Alyx
echo (s^&box, SteamVR, and Dota 2 compiling will be supported soon.)
::echo 2: s^&box
::echo 3: SteamVR
::echo 4: Dota 2
echo.
set /P GameName=

if not defined GameName (
    echo.
    echo Please type something.
    echo.
    set "GameName="
    goto gamequestions
)

:: Go through the choices
if %GameName%==quit (goto end)
if %GameName%==1 (
    echo Half-Life: Alyx
    goto compileresolution
)
if %GameName%==2 (
    echo s^&box
    goto compileresolution
) 
::if %GameName%==3 (echo SteamVR)
::if %GameName%==4 (echo Dota 2)
:: Wrong number? Restart.
echo.
echo Unknown choice, please type 1 or 2
echo.
set "GameName="
goto gamequestions

:: Compiling settings for hla
:compileresolution

::Compile resolutions!
echo.
echo Please enter the compile resolution you would like to use.
echo 1: 512x512
echo 2: 1024x1024
echo 3: 2048x2048
echo 4: 4096x4096
echo 5: 8192x8192
echo 6: 16384x16384
echo.

set /P CompileResolution=

if %CompileResolution%==1 (
    set SetCompileRes=512
    goto gotogame
)
if %CompileResolution%==2 (
    set SetCompileRes=1024
    goto gotogame
)
if %CompileResolution%==3 (
    set SetCompileRes=2048
    goto gotogame
)
if %CompileResolution%==4 (
    set SetCompileRes=4096
    goto gotogame
)
if %CompileResolution%==5 (
    set SetCompileRes=8192
    goto gotogame
)
if %CompileResolution%==6 (
    set SetCompileRes=16384
    goto gotogame
)
echo.
echo Incorrect value given, please try again
goto compileresolution


:gotogame
:: Go through the choices again
if %GameName%==1 (goto compilehla)
if %GameName%==2 (goto compilesbox) 
::if %GameName%==3 (goto compilesteamvr)
::if %GameName%==4 (goto compiledota2)

:compilehla
:: Steam directory check
for /f "usebackq tokens=1,2,*" %%i in (`reg query "HKCU\Software\Valve\Steam" /v "SteamPath"`) do set "steampath=%%~k"
set steampath=%steampath:/=\%
if not exist "%steampath%\steam.exe" (echo Couldn't find the steam directory. Do you have it installed?)

:: Check if the steam directory has Half-Life: Alyx to make life easier.
if exist "%steampath%\steamapps\common\Half-Life Alyx\" (
    echo Found Half-Life Alyx inside of your Steam directory. Continuing..
	set "hla_dir=%steampath%\steamapps\common\Half-Life Alyx\"
) 
if defined customhladirectory (
    if exist "%customhladirectory%\game\bin\win64\resourcecompiler.exe" (
        echo Custom directory found.
        set "hla_dir=%customhladirectory%"
    ) else (
        echo You put in a custom directory but it didn't work.
        echo Restarting..
        goto compilehla
    )
) else (
    :: Uh oh! Didn't find it in the directory, manually have them put in the directory.
    echo.
    echo Couldn't find Half-Life: Alyx installed in the Steam directory.
    echo Please enter your Half-Life: Alyx directory here.
    echo.
    set /P "hla_dir="
)
if exist "%hla_dir%\game\bin\win64\resourcecompiler.exe" (
    echo Directory exists. Continuing...
    echo.
) else (
    echo Couldn't find the resourcecompiler in that directory.
    echo Restarting..
    goto compilehla
)

echo Please enter the directory to the maps folder that you want to compile.
set /P map_dir=

if not exist "%map_dir%" (
    echo That directory does not exist.. Restarting.
    goto compilehla
)

set /A numberofcompiles=0
for %%i in ("%map_dir%\*.vmap") do (
    set /A numberofcompiles=!numberofcompiles! + 1
    echo Starting compile !numberofcompiles!..
    start /WAIT call compile_map.bat %SetCompileRes% hla "%%i" "%hla_dir%"
    echo Done. Moving to the next map.
    echo.
)
echo.
echo All maps finished.
goto end

:compilesbox
:: Steam directory check

goto end

:compilesteamvr
:: TODO: Compiling settings for SteamVR
goto end

:compiledota2
:: TODO: Compiling settings for Dota 2
goto end

:end
pause
exit