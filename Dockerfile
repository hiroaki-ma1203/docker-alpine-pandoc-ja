FROM frolvlad/alpine-glibc

LABEL maintainer="hiroaki-ma1203 <hiroaki.ma1203@gmail.com>" \
      description="Pandoc for Japanese based on Alpine Linux."

# Install Tex Live
ENV TEXLIVE_VERSION 2019
ENV TEXLIVE_REPOGITORY http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/$TEXLIVE_VERSION/tlnet-final/
ENV PATH /usr/local/texlive/$TEXLIVE_VERSION/bin/x86_64-linuxmusl:$PATH

RUN apk --no-cache add perl wget xz tar fontconfig-dev \
 && mkdir -p /tmp/src/install-tl-unx \
 && wget -qO- $TEXLIVE_REPOGITORY/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/src/install-tl-unx --strip-components=1 \
 && printf "%s\n" \
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/src/install-tl-unx/texlive.profile \
 && /tmp/src/install-tl-unx/install-tl \
      --profile=/tmp/src/install-tl-unx/texlive.profile \
      --repository=$TEXLIVE_REPOGITORY \
 && tlmgr option repository $TEXLIVE_REPOGITORY \
 && tlmgr update --self && tlmgr update --all \
 && tlmgr install \
      collection-basic collection-latex \
      collection-latexrecommended collection-latexextra \
      collection-fontsrecommended collection-langjapanese latexmk \
      luatexbase ctablestack fontspec luaotfload lualatex-math \
      sourcesanspro sourcecodepro \
      # Install modules for "eisvogel" template
      adjustbox babel-german background bidi collectbox csquotes everypage filehook \
      footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights \
      needspace pagecolor titling ucharcat ulem unicode-math \
      upquote xecjk xurl zref\
 && rm -Rf /tmp/src \
 && apk --no-cache del xz tar fontconfig-dev

# Install Pandoc
ENV PANDOC_VERSION 2.9.2.1
ENV PANDOC_DOWNLOAD_URL https://github.com/jgm/pandoc/archive/$PANDOC_VERSION.tar.gz
ENV PANDOC_DOWNLOAD_SHA512 95eea437800418e18b5ca115b0ec412efaae9d88929aa1e1c93284430da1e7d01586b4c335e5726a0d1bede64f53b6eec645e8c4a3a15477ae27ffee2288e51b
ENV PANDOC_ROOT /usr/local/pandoc
ENV PATH $PATH:$PANDOC_ROOT/bin

RUN apk add --no-cache \
    gmp \
    libffi \
 && apk add --no-cache --virtual build-dependencies \
    --repository "http://nl.alpinelinux.org/alpine/edge/community" \
    ghc \
    cabal \
    linux-headers \
    musl-dev \
    zlib-dev \
    curl \
 && mkdir -p /pandoc-build && cd /pandoc-build \
 && curl -fsSL "$PANDOC_DOWNLOAD_URL" -o pandoc.tar.gz \
 && echo "$PANDOC_DOWNLOAD_SHA512  pandoc.tar.gz" | sha512sum -c - \
 && tar -xzf pandoc.tar.gz && rm -f pandoc.tar.gz \
 && ( cd pandoc-$PANDOC_VERSION && cabal update && cabal install --only-dependencies \
    && cabal configure --prefix=$PANDOC_ROOT \
    && cabal build \
    && cabal copy \
    && cd .. ) \
 && rm -Rf pandoc-$PANDOC_VERSION/ \
 && apk del --purge build-dependencies \
 && rm -Rf /root/.cabal/ /root/.ghc/ \
 && cd / && rm -Rf /pandoc-build
 
# install pandoc-crossref
RUN wget https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.2/linux-pandoc_2_9_2.tar.gz -q -O - | tar xz \
 && mv pandoc-crossref /usr/bin/

# Install eisvogel templates
RUN wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex \
 && mv eisvogel.tex /root/.pandoc/templates/eisvogel.latex

VOLUME ["/workspace", "/root/.pandoc/templates"]
WORKDIR /workspace
