.PHONY: all
all: run

config.json:
	@cp config.json.template config.json

.env: config.json
	@./scripts/host/gen/gen_env.sh

conf/nodes/%:
	@mkdir $@ && cp conf/templates/redis.conf $@/

.PHONY: install
install: .env
install: conf/nodes/1 conf/nodes/2 conf/nodes/3
install: conf/nodes/4 conf/nodes/5 conf/nodes/6
	@./scripts/host/bootstrap.sh

.PHONY: uninstall
uninstall:
	@docker compose down -v || true
	@rm -f config.json
	@rm -f .env
	@rm -rf conf/nodes/*/

.PHONY: run
run:
	@docker compose up -d

.PHONY: stop
stop: 
	@docker compose down

.PHONY: monitor
monitor:
	@./scripts/host/monitor.sh

.PHONY: logs
logs:
	@docker compose logs -f
