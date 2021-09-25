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

:: Edit this if you want to change the Half-Life: Alyx compile settings
:compilehla
%GameDirectory%\game\bin\win64\resourcecompiler.exe -fshallow -maxtextureres 256 -dxlevel 110 -quiet -unbufferedio -noassert -i %MapDirectory% -world -bakelighting -lightmapMaxResolution %CompileResolution% -vrad3 -lightmapDoWeld -lightmapVRadQuality 2 -lightmapLocalCompile -lightmapCompressionDisabled 0
goto end

:: Edit this if you want to change the s&box compile settings
:compilesbox
%GameDirectory%\bin\win64\resourcecompiler.exe -fshallow -maxtextureres 256 -dxlevel 110 -quiet -unbufferedio -noassert -i %MapDirectory% -world -bakelighting -lightmapMaxResolution %CompileResolution% -vrad3 -lightmapDoWeld -lightmapVRadQuality 2 -lightmapLocalCompile -lightmapUseAllThreads -lightmapCompressionDisabled 0 -phys -vis -nav -sareverb -sapaths -breakpad -nompi -nop4 -outroot %GameDirectory%\addons
goto end

:compilesteamvr
%GameDirectory%\tools\steamvr_environments\game\bin\win64\resourcecompiler.exe -fshallow -maxtextureres 256 -dxlevel 110 -quiet -unbufferedio -noassert -i %MapDirectory% -world -bakelighting -lightmapMaxResolution %CompileResolution% -vrad3 -lightmapDoWeld -lightmapVRadQuality 2 -lightmapLocalCompile -lightmapCompressionDisabled 0 -phys -vis -breakpad -nompi -nop4
goto end

:compiledota2
::TODO: Compiling settings for SteamVR
goto end

:end
exit