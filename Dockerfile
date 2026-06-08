FROM nginx:alpine

LABEL org.opencontainers.image.title="Astro Planer"
LABEL org.opencontainers.image.description="PWA zur Berechnung optimaler Fotofenster für Milchstraßenfotografie"

# Kopiere die minimale Nginx-Konfiguration
COPY nginx.conf /etc/nginx/nginx.conf

# Kopiere die statischen PWA-Dateien
COPY index.html /usr/share/nginx/html/
COPY manifest.json /usr/share/nginx/html/
COPY sw.js /usr/share/nginx/html/
COPY icon.svg /usr/share/nginx/html/

# Port 80 für das interne Docker-Netzwerk öffnen
EXPOSE 80
