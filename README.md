# alpine-pandoc-ja

 [![Docker Automated build](https://img.shields.io/docker/automated/hiroaki1203/alpine-pandoc-ja.svg?style=flat-square)](https://hub.docker.com/r/hiroaki1203/alpine-pandoc-ja/) 
 [![Docker Automated build](https://img.shields.io/docker/build/hiroaki1203/alpine-pandoc-ja.svg?style=flat-square)](https://hub.docker.com/r/hiroaki1203/alpine-pandoc-ja/builds/) 
 [![GitHub release](https://img.shields.io/github/release/hiroaki-ma1203/docker-alpine-pandoc-ja.svg?style=flat-square)](https://github.com/hiroaki-ma1203/docker-alpine-pandoc-ja/releases)

Pandoc for Japanese based on Alpine Linux.

- Tex Live 2019
- pandoc 2.9.2
- pandoc-crossref 0.3.6.2
- Eisvogel (tex template)

## Usage

```sh
$ docker pull hiroaki1203/alpine-pandoc-ja
$ docker run -it --rm -v `pwd`:/workspace hiroaki1203/alpine-pandoc-ja pandoc input.md -f markdown -o output.pdf --pdf-engine=lualatex
```

### Use Eisvogel Template

```sh
$ mkdir templates
$ docker run -it --rm -v `pwd`:/workspace hiroaki1203/alpine-pandoc-ja pandoc input.md -f markdown -o output.pdf --pdf-engine=lualatex --template eisvogel
```

### Use Other Template

```sh
$ mkdir templates
$ wget https://someware.temprate.com/filepath/template-file.tex -O templates/template-file.tex
$ docker run -it --rm -v `pwd`:/workspace -v `pwd`/templates:/root/.pandoc/templates hiroaki1203/alpine-pandoc-ja pandoc input.md -f markdown -o output.pdf --pdf-engine=lualatex --template template-file.tex
```

## Reference

- [k1low/alpine-pandoc-ja](https://github.com/k1LoW/docker-alpine-pandoc-ja)
- [portown/alpine-pandoc](https://github.com/portown/alpine-pandoc)
- [paperist/alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja)
- [Wandmalfarbe/pandoc-latex-template](https://github.com/Wandmalfarbe/pandoc-latex-template)
