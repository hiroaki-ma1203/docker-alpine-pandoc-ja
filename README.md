# alpine-pandoc-ja [![Docker Automated build](https://img.shields.io/docker/automated/hiroaki-ma1203/alpine-pandoc-ja.svg?style=flat-square)](https://hub.docker.com/r/k1low/alpine-pandoc-ja/) [![Docker Automated build](https://img.shields.io/docker/build/k1low/alpine-pandoc-ja.svg?style=flat-square)](https://hub.docker.com/r/k1low/alpine-pandoc-ja/builds/) [![GitHub release](https://img.shields.io/github/release/k1low/docker-alpine-pandoc-ja.svg?style=flat-square)](https://github.com/hiroaki-ma1203/docker-alpine-pandoc-ja/releases)

Pandoc for Japanese based on Alpine Linux.

- Tex Live 2020
- pandoc 2.7.2
- pandoc-crossref 0.3.4.1

## Usage

```sh
$ docker pull hiroaki-ma1203/alpine-pandoc-ja
$ docker run -it --rm -v `pwd`:/workspace hiroaki-ma1203/alpine-pandoc-ja pandoc input.md -f markdown -o output.pdf --pdf-engine=lualatex
```

### Use Template

```
$ mkdir templates
$ wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex -O templates/eisvogel.tex
$ docker run -it --rm -v `pwd`:/workspace -v `pwd`/templates:/root/.pandoc/templates hiroaki-ma1203/pandoc:latest pandoc input.md -f markdown -o output.pdf --pdf-engine=lualatex --template eisvogel.tex
```

## Reference Dockerfile

- [k1low/alpine-pandoc-ja](https://github.com/k1LoW/docker-alpine-pandoc-ja)
- [portown/alpine-pandoc](https://github.com/portown/alpine-pandoc)
- [paperist/alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja)
