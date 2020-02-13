BIN_DIR ?= ./bin
MECAB_IPADIC_NEOLOGD_DIR ?= ./mecab-ipadic-neologd
LINDERA_IPADIC_NEOLOGD_DIR ?= ./lindera-ipadic-neologd

ifeq ($(VERSION),)
  VERSION = $(shell cargo metadata --no-deps --format-version=1 | jq -r '.packages[] | select(.name=="lindera-ipadic-neologd-builder") | .version')
endif

clean:
	rm -rf $(BIN_DIR)
	rm -rf $(LINDERA_IPADIC_NEOLOGD_DIR)
	rm -rf ./lindera-ipadic-*-neologd-*.tar.bz2
	rm -rf $(MECAB_IPADIC_NEOLOGD_DIR)
	rm -rf ./mecab-ipadic-neologd-master.zip
	rm -rf ./mecab-ipadic-neologd-master
	cargo clean

format:
	cargo fmt

build:
	cargo build --release
	mkdir -p $(BIN_DIR)
	cp -p ./target/release/lindera-ipadic-neologd $(BIN_DIR)

mecab-ipadic-neologd-download:
ifeq ($(wildcard ./mecab-ipadic-neologd-master.zip),)
	curl -L https://github.com/neologd/mecab-ipadic-neologd/archive/master.zip > ./mecab-ipadic-neologd-master.zip
endif

mecab-ipadic-neologd-extract: mecab-ipadic-neologd-download
ifeq ($(wildcard ./mecab-ipadic-neologd-master/*),)
	unzip -o mecab-ipadic-neologd-master.zip
endif

mecab-ipadic-neologd-build: mecab-ipadic-neologd-extract
ifeq ($(wildcard ./mecab-ipadic-neologd-master/build/*),)
	./mecab-ipadic-neologd-master/bin/install-mecab-ipadic-neologd --create_user_dic -p $(CURDIR)/mecab-ipadic-neologd-master/tmp -y
endif

mecab-ipadic-neologd: mecab-ipadic-neologd-build
	$(eval IPADIC_VERSION := $(shell find ./mecab-ipadic-neologd-master/build/mecab-ipadic-*-neologd-* -type d | awk -F "-" '{print $$6"-"$$7}'))
	$(eval NEOLOGD_VERSION := $(shell find ./mecab-ipadic-neologd-master/build/mecab-ipadic-*-neologd-* -type d | awk -F "-" '{print $$NF}'))
ifeq ($(wildcard $(MECAB_IPADIC_NEOLOGD_DIR)/*),)
	cp -r ./mecab-ipadic-neologd-master/build/mecab-ipadic-$(IPADIC_VERSION)-neologd-$(NEOLOGD_VERSION) $(MECAB_IPADIC_NEOLOGD_DIR)
endif

lindera-ipadic-neologd-build: build mecab-ipadic-neologd
	$(BIN_DIR)/lindera-ipadic-neologd $(MECAB_IPADIC_NEOLOGD_DIR) $(LINDERA_IPADIC_NEOLOGD_DIR)

lindera-ipadic-neologd: lindera-ipadic-neologd-build
	tar -cvjf ./lindera-ipadic-$(IPADIC_VERSION)-neologd-$(NEOLOGD_VERSION).tar.bz2 $(LINDERA_IPADIC_NEOLOGD_DIR)

test:
	cargo test
