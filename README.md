# Milchstraßen & Wetter Planer

Eine Progressive Web App zur Berechnung optimaler Fotofenster für Milchstraßenfotografie mit stündlicher Wolkenprognose.

## Features

- 📅 30-Tage Vorhersage für optimale Fotofenster
- 🌙 Mondphasen und Lichtverschmutzung berücksichtigung
- ☁️ Stündliche Wolkenprognose (Open-Meteo API)
- 📍 Interaktive Karte zur Ortsauswahl
- ⭐ PWA - Offline-Fähigkeit und App-Installation
- 📱 Responsive Design für Desktop & Mobile

## Installation mit Docker

### Vorbedingungen
- Docker & Docker Compose installiert

### Starten

```bash
docker-compose up -d
```

Die Anwendung läuft dann unter: **http://localhost**

### Stoppen

```bash
docker-compose down
```

## PWA Features

Die App ist als Progressive Web App konfiguriert:

- **Service Worker**: Offline-Funktionalität mit Cache-Strategie
- **Manifest**: App-Installation auf Android & iOS möglich
- **Icons**: Adaptive Icons für verschiedene Geräte
- **Caching-Strategie**: 
  - Service Worker & Manifest: Nicht gecacht (immer aktuell)
  - Static Assets (CSS, Fonts): 1 Jahr gecacht
  - HTML: Nicht gecacht

### Installation als App

**Android:**
1. Seite in Chrome öffnen
2. Menu → "Zum Startbildschirm hinzufügen"

**iOS (Safari):**
1. Seite öffnen
2. Share-Button → "Zum Startbildschirm"

## Konfiguration

Die nginx-Konfiguration (`nginx.conf`) bietet:
- Gzip-Kompression für schnelleres Laden
- Optimierte Cache-Header pro Dateityp
- SPA-Routing (alle Anfragen → index.html)
- HTTP/2 Support (wenn HTTPS aktiviert)

## Erweiterungen

### HTTPS/SSL hinzufügen

Erweitern Sie `docker-compose.yml`:

```yaml
volumes:
  - ./certs/cert.pem:/etc/nginx/certs/cert.pem:ro
  - ./certs/key.pem:/etc/nginx/certs/key.pem:ro
```

Und aktualisieren Sie `nginx.conf` mit einem HTTPS-Server-Block.

### Umweltvariablen

Passen Sie die Konfiguration in `docker-compose.yml` an:
- `TZ`: Timezone (Standard: Europe/Berlin)

## API-Integration

- **SunCalc**: Astronomische Berechnungen (CDN)
- **Open-Meteo**: Kostenlose Wettervorhersage
- **OpenStreetMap**: Karte via Leaflet (CDN)

## Performance-Optimierungen

- Service Worker cached kritische Ressourcen
- Gzip-Kompression auf dem Server
- Cache-Busting für Deployments
- Offline-Fallback-Seiten
