@echo off
TITLE Batch Map Compiler

goto gamequestions

:gamequestions
:: Ask which game they're compiling for
echo What game are you compiling for?
echo 1: Half-Life: Alyx
echo 2: s^&box
echo 3: SteamVR
echo 4: Dota 2
echo.
set /P GameName=
echo.

if not defined GameName (
    echo Please type something!
    set "GameName="
    goto gamequestions
)

:: Go through the choices
if %GameName%==quit (goto end)
if %GameName%==1 (goto compilehla)
if %GameName%==2 (goto compilesbox) 
if %GameName%==3 (goto compilesteamvr)
if %GameName%==4 (goto compiledota2)
:: Wrong number? Restart.
echo.
echo Unknown choice, please type 1 or 2
echo.
set "GameName="
goto gamequestions

:: Compiling settings for hla
:compilehla
for %%i in ("O:\Games\SteamLibrary\steamapps\common\Half-Life Alyx\content\hlvr_addons\industrial_discharge_2\maps\*.vmap") do (
    echo Starting compile..
    start /WAIT call compile_map.bat 2048 hla "%%i"
    echo Done! Moving to the next map.
    echo.
)
echo.
echo All maps finished.
goto end

:: TODO: Compiling settings for sbox
:compilesbox
echo s^&box compiling is not supported at the moment.
goto end

:: TODO: Compiling settings for SteamVR
:compilesteamvr
echo SteamVR compiling is not supported at the moment.
goto end

:: TODO: Compiling settings for Dota 2
:compiledota2
echo Dota 2 compiling is not supported at the moment.
goto end

:end
pause
::exit