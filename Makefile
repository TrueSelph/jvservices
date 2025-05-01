# Usage:
# make up           # starts all services, without wppconnect-server
# make all 	  # starts all services, including wppconnect-server
# make up SERVICES="mongo typesense" # starts only specified services
# make wppconnect-server-up # starts wppconnect-server
# make build # builds all services, without wppconnect-server
# make wppconnect-server-build # to only-(re)build wppconnect-server
# make restart      # restarts all services
# make restart SERVICES="redis" # restarts only redis

# WPP_SERVER_REPO = https://github.com/wppconnect-team/wppconnect-server.git
WPP_SERVER_REPO = https://github.com/TrueSelph/wppconnect-server.git
WPP_SERVER_DIR = wppconnect-server

# By default do not include wppconnect-server in "generic" up/build/stop
DEFAULT_SERVICES = mongo mongo-init redis typesense
ALL_SERVICES = $(DEFAULT_SERVICES) wppconnect-server

# If SERVICES is empty, use default
ifeq ($(origin SERVICES), undefined)
  SERVICES := $(DEFAULT_SERVICES)
endif

all: wppconnect-server-build build delay wppconnect-server-up up

wppconnect-server-clone:
	@if [ ! -d $(WPP_SERVER_DIR) ]; then \
		echo "[INFO] Cloning WPPConnect-Server repository..."; \
		git clone $(WPP_SERVER_REPO) $(WPP_SERVER_DIR); \
	else \
		echo "[INFO] Updating WPPConnect-Server repository..."; \
		cd $(WPP_SERVER_DIR) && git pull; \
	fi

wppconnect-server-build: wppconnect-server-clone
	@echo "[INFO] Building wppconnect-server Docker image..."
	docker compose build wppconnect-server

wppconnect-server-up: wppconnect-server-build
	docker compose up -d wppconnect-server

wppconnect-server-stop:
	docker compose stop wppconnect-server

wppconnect-server-restart:
	docker compose restart wppconnect-server

build:
	@echo "[INFO] Running docker compose build for $(SERVICES)..."
	docker compose build $(SERVICES)

delay:
	@sleep 2

up:
	@echo "Starting Jivas services: $(SERVICES)"
	docker compose up -d $(SERVICES)

down:
	docker compose down

restart:
	@echo "Restarting services: $(SERVICES)"
	docker compose restart $(SERVICES)

stop:
	@echo "Stopping services: $(SERVICES)"
	docker compose stop $(SERVICES)

purge-graph:
	mongosh jaseci --eval "db.dropDatabase()"
	@make restart

destroy:
	@echo "Destroying services."
	docker compose down -v

clean-wpp-server:
	rm -rf $(WPP_SERVER_DIR)