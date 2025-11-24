REM Build script for testbed
@ECHO OFF
SetLocal EnableDelayedExpansion

REM Collect only files inside testbed/src
SET cFilenames=
FOR /R src %%f in (*.c) do (
    SET cFilenames=!cFilenames! %%f
)

SET assembly=testbed
SET compilerFlags=-g
SET includeFlags=-Isrc -I../engine/src/
SET linkerFlags=-L../bin/ -lengine
SET defines=-D_DEBUG -DKIMPORT

ECHO "Building %assembly%..."

clang ^
  -target x86_64-w64-windows-gnu ^
  %cFilenames% ^
  %compilerFlags% ^
  -o ../bin/%assembly%.exe ^
  %defines% %includeFlags% %linkerFlags%