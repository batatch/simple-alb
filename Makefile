
help: ## Show help
	@echo "make [opsitons]"
	@echo "options:"
	@grep -E '^[a-zA-Z_-\%]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build:  ## Build ALB.
	mkdir -p conf.d build
	python bin/y1.pl alb.yml > build/alb_y1.yml
	python bin/j2.pl src/default.conf.j2 build/alb_y1.yml > conf.d/default.conf

up:     ## Start ALB.
	env DOCKER0_ADDRESS=$$( ip route | awk '/docker0/ {print $$9}' ) \
	docker-compose up -d

debug:  ## Start ALB by debug mode.
	env DOCKER0_ADDRESS=$$( ip route | awk '/docker0/ {print $$9}' ) \
	docker-compose -f docker-compose.yml -f docker-compose.debug.yml up -d

down:   ## Stop ALB.
	env DOCKER0_ADDRESS=$$( ip route | awk '/docker0/ {print $$9}' ) \
	docker-compose down

logs:   ## Show ALB logs.
	docker-compose logs

login:  ## Login to ALB.
	docker-compose exec alb bash

.PHONY: test
test:   ## Test ALB.
	sh test/run.sh 80 app01.example.com
	sh test/run.sh 80 app02.example.com
	sh test/run.sh 80 app02.example.com/api/exec
	sh test/run.sh 80 unknown.example.com


# EOF
