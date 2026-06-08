# GitHub Actions Setup

Diese Pipeline baut automatisch das Docker Image und veröffentlicht es zu GitHub Container Registry (ghcr.io).

## Setup-Schritte

### 1. Container Registry aktivieren
Gehe zu **Settings → Packages and registries → GitHub Packages**:
- Stelle sicher, dass "GitHub Packages" aktiviert ist
- Konfiguriere die Berechtigungen (Standard ist OK)

### 2. Repository einrichten
Die Pipeline nutzt automatisch den `GITHUB_TOKEN`, kein separates Setup nötig!

### 3. Git Tags für Releases (optional)
Für semantische Versionierung Tags erstellen:
```bash
git tag v1.0.0
git push origin v1.0.0
```

## Wie die Pipeline funktioniert

### Trigger
- **Auf `main` Push**: Build + Push als `main` Tag
- **Release Tag** (v1.0.0): Build + Push mit `v1.0.0`, `1.0`, `1` Tags
- **Pull Requests**: Build ohne Push (nur Validierung)

### Optimierung durch Caching
- **GitHub Actions Cache** (gha): Speichert Docker Layer zwischen Runs
- **Multi-Stage Build**: Nur notwendige Layer werden gebaut
- Bei kleinen Änderungen: ~80% schneller durch gecachte Layer

### Sicherheit
- **Vulnerability Scan**: Trivy scannt das Image auf Sicherheitslücken
- **Ergebnisse** in GitHub Security Tab sichtbar

## Image verwenden

```bash
# Login (mit PAT oder GITHUB_TOKEN)
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

# Pullen
docker pull ghcr.io/${{ github.repository }}:latest

# Oder mit docker-compose.yml
services:
  app:
    image: ghcr.io/${{ github.repository }}:v1.0.0
```

## Umgebungsvariablen in der Pipeline

| Variable | Bedeutung |
|----------|-----------|
| `REGISTRY` | ghcr.io (GitHub Container Registry) |
| `IMAGE_NAME` | Automatisch aus Repository-Name |

## Troubleshooting

### Authentifizierung fehlgeschlagen?
- Prüfe: Settings → Actions → General → "Read and write permissions"
- Sollte auf "Read and write permissions" gesetzt sein

### Image wird nicht gepusht?
- Nur auf `main` Branch und bei Push (nicht bei PR)
- Prüfe: `.github/workflows/build-and-publish.yml` existiert?

### Layer Caching wirkt nicht?
- Ist normal beim ersten Run (kein Cache vorhanden)
- Ab dem 2. Run sollte Layer Cache verwendet werden
