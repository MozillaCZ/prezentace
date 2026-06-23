export JEKYLL_ENV ?= production
HTML_PROOFER_OPTIONS_INDEX=--disable_external
HTML_PROOFER_OPTIONS_ALL=--disable_external --no_enforce_https --no_check_internal_hash --ignore_empty_alt --ignore_missing_alt --swap_attributes '{ "img": [["data-src", "src"]] }'
undefine BUNDLE_APP_CONFIG # let bundler use config from .bundle; in bash it would be 'unset BUNDLE_APP_CONFIG'

.DEFAULT_GOAL := all
.PHONY: all
all: prepare build check

.PHONY: prepare_raw
prepare_raw:
	gem install --user-install --quiet --silent bundler -v "~> 4.0"
	bundle install --quiet

.PHONY: prepare
prepare:
	bash ./scripts/run-in-container.sh make prepare_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: clean_raw
clean_raw:
	bundle exec jekyll clean $(JEKYLL_OPTIONS)

.PHONY: clean
clean:
	bash ./scripts/run-in-container.sh make clean_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: build_raw
build_raw: clean_raw
	JEKYLL_ENV='$(JEKYLL_ENV)' bundle exec jekyll build $(JEKYLL_OPTIONS)

.PHONY: build
build:
	bash ./scripts/run-in-container.sh make build_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: check_raw
check_raw:
	bundle exec htmlproofer _site/index.html $(HTML_PROOFER_OPTIONS_INDEX)
	bundle exec htmlproofer _site $(HTML_PROOFER_OPTIONS_ALL)

.PHONY: check
check:
	bash ./scripts/run-in-container.sh make check_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: run_raw
run_raw: clean_raw
	JEKYLL_ENV='$(JEKYLL_ENV)' bundle exec jekyll serve --host '0.0.0.0' $(JEKYLL_OPTIONS)

.PHONY: run
run:
	bash ./scripts/run-in-container.sh make run_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'
