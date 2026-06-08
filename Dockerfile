# Multi-stage build für optimales Caching
FROM nginx:alpine

# Metadaten
LABEL org.opencontainers.image.title="Astro Planer"
LABEL org.opencontainers.image.description="PWA zur Berechnung optimaler Fotofenster für Milchstraßenfotografie"

# Kopiere nginx Konfiguration
COPY nginx.conf /etc/nginx/nginx.conf

# Kopiere statische Dateien
COPY index.html /usr/share/nginx/html/
COPY manifest.json /usr/share/nginx/html/
COPY sw.js /usr/share/nginx/html/
COPY icon.svg /usr/share/nginx/html/

# Expose Port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1
