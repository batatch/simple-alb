
all:
	@echo "make [opsitons]"
	@echo "options:"
	@echo "    up       Start ALB."
	@echo "    down     Stop ALB."
	@echo "    build    Build setting file."
	@echo "    test     Testing"

up:
	env DOCKER0_ADDRESS=$$( ip route | awk '/docker0/ {print $$9}' ) \
	docker-compose up -d

down:
	env DOCKER0_ADDRESS=$$( ip route | awk '/docker0/ {print $$9}' ) \
	docker-compose down

build:
	mkdir -p conf.d
	python bin/j2.pl src/default.conf.j2 alb.yml > conf.d/default.conf

.PHONY: test
test:
	sh test/run.sh 80 \
		app01.example.com \
		app02.example.com \
		unknown.example.com


# EOF
