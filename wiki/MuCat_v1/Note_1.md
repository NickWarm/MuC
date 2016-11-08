# 建專案、設定好debug工具、連結資料庫

## 建立專案
```
rails new MuCat_v1 -d mysql -T
```

## 加入debug工具

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

## 設定資料庫

refer to my past notes：[JCcart GitHub wiki - Step.1 環境設定](https://github.com/NickWarm/jccart/wiki/Step.1-%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A)

fix `config/database.yml`

```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: iamgroot
  socket: /tmp/mysql.sock

development:
  <<: *default
  database: MuCat

...
...
...

production:
  <<: *default
  database: MuCat
  username: MuCat_v1
  password: iamgroot
```

and then  `rake db:create`

and then `rails s`

success!!!

# 建後台路由

refer to my past post
- [JCcart GitHub wiki - Step.2 路由設定](https://github.com/NickWarm/jccart/wiki/Step.2-%E8%B7%AF%E7%94%B1%E8%A8%AD%E5%AE%9A)

# devise與上傳圖片

# 設定controller

# Facebook login system
