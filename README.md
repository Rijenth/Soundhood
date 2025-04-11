# SoundHood

Une application composée d’un frontend Flutter et d’un backend Spring Boot, conçue pour gérer et afficher des événements géolocalisés en temps réel.

## 📦 Fonctionnalités principales

### Frontend Flutter

- Affichage d'une carte interactive (`flutter_map`)
- Connexion temps réel via WebSocket
- UI moderne avec SVG et icônes Font Awesome
- Architecture gérée avec `provider`

### Backend Spring Boot

- API REST construite avec Spring Boot 3.4.4
- Java 21
- Prête à être containerisée (Docker)
- Configuration Maven (`pom.xml`)

---

## 🚀 Lancer le projet

### 1. Lancer l'application Flutter

Assurez-vous d'avoir Flutter installé (SDK ≥ 3.7.2).

```bash
cd app
flutter pub get
flutter run
```

### 2. Lancer l'API Spring Boot

Assurez-vous d’avoir Java 21 et Maven installés.

```bash
cd api && docker-compose up -d --build
```

---

## 📁 Structure du projet

```
soundhood/
├── app/        # Application Flutter (frontend)
├── api/        # Application Spring Boot (backend)
```

---

## 📚 Dépendances clés

### Flutter

- `flutter_map`, `latlong2`
- `web_socket_channel`, `provider`
- `font_awesome_flutter`, `flutter_svg`

### Spring Boot

- Spring Web
- Spring Security
- Spring Data
- MySQL Connector

---

## 🧪 Tests

### Flutter

```bash
flutter test
```
