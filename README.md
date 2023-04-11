# README

## create app
```
  rails new ytbook -f -d postgresql -c tailwind -T
  ./bin/bundle add tailwindcss-rails
  ./bin/rails tailwindcss:install
  ./bin/dev
```

## deployment

```
  fly launch
  fly deploy
```

## Test


```
  docker compose build
  docker-compose run web rake db:reset
  docker-compose run web rake db:create
  docker-compose run web rake db:migrate
  docker-compose up -d
```

```
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
```

```
  rails g rspec:install
```
