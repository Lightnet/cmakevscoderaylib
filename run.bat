@echo off

:: Create a build directory
mkdir build 
:: Build from that directory so the build files are in one place
cd build && cmake .. 
:: Build the project
cmake --build .
cd ..
::chnage dir
cd bin
::start program app 
START /wait main.exe
pause