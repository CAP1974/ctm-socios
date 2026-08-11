@echo off
cd /d "%~dp0"
set LOG=%~dp0publicar_log.txt
set NOVOMAIL=tatuzinho2011@proton.me
set NOVONOME=CAP1974
echo ---- CORRIGIR AUTOR DOS COMMITS ---- > "%LOG%"
echo Data: %date% %time% >> "%LOG%"
echo. >> "%LOG%"

if not exist ".git" goto semrepo
if exist ".git\index.lock" del /f ".git\index.lock"

echo Identidade antiga: >> "%LOG%"
git log -1 --format="  %%an  %%ae" >> "%LOG%" 2>&1
echo. >> "%LOG%"

echo A definir a identidade global...
git config --global user.email "%NOVOMAIL%" >> "%LOG%" 2>&1
git config --global user.name "%NOVONOME%" >> "%LOG%" 2>&1
git config user.email "%NOVOMAIL%" >> "%LOG%" 2>&1
git config user.name "%NOVONOME%" >> "%LOG%" 2>&1

echo A reescrever o autor do commit...
git commit --amend --reset-author --no-edit >> "%LOG%" 2>&1
if errorlevel 1 goto falhaamend

echo A reenviar para o GitHub...
git push --force-with-lease >> "%LOG%" 2>&1
if errorlevel 1 goto falhapush

echo. >> "%LOG%"
echo Identidade nova: >> "%LOG%"
git log -1 --format="  %%an  %%ae" >> "%LOG%" 2>&1
echo. >> "%LOG%"
echo RESULTADO: AUTOR CORRIGIDO. >> "%LOG%"
echo. >> "%LOG%"
echo A partir de agora todos os commits usam %NOVOMAIL%, >> "%LOG%"
echo neste e nos outros repositorios. >> "%LOG%"
echo. >> "%LOG%"
echo NOTA: para o GitHub associar os commits a si, o email >> "%LOG%"
echo %NOVOMAIL% tem de estar na sua conta: >> "%LOG%"
echo   github.com/settings/emails  ...  Add email address >> "%LOG%"
echo Se nao o adicionar, os commits aparecem sem foto de perfil. >> "%LOG%"
echo. >> "%LOG%"
echo Este ficheiro so precisa de correr UMA vez. >> "%LOG%"
goto fim

:semrepo
echo ERRO: esta pasta nao esta ligada ao GitHub. >> "%LOG%"
goto fim

:falhaamend
echo. >> "%LOG%"
echo ERRO: nao foi possivel reescrever o commit. Nada alterado no GitHub. >> "%LOG%"
goto fim

:falhapush
echo. >> "%LOG%"
echo ERRO: o reenvio falhou. O commit local foi alterado mas o GitHub nao. >> "%LOG%"
echo Verifique a ligacao e volte a correr este ficheiro. >> "%LOG%"

:fim
start notepad "%LOG%"
