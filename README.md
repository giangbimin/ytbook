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