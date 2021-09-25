@echo off
set CompileResolution=%1
set MapDirectory="%~3"
set "MapName=%MapDirectory:\=" & set MapName=%"
set MapName=%MapName:"=%
TITLE Compiling %MapName:"=%

echo Compiling %MapName:"=% at %CompileResolution%x%CompileResolution%

O:\Games\SteamLibrary\steamapps\common\"Half-Life Alyx"\game\bin\win64\resourcecompiler.exe -fshallow -maxtextureres 256 -dxlevel 110 -quiet -unbufferedio -noassert -i %MapDirectory% -world -bakelighting -lightmapMaxResolution %CompileResolution% -vrad3 -lightmapDoWeld -lightmapVRadQuality 2 -lightmapLocalCompile -lightmapCompressionDisabled 0

exit