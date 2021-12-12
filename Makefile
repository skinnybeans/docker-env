.PHONEY: test-1
test-1:
	docker-compose run --rm alpine sh -c 'printenv'

.PHONEY: test-2
test-2:
	docker compose run --rm alpine sh -c 'printenv'