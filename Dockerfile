FROM ruby:2.5.7

COPY . /src

WORKDIR /src

COPY Gemfile .
COPY Gemfile.lock .

RUN gem install bundler
RUN /bin/bash -lc "bundle"

CMD ["sh", "-c", "bundle exec padrino start -h 0.0.0.0 -p $PORT"]
