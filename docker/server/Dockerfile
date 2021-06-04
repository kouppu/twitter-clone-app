# syntax=docker/dockerfile:1
FROM ruby:2.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn \
  && mkdir /myapp
WORKDIR /myapp
COPY ./server/Gemfile /myapp/Gemfile
COPY ./server/Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY ./server /myapp

# Add a script to be executed every time the container starts.
COPY ./server/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
