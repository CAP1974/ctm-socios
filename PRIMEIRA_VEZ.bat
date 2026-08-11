@echo off
cd /d "%~dp0"
set LOG=%~dp0publicar_log.txt
echo ---- CONFIGURACAO INICIAL DO REPOSITORIO ---- > "%LOG%"
echo Data: %date% %time% >> "%LOG%"
echo. >> "%LOG%"
echo ANTES de correr isto, crie o repositorio no GitHub: >> "%LOG%"
echo   github.com/new  ...  nome: ctm-socios  ...  Public  ...  Create >> "%LOG%"
echo   (NAO marque "Add a README file") >> "%LOG%"
echo. >> "%LOG%"

if exist ".git" goto jaexiste

git init >> "%LOG%" 2>&1
git config user.email "tatuzinho2011@proton.me" >> "%LOG%" 2>&1
git config user.name "CAP1974" >> "%LOG%" 2>&1
git branch -M main >> "%LOG%" 2>&1
git remote add origin https://github.com/CAP1974/ctm-socios.git >> "%LOG%" 2>&1
git add -A >> "%LOG%" 2>&1
git commit -m "dashboard socios: versao inicial" >> "%LOG%" 2>&1
git push -u origin main >> "%LOG%" 2>&1
if errorlevel 1 goto falhapush

echo. >> "%LOG%"
echo RESULTADO: ENVIADO PARA O GITHUB. >> "%LOG%"
echo. >> "%LOG%"
echo FALTA UM PASSO, no site do GitHub: >> "%LOG%"
echo   1. Abra github.com/CAP1974/ctm-socios >> "%LOG%"
echo   2. Settings, depois Pages >> "%LOG%"
echo   3. Source: "Deploy from a branch" >> "%LOG%"
echo   4. Branch: main  /  (root)  e carregar Save >> "%LOG%"
echo. >> "%LOG%"
echo Passados 1 a 2 minutos o link dos membros fica activo: >> "%LOG%"
echo   https://cap1974.github.io/ctm-socios/ >> "%LOG%"
echo. >> "%LOG%"
echo Daqui para a frente use apenas o PUBLICAR.bat. >> "%LOG%"
goto fim

:jaexiste
echo. >> "%LOG%"
echo Esta pasta ja esta ligada ao GitHub. Use o PUBLICAR.bat. >> "%LOG%"
goto fim

:falhapush
echo. >> "%LOG%"
echo ERRO: o envio falhou. >> "%LOG%"
echo Causas habituais: >> "%LOG%"
echo   - o repositorio ctm-socios ainda nao foi criado no GitHub >> "%LOG%"
echo   - o nome do repositorio nao e exactamente "ctm-socios" >> "%LOG%"
echo   - credenciais do GitHub por introduzir >> "%LOG%"

:fim
start notepad "%LOG%"
