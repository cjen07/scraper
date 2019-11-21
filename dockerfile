FROM elixir

WORKDIR /home

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
RUN sh rustup.sh -y

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install nodejs -y
RUN npm install phantomjs-prebuilt

COPY ./scraper/config ./scraper/config
COPY ./scraper/lib/ ./scraper/lib/
COPY ./scraper/test/ ./scraper/test/
COPY ./scraper/mix.exs ./scraper/mix.exs
COPY ./scraper/mix.lock ./scraper/mix.lock
RUN mv node_modules ./scraper/node_modules

WORKDIR /home/scraper

RUN mix local.hex --force
RUN mix deps.get
RUN mix local.rebar --force
# TODO
# RUN /bin/bash -c "source $HOME/.cargo/env"
# RUN mix deps.compile

CMD [ "/bin/bash" ]