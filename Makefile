BIN_DIR ?= ./bin
SOURCE_URL ?= https://github.com/neologd/mecab-ipadic-neologd/archive/master.zip
VERSION ?=

ifeq ($(VERSION),)
  VERSION = $(shell cargo metadata --no-deps --format-version=1 | jq -r '.packages[] | select(.name=="lindera-ipadic-neologd-builder") | .version')
endif

clean:
	rm -rf $(BIN_DIR)
	rm -rf ./lindera-ipadic-*-neologd-*
	rm -rf ./mecab-ipadic-neologd-*
	cargo clean

format:
	cargo fmt

build:
	cargo build --release
	mkdir -p $(BIN_DIR)
	cp -p ./target/release/lindera-ipadic-neologd $(BIN_DIR)

mecab-ipadic-neologd-download:
ifeq ($(wildcard ./mecab-ipadic-neologd-master.zip),)
	curl -L $(SOURCE_URL) > ./mecab-ipadic-neologd-master.zip
endif

mecab-ipadic-neologd-extract: mecab-ipadic-neologd-download
ifeq ($(wildcard ./mecab-ipadic-neologd-master/*),)
	unzip -o mecab-ipadic-neologd-master.zip
endif

mecab-ipadic-neologd-build: mecab-ipadic-neologd-extract
ifeq ($(wildcard ./mecab-ipadic-neologd-master/build/*),)
	./mecab-ipadic-neologd-master/bin/install-mecab-ipadic-neologd --create_user_dic -p $(CURDIR)/mecab-ipadic-neologd-master/tmp -y
endif

lindera-ipadic-neologd-build: build mecab-ipadic-neologd-build
	$(eval IPADIC_VERSION := $(shell find ./mecab-ipadic-neologd-master/build/mecab-ipadic-*-neologd-* -type d | awk -F "-" '{print $$6"-"$$7}'))
	$(eval NEOLOGD_VERSION := $(shell find ./mecab-ipadic-neologd-master/build/mecab-ipadic-*-neologd-* -type d | awk -F "-" '{print $$NF}'))
	$(BIN_DIR)/lindera-ipadic-neologd ./mecab-ipadic-neologd-master/build/mecab-ipadic-$(IPADIC_VERSION)-neologd-$(NEOLOGD_VERSION) lindera-ipadic-$(IPADIC_VERSION)-neologd-$(NEOLOGD_VERSION)

lindera-ipadic-neologd: lindera-ipadic-neologd-build
	tar -cvjf ./lindera-ipadic-$(IPADIC_VERSION)-neologd-$(NEOLOGD_VERSION).tar.bz2 ./lindera-ipadic-$(IPADIC_VERSION)-neologd-$(NEOLOGD_VERSION)

test:
	cargo test
