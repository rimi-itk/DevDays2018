THIS_DIR=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

default:
	@echo $(PWD)
	@echo $(THIS_DIR)
	@echo $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

start-test-server:
	@PATH="$(THIS_DIR)/vendor/bin:$(PATH)" $(THIS_DIR)/vendor/bin/selenium-server-standalone
	@echo "Open new shell and run `make run-tests`"

run-tests:
	$(THIS_DIR)/vendor/bin/behat $(filter-out $@,$(MAKECMDGOALS))

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
