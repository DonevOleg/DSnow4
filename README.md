# DSnow (Donev Snow) 🏂

Приложение за сноуборд ентусиасти, което показва снежна покривка по света в реално време,
намира хотели в радиус от избрана точка и включва идея за секция "Намери приятел за пътуване".

## Технологии

- **Frontend:** React + TypeScript (Vite)
- **Backend:** Node.js + Express + TypeScript
- **Данни за сняг:** [Open-Meteo](https://open-meteo.com/) (безплатен, без API ключ)
- **Данни за хотели:** [Geoapify Places API](https://www.geoapify.com/places-api/) (безплатен tier, изисква API ключ)

## Структура

```
DSnow/
├── client/   # React + TypeScript frontend
└── server/   # Node.js + TypeScript backend (проксира външните API-та)
```

## Стартиране локално

### 1. Сървър

```bash
cd server
npm install
cp .env.example .env   # сложи своя GEOAPIFY_API_KEY
npm run dev
```

Сървърът стартира на `http://localhost:4000`.

### 2. Клиент

```bash
cd client
npm install
npm run dev
```

Клиентът стартира на `http://localhost:5173`.

## Функционалности

### ❄️ Снежна покривка
Секция "Карта", която взима координати (или GPS позицията на потребителя) и показва
прогноза за снеговалеж/снежна покривка от Open-Meteo за избрана точка и околност.

### 🏨 Хотели в радиус
Секция "Хотели", която тегли hotel-и в радиус от 50 км около дадена точка чрез Geoapify Places API.

### 🤝 Намери приятел (идея / mock)
Статична секция с примерни (mock) профили на сноубордисти, показваща бъдеща идея за
matching функционалност — без реален backend към момента.

## 🖥️ Deploy на VPS (собствен сървър)

Изисквания на VPS-а: Ubuntu/Debian, Node.js 18+, Nginx, PM2.

### 1. Първоначална настройка на VPS-а (еднократно)

```bash
sudo apt update && sudo apt install -y nginx
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g pm2
```

### 2. Качване на проекта

```bash
sudo mkdir -p /var/www/dsnow
sudo chown $USER:$USER /var/www/dsnow
cd /var/www/dsnow
git clone https://github.com/ТВОЯ_ПОТРЕБИТЕЛ/DSnow.git .
```

### 3. Настройка на environment променливите

```bash
cp server/.env.example server/.env
nano server/.env   # сложи GEOAPIFY_API_KEY=...
```

Понеже клиентът и сървърът ще са на един и същ домейн (Nginx проксира `/api`), **не е нужно** да пипаш `client/.env` — `VITE_API_URL` може да остане празен.

### 4. Build и стартиране

```bash
bash deploy.sh
```

Това инсталира зависимостите, build-ва клиента и сървъра, и стартира сървъра чрез PM2 (`ecosystem.config.js`), за да работи постоянно и да се рестартира автоматично при рестарт на машината:

```bash
pm2 startup   # еднократно, за автостарт при reboot на сървъра
```

### 5. Настройка на Nginx

```bash
sudo cp nginx.conf.example /etc/nginx/sites-available/dsnow
sudo nano /etc/nginx/sites-available/dsnow   # смени server_name с твоя домейн/IP
sudo ln -s /etc/nginx/sites-available/dsnow /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

### 6. (По избор) SSL сертификат

```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d dsnow.yourdomain.com
```

### При бъдещи промени

```bash
cd /var/www/dsnow
git pull
bash deploy.sh
```

## 🚀 Deploy онлайн (Vercel + Render — алтернатива без VPS)

### Backend → Render.com (безплатно)

1. Push-ни проекта в GitHub
2. В [render.com](https://render.com) → **New → Web Service** → избери repo-то
3. Root Directory: `server`
4. Build Command: `npm install && npm run build`
5. Start Command: `npm start`
6. Добави Environment Variables:
   - `GEOAPIFY_API_KEY` = твоя ключ
   - `CLIENT_URL` = адреса на клиента (ще го попълниш след стъпка 2 по-долу)
7. Deploy → ще получиш адрес от вида `https://dsnow-server.onrender.com`

(В repo-то има готов `render.yaml`, така че Render може директно да разпознае конфигурацията.)

### Frontend → Vercel (безплатно)

1. В [vercel.com](https://vercel.com) → **Add New → Project** → избери същия repo
2. Root Directory: `client`
3. Framework Preset: Vite (разпознава се автоматично от `vercel.json`)
4. Environment Variable:
   - `VITE_API_URL` = адреса на backend-а от Render (напр. `https://dsnow-server.onrender.com`)
5. Deploy → ще получиш адрес от вида `https://dsnow.vercel.app`

### Финална стъпка

Върни се в Render → Environment → сложи `CLIENT_URL` = реалния Vercel адрес, за да работи CORS правилно. Redeploy на сървъра.

> Забележка: Render free tier "заспива" след неактивност — първата заявка след пауза може да отнеме ~30 сек.

## Roadmap (идеи за развитие)

- [ ] Реален matching алгоритъм за "Намери приятел"
- [ ] Регистрация / автентикация на потребители
- [ ] Запазване на любими планини/хотели
- [ ] Heatmap слой върху картата за снежна покривка
- [ ] PWA / офлайн режим

## Автор

Donev Media — [kote.digital](https://kote.digital)
cd client
npm install
npm run dev