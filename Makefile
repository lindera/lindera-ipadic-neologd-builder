BIN_DIR ?= ./bin
MECAB_IPADIC_DIR ?= ./mecab-ipadic-neologd
LINDERA_IPADIC_NEOLOGD_DIR ?= ./lindera-ipadic-neologd
VERSION ?= 20200130

ifeq ($(VERSION),)
  VERSION = $(shell cargo metadata --no-deps --format-version=1 | jq -r '.packages[] | select(.name=="lindera-ipadic-builder") | .version')
endif

clean:
	rm -rf $(BIN_DIR)
	rm -rf $(LINDERA_IPADIC_NEOLOGD_DIR)
	rm ./lindera-ipadic-neologd-*.tar.bz2
	rm -rf $(MECAB_IPADIC_DIR)
	rm ./mecab-ipadic.tar.gz
	cargo clean

format:
	cargo fmt

build:
	cargo build --release
	mkdir -p $(BIN_DIR)
	cp -p ./target/release/lindera-ipadic-neologd $(BIN_DIR)

lindera-ipadic-neologd: build
	$(BIN_DIR)/lindera-ipadic-neologd $(MECAB_IPADIC_DIR) $(LINDERA_IPADIC_NEOLOGD_DIR)
	tar -cvjf ./lindera-ipadic-neologd-$(VERSION).tar.bz2 $(LINDERA_IPADIC_NEOLOGD_DIR)

test:
	cargo test
