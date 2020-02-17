# Lindera IPADIC NEologd Builder

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Join the chat at https://gitter.im/lindera-morphology/lindera](https://badges.gitter.im/lindera-morphology/lindera.svg)](https://gitter.im/lindera-morphology/lindera?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

IPADIC NEologd dictionary builder for [Lindera](https://github.com/lindera-morphology/lindera). This project fork from fulmicoton's [kuromoji-rs](https://github.com/fulmicoton/kuromoji-rs).

## Install

```
% cargo install lindera-ipadic-neologd-builder
```

## Build

The following products are required to build:

- Rust >= 1.39.0
- make >= 3.81
- mecab >= 0.996 (for building a dictionary)

```text
% make lindera-ipadic-neologd
```

## Dictionary version

This repository only tested data of [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd).

*NOTE* : This builder skip 2 words, `カブシキガイシャ` and `タカラヅカカゲキダンキセイ`, to avoid dictionary build failure.
These words are `SKIP_WORDS` in `src/lib.rs` .

## Building a dictionary

Building a dictionary with `lindera-ipadic-neologd` command:
```
 % ./bin/lindera-ipadic-neologd ./mecab-ipadic-neologd-master/build/mecab-ipadic-2.7.0-20070801-neologd-20200130 ./lindera-ipadic-2.7.0-20070801-neologd-20200130
```

## Tokenizing text using produced dictionary

You can tokenize text using produced dictionary with `lindera` command:

```
% echo "羽田空港限定トートバッグ" | lindera -d ./lindera-ipadic-2.7.0-20070801-neologd-20200130
羽田空港        名詞,固有名詞,一般,*,*,*,羽田空港,ハネダクウコウ,ハネダクーコー
限定    名詞,サ変接続,*,*,*,*,限定,ゲンテイ,ゲンテイ
トートバッグ    名詞,固有名詞,一般,*,*,*,トートバッグ,トートバッグ,トートバッグ
EOS
```

For more details about `lindera` command, please refer to the following URL:

- [Lindera CLI](https://github.com/lindera-morphology/lindera-cli)

## API reference

The API reference is available. Please see following URL:
- <a href="https://docs.rs/lindera-ipadic-neologd-builder" target="_blank">lindera-ipadic-neologd-builder</a>
