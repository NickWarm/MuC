# 建專案、設定好debug工具、連結資料庫

## 建立專案
```
rails new MuCat_v1 -d mysql -T
```

## 加入debug工具

add to `MuCat_v1/Gemfile`

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

## 會用到的gem

add to `MuCat_v1/Gemfile`

```
gem 'will_paginate'
gem 'awesome_print'
gem 'devise'
gem 'paperclip'
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

refer to this posts
- [JCcart GitHub wiki - Step.2 路由設定](https://github.com/NickWarm/jccart/wiki/Step.2-%E8%B7%AF%E7%94%B1%E8%A8%AD%E5%AE%9A)
- [mackenziechild GitHub - blog_course_demo/config/routes.rb ](https://github.com/mackenziechild/blog_course_demo/blob/master/config/routes.rb)
- [lustan3216 GitHub - FUSAKIGG/config/routes.rb](https://github.com/lustan3216/FUSAKIGG/blob/master/config/routes.rb)

~~由於該專案是實驗室網站，並不像購物車，需要有個使用者後台~~

目前打算，一樣分兩層後台：實驗室成員後台、管理員後台

實驗室成員可以看到
- 個人資料編輯頁面
- 可以在「實驗室公告、學習資源」發佈、修改文章
- 無刪除 **榮譽榜** 的權限

網站管理員
- 開發者我與指導教授
- 具有刪除 **榮譽榜、實驗室成員** 的權限

## 架構
第一層：public
- 學習資源
- 實驗室公告
- 實驗室成員資料   
- 榮譽榜

第二層：namespace
- 實驗室成員有編輯這些的權限
  - 學習資源
  - 實驗室公告
  - 實驗室成員資料   
  - 榮譽榜

第三層：namespace
- 網站管理員有刪除的權限
  - 實驗室成員資料

model用兩個字命名   
- [Ruby/Rails - Models Named with Two Words (Naming Convention Issues) - Stack Overflow](http://stackoverflow.com/questions/4893342/ruby-rails-models-named-with-two-words-naming-convention-issues)
- [物件導向程式的九個體操練習 | ihower { blogging }](https://ihower.tw/blog/archives/1960)
  - 見第五點

fix `config/routes.rb`

完整code
```
Rails.application.routes.draw do

  resources :learningnotes       # 學習資源
  resources :posts               # 實驗室公告
  resources :honors              # 榮譽榜
  resources :users               # 實驗室成員資料
  resources :professorworks      # 教授的著作

  devise_for :users              # 登入系統
  devise_for :managers

  get 'welcome/index'            # 首頁
  root 'welcome#index'

  namespace :dashboard do        # 實驗室成員：新增編輯文章、個資使用
    resources :learningnotes
    resources :posts
    resources :honors
    resources :users

    namespace :admin do          # 網站管理員：上線的版本要把admin改成亂碼
      resources :users           # 刪除實驗室成員的權限
      resources :professorworks  # 教授的著作
    end
  end
end
```

注意：由於這時我們還沒用devise，所以先把會用到devise的部分都註解掉
```
# devise_for :users    # 登入系統
# devise_for :managers
```
上面這段code在使用`rails g devise User`、`rails g devise Manager`時會自動生成

然後，我們要先弄一下`welcome controller`不然會噴掉，因為首頁設為`welcome#index`

```
rails g controller welcome
```

create `app/views/welcome/index.html.erb`，and add
```
<h1>This is welcome index</h1>
```

and then `rails s`，success!!!

# devise

目前計劃
- 登入系統一律用devise
- 實驗室成員的個人照片用paperclip來處理

參考
- 以前的筆記：[JCcart GitHub wiki - Step.3 註冊系統與產品圖片](https://github.com/NickWarm/jccart/wiki/Step.3-註冊系統與產品圖片)
- [plataformatec/devise - GitHub](https://github.com/plataformatec/devise)

```
rails g devise:install
rails g devise User
rails g devise Manager
```

覺得沒必要像JC一樣關掉其他功能，照原始設定就好

參考
- [lustan3216 GitHub - FUSAKIGG/db/migrate/20160628174512_devise_create_users.rb](https://github.com/lustan3216/FUSAKIGG/blob/master/db/migrate/20160628174512_devise_create_users.rb)
- [建立shop的table](https://github.com/NickWarm/jccart/wiki/Step.3-註冊系統與產品圖片#建立shop的table)
- [ActiveRecord::Migration](http://api.rubyonrails.org/classes/ActiveRecord/Migration.html)

覺得另外開一個migration來定義資料表會比較好維護

and then `rake db:migrate`

# 定義model

奇怪，在[JCcart GitHub wiki - Step.4 models](https://github.com/NickWarm/jccart/wiki/Step.4-models)時，直接寫`rails g model Item`會噴掉，但這次不會噴....，不過也沒打算用這方法，決定使用[建立shop的table](https://github.com/NickWarm/jccart/wiki/Step.3-註冊系統與產品圖片#建立shop的table)的方法來建model

學習資源的model用兩個字命名   
- [Ruby/Rails - Models Named with Two Words (Naming Convention Issues) - Stack Overflow](http://stackoverflow.com/questions/4893342/ruby-rails-models-named-with-two-words-naming-convention-issues)

model比較對照表：
- 學習資源：`learning_notes`
- 榮譽榜：`honors`
- 實驗室公告：`posts`
- 實驗室成員：`users`
- 學生的論文：`papers`
- 教授的著作：`professor_works`

## 學習資源

學習資源的表單設計，除了原本[MuCat_v1.md](../MuCat_v1/MuCat_v1.md)的
- ~~`author:string title:string content:text other_can_edit:boolean`~~
- 改成：`author:string title:string content:text is_editable:boolean`

後來參考
- [mackenziechild GitHub - blog_course_demo/db/migrate/20150509171512_create_projects.rb](https://github.com/mackenziechild/blog_course_demo/blob/master/db/migrate/20150509171512_create_projects.rb)
- [mackenziechild GitHub - blog_course_demo/app/views/projects/show.html.erb](https://github.com/mackenziechild/blog_course_demo/blob/master/app/views/projects/show.html.erb)

應該加個`link:string`才對，這樣才能連到外部文章，這樣也比較符合我的需求

### create_learning_note migration





## 實作

```
rails g migration init_mucat_v1
```


# paperclip

用來上傳實驗室成員的個人照片

# 設定controller

# Facebook login system
