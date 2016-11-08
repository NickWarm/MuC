# 建後台路由

建立專案
```
rails new MuCat_v1 -d mysql -T
```

加入debug工具

fix `MuCat_v1/Gemfile`

```
...
...
...

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
```

and then `bundle install`

# login system
