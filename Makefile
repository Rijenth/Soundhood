ROOT_FOLDER := $(shell pwd)
DOCKER_COMPOSE := docker compose

.PHONY: back-up back-down app-up app-deps help

back-up:
	@echo "🔧 Démarrage de l'API avec Docker Compose..."
	@cd $(ROOT_FOLDER)/api && $(DOCKER_COMPOSE) up -d --build

back-down:
	@echo "🗑️ Arrêt et suppression des conteneurs Docker..."
	@cd $(ROOT_FOLDER)/api && $(DOCKER_COMPOSE) down -v

app-up:
	@echo "📱 Lancement de l'application Flutter..."
	@cd $(ROOT_FOLDER)/app && flutter run

app-deps:
	@echo "📦 Installation des dépendances Flutter..."
	@cd $(ROOT_FOLDER)/app && flutter pub get

help:
	@echo ""
	@echo "Commandes disponibles :"
	@echo "  🔧  make back-up     → Build & démarre Docker dans ./api"
	@echo "  🗑️  make back-down   → Stop & nettoie les conteneurs Docker dans ./api"
	@echo "  📱  make app-up      → Lance l'app Flutter dans ./app"
	@echo "  📦  make app-deps    → Installe les dépendances Flutter dans ./app"
	@echo "  🛠️  make help        → Affiche cette aide"
	@echo ""
