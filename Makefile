BIN_DIR ?= ./bin
LINDERA_IPADIC_NEOLOGD_BUILDER_VERSION ?= $(shell cargo metadata --no-deps --format-version=1 | jq -r '.packages[] | select(.name=="lindera-ipadic-neologd-builder") | .version')

.DEFAULT_GOAL := build

clean:
	rm -rf $(BIN_DIR)
	rm -rf ./lindera-ipadic-*-neologd-*
	rm -rf ./mecab-ipadic-neologd-*
	cargo clean

format:
	cargo fmt

test:
	cargo test

build:
	cargo build --release
	mkdir -p $(BIN_DIR)
	cp -p ./target/release/lindera-ipadic-neologd $(BIN_DIR)

tag:
	git tag v$(LINDERA_IPADIC_NEOLOGD_BUILDER_VERSION)
	git push origin v$(LINDERA_IPADIC_NEOLOGD_BUILDER_VERSION)

publish:
ifeq ($(shell cargo show --json lindera-ipadic-neologd-builder | jq -r '.versions[].num' | grep $(LINDERA_IPADIC_NEOLOGD_BUILDER_VERSION)),)
	cargo package && cargo publish
endif
