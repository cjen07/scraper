FROM elixir

WORKDIR /home

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh \
 && sh rustup.sh -y \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get install nodejs -y \
 && npm install phantomjs-prebuilt

COPY ./config ./config
COPY ./lib/ ./lib/
COPY ./test/ ./test/
COPY ./mix.exs ./mix.exs
COPY ./mix.lock ./mix.lock

RUN mix local.hex --force \
 && mix deps.get \
 && mix local.rebar --force \
 && /bin/bash -c "source $HOME/.cargo/env && mix deps.compile"
 