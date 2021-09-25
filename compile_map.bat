@echo off
set CompileResolution=%1
set MapDirectory="%~3"
set "MapName=%MapDirectory:\=" & set MapName=%"
set MapName=%MapName:"=%
TITLE Compiling %MapName:"=%

::for /f "tokens=1-4 delims=/ " %%i in ("%date%") do (
::     set dow=%%h
::     set month=%%i
::     set day=%%j
::     set year=%%k
::)
::set datestr=%month%_%day%_%year%

if not exist "logs/" (mkdir logs)
::set filename=./logs/log-%datestr%-%MapName:.vmap=%.txt

::echo ==LOG FILE %datestr% == > %filename%

echo Compiling %MapName:"=% at %CompileResolution%x%CompileResolution%

O:\Games\SteamLibrary\steamapps\common\"Half-Life Alyx"\game\bin\win64\resourcecompiler.exe -fshallow -maxtextureres 256 -dxlevel 110 -quiet -unbufferedio -noassert -i %MapDirectory% -world -bakelighting -lightmapMaxResolution %CompileResolution% -vrad3 -lightmapDoWeld -lightmapVRadQuality 2 -lightmapLocalCompile -lightmapCompressionDisabled 0 -outroot ./logs/

exit