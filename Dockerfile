FROM ruby:1.9.3
MAINTAINER jonathan@gutschi.net

# Run updates
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev

# Set up working directory
RUN mkdir /myapp
WORKDIR /myapp

# Set up gems
COPY Gemfile Gemfile.lock ./  
RUN bundle install --jobs 20 --retry 5

# Finally, add the rest of our app's code
# (this is done at the end so that changes to our app's code
# don't bust Docker's cache)
COPY . ./
