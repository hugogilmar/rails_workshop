FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    yarn \
    && apt-get clean

WORKDIR /blog

RUN echo "gem: --no-document" > /root/.gemrc
RUN gem install rails bundler

VOLUME /usr/local/bundle

EXPOSE 3000

CMD bundle exec rails s -b 0.0.0.0
