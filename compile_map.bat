@echo off
set CompileResolution=%1
set GameName=%2
set MapDirectory="%~3"
set GameDirectory="%~4"
set "MapName=%MapDirectory:\=" & set MapName=%"
set MapName=%MapName:"=%
TITLE Compiling %MapName%

echo Compiling %MapName% at %CompileResolution%x%CompileResolution%

if %GameName%==hla (goto compilehla)
if %GameName%==sbox (goto compilesbox)
if %GameName%==steamvr (goto compilesteamvr)
if %GameName%==dota2 (goto compiledota2)
echo Incorrect game name given!
echo I messed up :^(
pause
goto end

:compilehla
%GameDirectory%\game\bin\win64\resourcecompiler.exe -fshallow -maxtextureres 256 -dxlevel 110 -quiet -unbufferedio -noassert -i %MapDirectory% -world -bakelighting -lightmapMaxResolution %CompileResolution% -vrad3 -lightmapDoWeld -lightmapVRadQuality 2 -lightmapLocalCompile -lightmapCompressionDisabled 0
goto end

:compilesbox
%GameDirectory%\bin\win64\resourcecompiler.exe -fshallow -maxtextureres 256 -dxlevel 110 -quiet -unbufferedio -noassert -i %MapDirectory% -world -bakelighting -lightmapMaxResolution %CompileResolution% -vrad3 -lightmapDoWeld -lightmapVRadQuality 2 -lightmapLocalCompile -lightmapUseAllThreads -lightmapCompressionDisabled 0 -phys -vis -nav -sareverb -sapaths -breakpad -nompi -nop4
goto end

:compilesteamvr
::TODO: Compiling settings for SteamVR
goto end

:compiledota2
::TODO: Compiling settings for SteamVR
goto end

:end
pause
exit