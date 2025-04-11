# SoundHood

Une application Flutter simple utilisant une cartes interactive, WebSockets et une interface moderne.

## 📦 Fonctionnalités

- Affichage de cartes interactives avec `flutter_map`
- Gestion des événements via `WebSocket`
- Utilisation d’icônes SVG et Font Awesome
- Architecture basée sur `provider` pour la gestion d'état

## 🚀 Lancement du projet

Assurez-vous d'avoir Flutter installé (SDK ≥ 3.7.2).

### 1. Aller dans le dossier de l'application

```bash
cd app
```

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Lancer l'application

```bash
cd ./api && docker-compose up -d --build && cd ../app && flutter run
```

## 🧪 Tests

```bash
flutter test
```

## 📁 Ressources

Les assets utilisés dans l'application sont dans `lib/assets/`, incluant des images `.svg`, `.png`, et `.jpg`.

## 📚 Dépendances principales

- `flutter_map`
- `latlong2`
- `font_awesome_flutter`
- `flutter_svg`
- `web_socket_channel`
- `provider`
- `http`
