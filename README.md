# Lindera IPADIC NEologd Builder

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Join the chat at https://gitter.im/bayard-search/lindera](https://badges.gitter.im/bayard-search/lindera.svg)](https://gitter.im/bayard-search/lindera?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A Japanese dictionary builder based on IPADIC NEologd for [Lindera](https://github.com/bayard-search/lindera). This project fork from fulmicoton's [kuromoji-rs](https://github.com/fulmicoton/kuromoji-rs).

## Building Lindera IPADIC NEologd Builder

### Requirements for build CLI

The following products are required to build Lindera-IPADIC NEologd CLI:

- Rust >= 1.39.0
- make >= 3.81

### Preparing for build IPADIC NEologd dictionary

For building lindera dictionary with IPADIC NEologd, it is required CSV files that made by [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd).

1. See detail how to install [mecab-ipadic-NEologd]
2. Copy directory : `cp -r mecab-ipadic-neologd/build/mecab-ipadic-2.7.0-20070801-neologd-20200130 <THIS_REPOSITORY>/mecab-ipadic-neologd`

Then, you can build IPADIC NEologd binary dictionary with lindera-ipadic-neologd.

### Building a command-line interface and a dictionary

Building a dictionary with the following command:

```text
$ make lindera-ipadic-neologd
```

## Dictionary version

This repository only tested *seed/mecab-user-dict-seed.20200130.csv.xz* of [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd).

*NOTE* : This builder skip 2 words, "カブシキガイシャ" and "タカラヅカカゲキダンキセイ", to avoid dictionary build failure.
These words are `SKIP_WORDS` in src/lib.rs .

## Installing Lindera IPADIC NEologd

```
$ cargo install lindera-ipadic-neologd
```

## Usage

This section describes how to use the command line interface.

Show help with the following command::
```
$ ./bin/lindera-ipadic-neologd -h
```

Building a dictionary with `lindera-ipadic-neologd` command:
```
$ ./bin/lindera-ipadic-neologd ./mecab-ipadic-neologd ./lindera-ipadic-neologd
```