REM Build script for engine
@ECHO OFF
SetLocal EnableDelayedExpansion 

REM Get a list of all the .c files in ENGINE
SET cFilenames=
FOR /R src %%f in (*.c) do (
    SET cFilenames=!cFilenames! %%f
)

SET assembly=engine

SET compilerFlags=-g -shared -Wvarargs -Wall -Werror
SET includeFlags=-Isrc -I"%VULKAN_SDK%/Include"
SET defines=-D_DEBUG -DKEXPORT -D_CRT_SECURE_NO_WARNINGS

REM ***** ADICIONE ESTA LINHA IMPORTANTÍSSIMA *****
SET LIB_PATH="%VULKAN_SDK%/Lib"

REM libs
SET linkerFlags=-luser32 -lvulkan-1

ECHO "Building %assembly%..."

clang -target x86_64-w64-windows-gnu ^
    %cFilenames% ^
    %compilerFlags% ^
    -o ../bin/%assembly%.dll ^
    -Wl,--out-implib,../bin/libengine.dll.a ^
    %defines% %includeFlags% -L%LIB_PATH% %linkerFlags%

