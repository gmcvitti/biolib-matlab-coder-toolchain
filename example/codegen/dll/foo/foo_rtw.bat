@echo off

call C:\Users\gmcvi\Desktop\biolib-matlab-coder-toolchain\+biolib\..\emsdk\emsdk activate latest

cd .

if "%1"=="" ("C:\PROGRA~1\MATLAB\R2020a\bin\win64\gmake"  -j32 -f foo_rtw.mk all) else ("C:\PROGRA~1\MATLAB\R2020a\bin\win64\gmake"  -j32 -f foo_rtw.mk %1)
@if errorlevel 1 goto error_exit

exit 0

:error_exit
echo The make command returned an error of %errorlevel%
exit 1
