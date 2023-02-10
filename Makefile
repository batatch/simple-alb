
help: ## Show help
	@echo "make [opsitons]"
	@echo "options:"
	@grep -E '^[a-zA-Z_-\%]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  ## Build ALB.
	mkdir -p conf.d
	python bin/j2.pl src/default.conf.j2 alb.yml > conf.d/default.conf

up:     ## Start ALB.
	env DOCKER0_ADDRESS=$$( ip route | awk '/docker0/ {print $$9}' ) \
	docker-compose up -d

down:   ## Stop ALB.
	env DOCKER0_ADDRESS=$$( ip route | awk '/docker0/ {print $$9}' ) \
	docker-compose down

logs:   ## Show ALB logs.
	docker-compose logs

login:  ## Login to ALB.
	docker-compose exec alb bash

.PHONY: test
test:   ## Test ALB.
	sh test/run.sh 80 \
		app01.example.com \
		app02.example.com \
		unknown.example.com


# EOF
