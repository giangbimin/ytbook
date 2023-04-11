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
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
```

```
  rails g rspec:install
```
