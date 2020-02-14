# Lindera IPADIC NEologd Builder

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Join the chat at https://gitter.im/bayard-search/lindera](https://badges.gitter.im/bayard-search/lindera.svg)](https://gitter.im/bayard-search/lindera?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

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

## API reference

The API reference is available. Please see following URL:
- <a href="https://docs.rs/lindera-ipadic-neologd-builder" target="_blank">lindera-ipadic-neologd-builder</a>

## Project links

lindera consists of several projects. The list is following:

- [Lindera](https://github.com/lindera-morphology/lindera)
- [Lindera Core](https://github.com/lindera-morphology/lindera-core)
- [Lindera Dictionary](https://github.com/lindera-morphology/lindera-dictionary)
- [Lindera IPADIC](https://github.com/lindera-morphology/lindera-ipadic)
- [lindera IPADIC Builder](https://github.com/lindera-morphology/lindera-ipadic-builder)
- [lindera IPADIC NEologd Builder](https://github.com/lindera-morphology/lindera-ipadic-neologd-builder)
- [lindera UniDic Builder](https://github.com/lindera-morphology/lindera-unidic-builder)
- [Lindera CLI](https://github.com/lindera-morphology/lindera-cli)
