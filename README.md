# Lindera IPADIC NEologd Builder

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Join the chat at https://gitter.im/lindera-morphology/lindera](https://badges.gitter.im/lindera-morphology/lindera.svg)](https://gitter.im/lindera-morphology/lindera?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

IPADIC NEologd dictionary builder for [Lindera](https://github.com/lindera-morphology/lindera). This project fork from fulmicoton's [kuromoji-rs](https://github.com/fulmicoton/kuromoji-rs).

## Install

```shell script
% cargo install lindera-ipadic-neologd-builder
```

## Build

The following products are required to build:

- Rust >= 1.39.0
- make >= 3.81
- mecab >= 0.996 (for building a dictionary)

```shell script
% cargo build --release
```

## Dictionary version

This repository only tested data of [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd).

*NOTE* : This builder skip 2 words, `カブシキガイシャ` and `タカラヅカカゲキダンキセイ`, to avoid dictionary build failure.
These words are `SKIP_WORDS` in `src/lib.rs` .

## Building a dictionary

Building a dictionary with `lindera-ipadic-neologd` command:

```shell script
% curl -L https://github.com/neologd/mecab-ipadic-neologd/archive/master.zip > ./mecab-ipadic-neologd-master.zip
% unzip -o mecab-ipadic-neologd-master.zip
% ./mecab-ipadic-neologd-master/bin/install-mecab-ipadic-neologd --create_user_dic -p $(pwd)/mecab-ipadic-neologd-master/tmp -y
% IPADIC_VERSION=$(find ./mecab-ipadic-neologd-master/build/mecab-ipadic-*-neologd-* -type d | awk -F "-" '{print $6"-"$7}')
% NEOLOGD_VERSION=$(find ./mecab-ipadic-neologd-master/build/mecab-ipadic-*-neologd-* -type d | awk -F "-" '{print $NF}')
% lindera-ipadic-neologd ./mecab-ipadic-neologd-master/build/mecab-ipadic-${IPADIC_VERSION}-neologd-${NEOLOGD_VERSION} lindera-ipadic-${IPADIC_VERSION}-neologd-${NEOLOGD_VERSION}
```

## Dictionary format

Refer to the [manual](https://ja.osdn.net/projects/ipadic/docs/ipadic-2.7.0-manual-en.pdf/en/1/ipadic-2.7.0-manual-en.pdf.pdf) for details on the IPADIC dictionary format and part-of-speech tags.

| Index | Name (Japanese) | Name (English) | Notes |
| --- | --- | --- | --- |
| 0 | 品詞 | part-of-speech | |
| 1 | 品詞細分類1 | sub POS 1 | |
| 2 | 品詞細分類2 | sub POS 2 | |
| 3 | 品詞細分類3 | sub POS 3 | |
| 4 | 活用形 | conjugation type | |
| 5 | 活用型 | conjugation form | |
| 6 | 原形 | base form | |
| 7 | 読み | reading | |
| 8 | 発音 | pronunciation | |

## Tokenizing text using produced dictionary

You can tokenize text using produced dictionary with `lindera` command:

```shell script
% echo "羽田空港限定トートバッグ" | lindera -d ./lindera-ipadic-2.7.0-20070801-neologd-20200130
```

```text
羽田空港        名詞,固有名詞,一般,*,*,*,羽田空港,ハネダクウコウ,ハネダクーコー
限定    名詞,サ変接続,*,*,*,*,限定,ゲンテイ,ゲンテイ
トートバッグ    名詞,固有名詞,一般,*,*,*,トートバッグ,トートバッグ,トートバッグ
EOS
```

For more details about `lindera` command, please refer to the following URL:

- [Lindera CLI](https://github.com/lindera-morphology/lindera/lindera-cli)

## API reference

The API reference is available. Please see following URL:
- <a href="https://docs.rs/lindera-ipadic-neologd-builder" target="_blank">lindera-ipadic-neologd-builder</a>
