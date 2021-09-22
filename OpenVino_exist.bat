:: script to install all the dependencies of electron module
echo off
REM Setlocal EnableDelayedExpansion
:: Check if Python is installed
echo Dependency Checking Start....

python --version 2>NUL
if errorlevel 1 (
   echo ---------- Python is not installed
   echo ---------- start installing python
   echo ---------- Error^: Python is installing now with Python version 3.6.5  ^(64-bit^)
   echo ---------- IMPORTANT: As part of this installation, make sure you click the option to add the application to your PATH environment variable.
   Start /WAIT install_windows_setup\python-3.6.5-amd64.exe


    pip --version 2>NUL
    if errorlevel 1 (
        echo ---------- Error^: Pip is installing now with version 20.2.3
        python install_windows_setup\get-pip.py
        @REM pip install --upgrade pip
    )
    python -m pip install --upgrade pip


    echo ---------- Install requirements
    pip install -r counter\requirements.txt
    @REM cat counter\requirements.txt | xargs -n 1 pip install

)

for /f "delims=" %%V in ('python -V') do @set py_ver=%%V
    echo congrats, %py_ver% present  

@REM IF "3.6.5" EQU "%py_ver%" ( 
@REM     ECHO Suitable Python version
@REM ) ELSE ( 
@REM     ECHO Not suitable Python version
@REM     )

::::::::::: Python code limitation 
set py_min=3.0
set py_max=3.6.5

IF "%py_ver%" GEQ "%py_min%" (SET Cond1=1) ELSE (SET Cond1=0)
IF "%py_ver%" LEQ "%py_max%" (SET Cond2=1) ELSE (SET Cond2=0)
SET /A "ResultAND = %Cond1% & %Cond2%"
IF %ResultAND% EQU 1 (SET Comp1=1) ELSE (SET Comp1=0)

IF %Comp1% EQU 1 ( 
    ECHO %py_ver% is between %py_min% and %py_max% 
) ELSE ( 
    ECHO %py_ver% is NOT between %py_min% and %py_max% 
)

:: Which Version of OpenVino is present?
FOR /f "delims=" %%a in ('dir /s /b /a:d "C:\Program Files (x86)\IntelSWTools\openvino_2020.*"') do (
    set Full_foldername="%%~a"
    set Full_setupvars="%%~a\bin\setupvars.bat"
)

:: Which Version of OpenVino is present?
FOR /f "delims=" %%a in ('dir /s /b /a:d "C:\Program Files (x86)\Microsoft Visual Studio *"') do (
    set Full_MVS_foldername="%%~a"
)

:: Check openvino is installed
if not [%Full_foldername%]==[] (

   if exist %Full_foldername% (  REM Here if %Full_foldername% surround by [] then it won't generate the error where nothing is install.
      echo ---------- OpenVino setup is present ----------
    REM   start /WAIT /b %Full_setupvars%
    @REM   call %Full_setupvars%
      echo Permanently Set OpenVINO Environment Variables
      call "OpenVino_var.bat"
      ) 

) else (
        echo ---------- In Installation part ----------

        :: check if Microsoft Visual Studio 9.0 is installed
        if NOT [%Full_MVS_foldername%]==[] (
            if exist [%Full_MVS_foldername%] (
                echo ---------- Microsoft Visual Studio is Already installed   
                )
            ) else (
                echo ---------- Error^: Installing now with Microsoft Visual Studio 9.0
                Start /WAIT install_windows_setup\en_visual_studio_community_2015.exe
                Start /WAIT install_windows_setup\vs_Community_2017.exe
                Start /WAIT install_windows_setup\vs_community_2019.exe
            )

        :: check if cmake is installed or not
        cmake --version 2>NUL
        if errorlevel 1 (
            echo ---------- Error^: cmake is installing now with cmake version 3.18.1
            start /WAIT install_windows_setup\cmake-3.18.1-win64-x64.msi
            REM call install_windows_setup\cmake-3.18.1-win64-x64.msi

        ) else (
            echo ---------- cmake is Already installed
            )
        echo ---------- start installing openvino setup and it's dependencies
        start /WAIT install_windows_setup\w_openvino_toolkit_p_2020_1_033.exe
        @REM call "c:\Program Files (x86)\IntelSWTools\openvino_2020.1.033\bin\setupvars.bat"
        echo Permanently Set OpenVINO Environment Variables
        call "OpenVino_var.bat"
      )

:: check MongoDB is installed or not, If not then install.
if exist "C:\Program Files\MongoDB" (
    echo ---------- MongoDB is already installed   
      
) else (
    echo ---------- Error^: Installing now MongoDB
    Start /WAIT /b install_windows_setup\mongodb-windows-x86_64-4.4.0-signed.msi
    REM call install_windows_setup\mongodb-windows-x86_64-4.4.0-signed.msi
)

:: check NodeJS is installed or not, If not then installed it.
node -v 2>NUL
if errorlevel 1 (
   echo ---------- Error^: NodeJS is installing now
       start /WAIT /b install_windows_setup\node-v10.15.3-x64.msi
    REM call install_windows_setup\node-v10.15.3-x64.msi
)
   
:: update lastest version of npm
echo ---------- Error^: npm is installing now
REM start /WAIT /b npm install npm@latest -g
call npm install -g npm@latest 

:: Dependencies installation for electron.
echo ---------- Error^: electron is installing now
REM start /WAIT /b npm install electron --save-dev
REM call npm install --save-dev electron

REM start /WAIT /b npm install -g electron
call npm install -g electron


@REM goto :eof


@REM :eof
echo End of Installation
REM cls
exit