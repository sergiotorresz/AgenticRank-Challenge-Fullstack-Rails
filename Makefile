.PHONY: up down test logs console

up:
	docker compose up

down:
	docker compose down

test:
	docker compose run --rm web bin/rails test

logs:
	docker compose logs -f web

console:
	docker compose run --rm web bin/rails console
