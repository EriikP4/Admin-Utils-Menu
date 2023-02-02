@echo off
mode con:cols=43 lines=2
color 0C
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Solicitando privilegios de administrador...
	timeout 1 >nul
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
CHCP 1252 1>NUL
TITLE Admin Tools v0.3e
REM 	SI TU CUENTA DE ADMINISTRADOR TIENE OTRO NOMBRE, CÁMBIALO AQUÍ EN: "set ADMIN=-->Administrador<--"
	set ADMIN=Administrador & REM <<
:MENU_START
mode con:cols=49 lines=15
cls
echo +===============================================+
echo .             Utils Menu -- by Erik       v0.3e .
echo +===============================================+
echo .                                               .
echo .  1) Cuenta de administrador...                .
echo .                                               .
echo .  2) Herramientas...                           .
echo .                                               .
echo .  3) Asistencia remota                         .
echo .                                               .
echo .                                               .
echo .  x) Cerrar Menú                               .
echo .                                               .
echo +===============================================+
choice /C 123X /N /M ">"
if %ErrorLevel%==1 GoTo ADMIN_ACC
if %ErrorLevel%==2 GoTo TOOLS
if %ErrorLevel%==3 GoTo AYUDA_REMOTA
if %ErrorLevel%==4 exit

:ADMIN_ACC
mode con:cols=49 lines=20
cls
echo +===============================================+
echo .        Menú // Cuenta de administrador        .
echo +===============================================+
echo .                                               .
echo .  a) Activar cuenta                            .
echo .                                               .
echo .  d) Desactivar cuenta                         .
echo .                                               .
echo .                                               .
echo .  r) Conectarse vía RDP (rápido)               .
echo .                                               .
echo .  s) Cambiar de usuario                        .
echo .                                               .
echo .  c) Cerrar sesión                             .
echo .                                               .
echo .                                               .
echo .  b) Volver...                                 .
echo .                                               .
echo +===============================================+
choice /C ADRSCB /N /M ">"
if %ErrorLevel%==1 mode con:cols=70 lines=7 & cls & echo Activando cuenta de Administrador... & timeout 3 > nul & net user %ADMIN% /active:yes & timeout 1 > nul & goto ADMIN_ACC
if %ErrorLevel%==2 mode con:cols=70 lines=7 & cls & echo Desactivando cuenta de Administrador... & timeout 3 > nul & net user %ADMIN% /active:no & timeout 1 > nul & goto ADMIN_ACC
if %ErrorLevel%==3 mode con:cols=70 lines=7 & cls & echo Iniciando sesión remota... & timeout 1 > nul & start /wait data\admin_acc\connect.rdp && echo Sesión remota iniciada. & echo Se ha finalizado la sesión. & goto ACC_PROMPT
if %ErrorLevel%==4 echo Desconectando... & timeout 2 >nul & tsdiscon & goto ADMIN_ACC
if %ErrorLevel%==5 echo Desconectando... & timeout 2 >nul & logoff & exit
if %ErrorLevel%==6 goto MENU_START
:ACC_PROMPT
choice /C SN /N /M "¿Quieres desactivar la cuenta de administrador?"
if %ErrorLevel%==1 net user %ADMIN% /active:no & timeout 2 > nul & goto ADMIN_ACC
if %ErrorLevel%==2 timeout 2 >nul & goto ADMIN_ACC

:TOOLS
mode con:cols=49 lines=20
cls
echo +===============================================+
echo .             Menú // Herramientas              .
echo +===============================================+
echo .                                               .
echo .  1) Consola de comandos (CMD)                 .
echo .                                               .
echo .  2) Cuentas de usuario                        .
echo .                                               .
echo .  3) Editor de registro                        .
echo .                                               .
echo .  4) Editor de directivas locales              .
echo .                                               .
echo .                                               .
echo .  5) Administrador de tareas (elevado)         .
echo .                                               .
echo .                                               .
echo .  b) Volver...                                 .
echo .                                               .
echo +===============================================+
choice /C 12345B /N /M ">"
if %ErrorLevel%==1 cls && start data\tools\console & timeout 1 > nul & goto TOOLS
if %ErrorLevel%==2 cls & goto ASK_1
if %ErrorLevel%==3 cls & mode con:cols=41 lines=5 & echo Iniciando editor de registro (regedit)... & timeout 1 > nul & echo Esperando cierre... && start /wait regedit.exe & echo Volviendo al menú... & timeout 1 > nul & goto tools
if %ErrorLevel%==4 cls & mode con:cols=51 lines=5 & echo Iniciando editor de directivas de grupo (gpedit)... & timeout 1 > nul & start /wait gpedit.msc & echo Volviendo al menú... & timeout 1 > nul & goto tools
if %ErrorLevel%==5 cls & mode con:cols=41 lines=5 & echo Iniciando administrador de tareas con privilegios de administrador... & timeout 1 > nul & echo Esperando cierre... && start /wait taskmgr & echo Volviendo al menú... & timeout 1 > nul & goto tools
if %ErrorLevel%==6 cls & goto MENU_START
:ASK_1
mode con:cols=69 lines=2
echo ¿Quieres abrir el menú simple [s] o menú avanzado [a] (sólo WIN PRO)?
choice /C SA /N /M ">"
if %ErrorLevel%==1 cls & mode con:cols=55 lines=6 & echo Iniciando Panel de cuentas de usuario (netplwiz.exe)... & timeout 1 > nul & echo Esperando cierre... && start /wait netplwiz.exe & echo Volviendo al menú... & timeout 1 > nul & goto tools
if %ErrorLevel%==2 cls & mode con:cols=61 lines=6 & echo Iniciando Panel (avanzado) de cuentas de usuario (lusrmgr)... & timeout 1 > nul & start "" /wait %windir%\System32\lusrmgr.msc & echo Volviendo al menú... & timeout 1 > nul & goto tools

:AYUDA_REMOTA
mode con:cols=49 lines=19
cls
echo +===============================================+
echo .           Menú // Asistencia remota           .
echo +===============================================+
echo .                                               .
echo .  1) Solicitar ayuda (contraseña aleatoria)    .
echo .                                               .
echo .  2) Solicitar ayuda (contraseña manual)       .
echo .                                               .
echo .                                               .
echo .  3) Tutorial                                  .
echo .                                               .
echo .                                               .
echo .  4) Más opciones                              .
echo .                                               .
echo .                                               .
echo .  x) Volver...                                 .
echo .                                               .
echo +===============================================+
choice /C 1234X /N /M ">"
if %ErrorLevel%==1 cls & mode con:cols=49 lines=16 & erase /Q %USERPROFILE%\Desktop\Invitación.msrcincident && cls & cls & echo Generando invitación con contraseña aleatoria... & timeout 3 > nul & echo Esperando a que termine la sesión remota... & msra /saveasfile %USERPROFILE%\Desktop\Invitación & echo Sesión remota finalizada. & timeout 1 > nul & echo Volviendo al menú... & timeout 1 > nul & erase /Q %USERPROFILE%\Desktop\Invitación.msrcincident && cls & goto AYUDA_REMOTA
if %ErrorLevel%==2 cls & goto ASK_2
if %ErrorLevel%==3 cls & mode con:cols=171 lines=10 & echo ¿Cómo funciona? & timeout 1 > nul & echo 1. Selecciona "Solicitar ayuda", y se generará un archivo de invitación en tu escritorio. & timeout 3 > nul & echo 2. Envía el archivo por un servicio de mensajería instantánea (Telegram, WhatsApp, Discord, etc.), junto a la contraseña mostrada en la nueva ventana de escritorio remoto & timeout 5 > nul & echo 3. Dale explicaciones de tu problema al ayudante, o pídele que solicite acceso remoto. & timeout 3 > nul & echo 4. Cuando termines, cierra la sesión remota y habrás terminado. & timeout 3 > nul & cls & start /wait data\remote_assistance\warning.vbs & goto AYUDA_REMOTA
if %ErrorLevel%==4 cls & start /wait data\remote_assistance\info.vbs & timeout 2 > nul & echo Servicio de asistencia remota iniciado. & start /wait msra.exe & echo Volviendo al menú... & timeout 2 > nul & goto AYUDA_REMOTA
if %ErrorLevel%==5 cls & goto MENU_START
:ASK_2
cls
mode con:cols=70 lines=10
erase /Q %USERPROFILE%\Desktop\Invitación.msrcincident && cls
cls
echo Preparando invitación...
timeout 2 > nul
set /p PASS_KEY="Introduce una contraseña para la invitación: "
timeout 3 > nul
echo Generando una invitación con la contraseña "%PASS_KEY%"...
timeout 3 > nul
echo Sesión iniciada.
msra /saveasfile %USERPROFILE%\Desktop\Invitación %PASS_KEY%
echo Sesión remota finalizada.
timeout 1 > nul
echo Eliminando invitación...
timeout 1 > nul
echo Volviendo al menú...
timeout 1 > nul
erase /Q %USERPROFILE%\Desktop\Invitación.msrcincident && cls
goto AYUDA_REMOTA