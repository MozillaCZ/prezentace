HTML_PROOFER_OPTIONS_INDEX=--disable_external
HTML_PROOFER_OPTIONS_ALL=--disable_external --no_enforce_https --no_check_internal_hash --ignore_empty_alt --ignore_missing_alt --swap_attributes '{ "img": [["data-src", "src"]] }'
undefine BUNDLE_APP_CONFIG # let bundler use config from .bundle; in bash it would be 'unset BUNDLE_APP_CONFIG'

.DEFAULT_GOAL := all
.PHONY: all
all: prepare build check

.PHONY: prepare
prepare:
	gem install bundler -v "~> 2.4"
	bundle install

.PHONY: clean
clean:
	bundle exec jekyll clean

.PHONY: build
build: clean
	JEKYLL_ENV=production bundle exec jekyll build

.PHONY: check
check:
	bundle exec htmlproofer _site/index.html $(HTML_PROOFER_OPTIONS_INDEX)
	bundle exec htmlproofer _site $(HTML_PROOFER_OPTIONS_ALL)

.PHONY: run
run: clean
	bundle exec jekyll serve

.PHONY: all_in_container
all_in_container:
	bash ./scripts/run-in-container.sh make all
