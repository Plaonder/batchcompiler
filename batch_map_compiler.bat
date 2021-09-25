@echo off
TITLE Batch Map Compiler
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
echo.

if not defined GameName (
    echo.
    echo Please type something!
    echo.
    set "GameName="
    goto gamequestions
)

:: Go through the choices
if %GameName%==quit (goto end)
if %GameName%==1 (goto compilehla)
::if %GameName%==2 (goto compilesbox) 
::if %GameName%==3 (goto compilesteamvr)
::if %GameName%==4 (goto compiledota2)
:: Wrong number? Restart.
echo.
echo Unknown choice, please type 1 or 2
echo.
set "GameName="
goto gamequestions

:: Compiling settings for hla
:compilehla

:: Steam directory check
for /f "usebackq tokens=1,2,*" %%i in (`reg query "HKCU\Software\Valve\Steam" /v "SteamPath"`) do set "steampath=%%~k"
set steampath=%steampath:/=\%
if not exist "%steampath%\steam.exe" (echo Couldn't find the steam directory! Do you have it installed?)

:: Check if the steam directory has Half-Life: Alyx to make life easier.
if exist "%steampath%\steamapps\common\Half-Life Alyx\" (
    echo Found Half-Life Alyx inside of your Steam directory! Continuing..
	set "hla_dir=%steampath%\steamapps\common\Half-Life Alyx\"
) else (
    :: Uh oh! Didn't find it in the directory, manually have them put in the directory.
    echo.
    echo Couldn't find Half-Life: Alyx installed in the Steam directory.
    echo Please enter your Half-Life: Alyx directory here.
    echo.
    set /P "hla_dir="
)
echo Directory exists! Continuing...
echo.

echo Please enter the directory to the maps folder that you want to compile.
set /P map_dir=

if not exist "%map_dir%" (
    echo That directory does not exist.. Restarting.
    goto compilehla
)


for %%i in ("%map_dir%\*.vmap") do (
    echo Starting compile..
    start /WAIT call compile_map.bat 512 hla "%%i" "%hla_dir%"
    echo Done! Moving to the next map.
    echo.
)
echo.
echo All maps finished.
goto end

:compilesbox
:: TODO: Compiling settings for sbox
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