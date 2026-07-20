#!/bin/bash
# Скрипт за deploy на DSnow на VPS.
# Пусни го от главната папка на проекта: bash deploy.sh

set -e

echo "== DSnow deploy =="

echo "-> Инсталиране на server dependencies и build..."
cd server
npm install
npm run build
cd ..

echo "-> Инсталиране на client dependencies и build..."
cd client
npm install
npm run build
cd ..

echo "-> Стартиране/рестартиране на сървъра чрез PM2..."
if pm2 describe dsnow-server > /dev/null 2>&1; then
  pm2 restart dsnow-server
else
  pm2 start ecosystem.config.js
fi
pm2 save

echo "== Готово =="
echo "Клиентският build е в client/dist — увери се, че Nginx sочи точно там."
echo "Провери статус с: pm2 status"
