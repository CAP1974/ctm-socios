@echo off
cd /d "%~dp0"
set LOG=%~dp0publicar_log.txt
echo ---- PUBLICAR DASHBOARD SOCIOS ---- > "%LOG%"
echo Data: %date% %time% >> "%LOG%"
echo. >> "%LOG%"

if not exist "index.html" goto semficheiro
if not exist ".git" goto semrepo
if exist ".git\index.lock" del /f ".git\index.lock"
git config user.email "tatuzinho2011@proton.me" >> "%LOG%" 2>&1
git config user.name "CAP1974" >> "%LOG%" 2>&1

echo A carimbar a nova versao...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0versao.ps1" >> "%LOG%" 2>&1
if errorlevel 1 goto falhaversao

echo A publicar no GitHub...
git add -A >> "%LOG%" 2>&1
git commit -m "dashboard socios: atualizacao" >> "%LOG%" 2>&1
git push >> "%LOG%" 2>&1
if errorlevel 1 goto falhapush

echo. >> "%LOG%"
echo RESULTADO: PUBLICADO COM SUCESSO. >> "%LOG%"
echo. >> "%LOG%"
echo O GitHub Pages demora 1 a 2 minutos a ficar no ar. >> "%LOG%"
echo Quando o membro abrir a pagina ve a faixa "Nova versao disponivel". >> "%LOG%"
echo Os dados dele NAO se perdem. >> "%LOG%"
goto fim

:semficheiro
echo. >> "%LOG%"
echo ERRO: nao existe index.html nesta pasta. Nada publicado. >> "%LOG%"
goto fim

:semrepo
echo. >> "%LOG%"
echo ERRO: esta pasta ainda nao esta ligada ao GitHub. >> "%LOG%"
echo Corra primeiro o PRIMEIRA_VEZ.bat. >> "%LOG%"
goto fim

:falhaversao
echo. >> "%LOG%"
echo ERRO: falhou o carimbo da versao. Nada publicado. >> "%LOG%"
goto fim

:falhapush
echo. >> "%LOG%"
echo ERRO: o envio para o GitHub falhou. Nada publicado. >> "%LOG%"
echo Verifique a ligacao a internet e as credenciais do GitHub. >> "%LOG%"

:fim
start notepad "%LOG%"
