
BABEL = ./node_modules/.bin/babel

all: node

node: lib
	@mkdir -p node/assets/
	@rm -rf node/assets/*
	@cp -r lib/assets node/
	@for path in lib/*.js; do \
		file=`basename $$path`; \
		$(BABEL) "lib/$$file" > "node/$$file"; \
	done

docker:
	@if test "$(SLACK_SUBDOMAIN)" = "" || test "$(SLACK_API_TOKEN)" = ""; then echo "Need to set/export SLACK_SUBDOMAIN and SLACK_API_TOKEN" && exit 1; fi;
	docker build -t phpsp/slackin . && \
	docker run phpsp/slackin ./bin/slackin $$SLACK_SUBDOMAIN $$SLACK_API_TOKEN
