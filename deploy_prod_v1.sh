#!/bin/sh
#
# Deploy Script

# Project Deployer
PD_VERSION=0.1-GIT

# Colors
COLOR_OFF="\\033[0m"   # unsets color to term fg color
RED="\\033[0;31m"      # red
GREEN="\\033[0;32m"    # green
YELLOW="\\033[0;33m"   # yellow
MAGENTA="\\033[0;35m"  # magenta
CYAN="\\033[0;36m"     # cyan

APP_NAME="YOUR_PROJECT_NAME"
DEPLOYMENT_VERSION=`date +"%Y-%m-%d-%H-%M-%S"`

echo "\n${CYAN}DEPLOYING APP "$APP_NAME" TO PRODUCTION${COLOR_OFF}\n"

echo "${YELLOW}--->${COLOR_OFF} Positionnement dans le dossier your_project/releases" &&\
cd /home/path/to/your_project/releases || { echo "${RED}--->${COLOR_OFF} Un problème est survenu pendant le positionnement dans le projet. FIN"; exit 1; }

echo "${YELLOW}--->${COLOR_OFF} Récupération Git dans le dossier NEW" &&\
git clone ......../your_project.git NEW || { echo "${RED}--->${COLOR_OFF} Un problème est survenu pendant le clonage GIT. FIN"; exit 1; }

echo "${YELLOW}--->${COLOR_OFF} Déplacement entre répertoires" &&\
cd ..

echo "${YELLOW}--->${COLOR_OFF} Récupération des anciennes ressources uploadées" &&\
cp current/web/common/res/* releases/NEW/web/common/res/ -R

echo "${YELLOW}--->${COLOR_OFF} Application de la configuration YML PROD" &&\
cp releases/NEW/config/global.prod.yml releases/NEW/config/global.yml

echo "${YELLOW}--->${COLOR_OFF} Création du dossier upload PDF" &&\
mkdir releases/NEW/web/common/pdf

echo "${YELLOW}--->${COLOR_OFF} Réinitialisation du log" &&\
mkdir releases/NEW/log/ -p && touch releases/NEW/log/your_project.log

echo "${YELLOW}--->${COLOR_OFF} Back-up des précedentes versions" &&\
rm old2 && mv old old2
mv releases/NEW releases/$DEPLOYMENT_VERSION
mv current old && ln -s releases/$DEPLOYMENT_VERSION current

echo "${YELLOW}--->${COLOR_OFF} Attribution des droits sur le dossier current" &&\
# chown is not possible on this server with this login ID
chmod 775 current/ -R

echo "\n${GREEN}APP DEPLOYED!${COLOR_OFF}\n"

exit
