.PHONY: help 

help: ## Show this help.
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

run_cov: ## Run coverage tests and open the report
	@echo "Running coverage tests..."
	@flutter test --coverage
	@lcov --remove coverage/lcov.info 'lib/core/http_client/dio_client.dart' -o coverage/lcov.info
	@genhtml coverage/lcov.info -o coverage/html
	@open coverage/html/index.html
	@echo "Coverage tests done!"