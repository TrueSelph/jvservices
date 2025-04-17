all: build delay up

build:
	docker compose build

delay:
	@sleep 2

up:
	@echo "Starting Jivas services."
	docker compose up -d mongo-init redis typesense

down:
	docker compose down

restart:
	@echo "Restarting services."
	docker compose restart mongo redis typesense

stop:
	@echo "Stopping services."
	docker compose stop mongo redis typesense

purge-graph:
	mongosh jaseci --eval "db.dropDatabase()"
	@make restart

destroy:
	@echo "Destroying services."
	docker compose down -v