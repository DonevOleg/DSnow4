## Running Locally

### 1. Server

```bash
cd server
npm install
cp .env.example .env   # add your GEOAPIFY_API_KEY
npm run dev
```

The server runs on `http://localhost:4000`.

### 2. Client

```bash
cd client
npm install
npm run dev
```

The client runs on `http://localhost:5173`.

## Features

### ❄️ Snow Coverage
A "Map" section that takes coordinates (or the user's GPS position) and shows a
snowfall/snow-coverage forecast from Open-Meteo for a chosen point and area.

### 🏨 Hotels Nearby
A "Hotels" section that fetches hotels within a 50 km radius of a given point using
the Geoapify Places API.

### 🤝 Find a Travel Buddy (concept / mock)
A static page with sample (mock) snowboarder profiles, showing a future matching
feature idea — no real backend logic yet.
