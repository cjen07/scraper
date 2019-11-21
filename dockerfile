FROM elixir

WORKDIR /home

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh \
 && sh rustup.sh -y \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get install nodejs -y \
 && npm install phantomjs-prebuilt

COPY ./scraper/config ./scraper/config
COPY ./scraper/lib/ ./scraper/lib/
COPY ./scraper/test/ ./scraper/test/
COPY ./scraper/mix.exs ./scraper/mix.exs
COPY ./scraper/mix.lock ./scraper/mix.lock
RUN mv node_modules ./scraper/node_modules

WORKDIR /home/scraper

RUN mix local.hex --force \
 && mix deps.get \
 && mix local.rebar --force \
 && /bin/bash -c "source $HOME/.cargo/env && mix deps.compile"
