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

# 實驗室公告

實驗室公告的功能實作，請參考[MuWeb/features/professor_assigned](../../features/professor_assigned/)這個資料夾所寫的筆記，以下實作的緣由紀錄於[controller_design.md](../../features/professor_assigned/controller_design.md)

我的需求：

>傳統A發了一篇文章，只有A有權限編輯
>
>我現在想要A發一篇文章，可以給特定的B或C或D來編輯A的文章，其他人不可以編輯

做法：

>用一個多選下拉選單，來指派實驗室成員，這個選單只會出現還在學校的實驗室成員，已經畢業的實驗室成員就不會出現在選單裡面。

為了這需求，我設計了多對多model

>一個user身為author會有多個post，一個post透過post_authority可能會有多個editor

```
User

post_authority   中介表

Post
```

表單的樣子會是
```
title

多選下拉選單：決定哪些人可以編輯，最後選好的人會被存到中介表 post_authority 裡面去

content

submit，送出表單
```

## 建立實驗室公告 post table

```
rails g migration create_post
```

fix `Mucat_v1/db/migrate/20161121085918_create_post.rb`


完整的code
```
class CreatePost < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.integer  :user_id
      t.string   :title
      t.text     :content
      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end

```

然後`rake db:migrate`

## 題外話：schema亂掉後如何處理

一開始實驗室成員的model設為lab_member，後來才改成user

但是，我當初沒有用正規的寫法去drop lab_member在的schema裡的table，有先`rake db:migrate`，然後直接`rails d devise lab_member`

結果變成我的`schema.rb`裡面有`user table`也有`lab_member table`

而且如果table建錯後，我都是先`rake db:migrate`，然後直接`rails d migration`，完全沒把schema裡的東西改掉，結果我等到要建`post table`時才發現我的schema已經大亂了。

後來我是參考[ActiveRecord Command Line基本操作指令 - iT 邦幫忙](http://ithelp.ithome.com.tw/articles/10160474)這篇的解法

先把`db/migrate`資料夾裡的東西留下我要的migration，刪掉不要的，然後下指令
```
 rake db:migrate:reset
```

然後再回去看`schema.rb`就可以看到乾淨的schema了

# 建立post_authorities table 中介表

有鑒於migration與schema大亂的經驗，這份資料先備份一下
- [用Migrations指令创建修改表格 & schema](https://github.com/xingrowth/fullstack-course/wiki/用Migrations指令创建修改表格-&-schema)

建立中介表
`rails g migration create_post_authority`

定義post_authorities table

fix `db/migrate/20161121101139_create_post_authority.rb`

完整code
```
class CreatePostAuthority < ActiveRecord::Migration
  def up
    create_table :post_authorities do |t|
      t.integer :user_id
      t.integer :post_id
    end
  end

  def down
    drop_table :post_authorities
  end
end
```

然後`rake db:migrate`

# 建立model

若是下指令 `rails g model post`不只會建立`post.rb` model，也會建立一個`XXXXXXXXX_create_posts.rb` migration。由於我們剛剛已經定義好post table與post_authority table，所以不用此方法。


直接到`app/model`資料夾裡建立model

create `app/model/post.rb`
```
class Post < ActiveRecord::Base

end
```

create `app/model/post_authority.rb`
```
class PostAuthority < ActiveRecord::Base

end
```

# model之間建立關聯

fix `app/model/user.rb`

```
class User < ActiveRecord::Base
  ...

  has_many :posts
  has_many :post_authorities
  has_many :editable_posts, through: :post_authorities, source: :post
end
```

fix `app/model/post_authority.rb`

```
class PostAuthority < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end
```

fix `app/model/post.rb`

```
class Post < ActiveRecord::Base
  belongs_to :author, class_name "User", foreign_key: :user_id
  has_many :post_authorities
  has_many :editors, through: :post_authorities, source: :user
end
```

## 題外話：建立好model後要測試一下model能不能work

參考自：[JCcart wiki - Step.4 models](https://github.com/NickWarm/jccart/wiki/Step.4-models)

建立好model後，要`rails c`進入console來測試model能不能work
```
rails c
Running via Spring preloader in process 3379
Loading development environment (Rails 4.2.5.2)
[1] pry(main)> Post.count
SyntaxError: /Users/nicholas/Desktop/MuWeb/versions/MuCat_v1/app/models/post.rb:2: syntax error, unexpected tSTRING_BEG, expecting keyword_do or '{' or '('
  belongs_to :author, class_name "User", foreign_key: :user_id
                                  ^
/Users/nicholas/Desktop/MuWeb/versions/MuCat_v1/app/models/post.rb:2: syntax error, unexpected ',', expecting keyword_end
  belongs_to :author, class_name "User", foreign_key: :user_id
                                        ^
from /Users/nicholas/.rvm/gems/ruby-2.2.2/gems/activesupport-4.2.5.2/lib/active_support/dependencies.rb:457:in `load'
[2] pry(main)> User.count
   (3.0ms)  SELECT COUNT(*) FROM `users`
=> 0
[3] pry(main)> PostAuthority.count
   (0.4ms)  SELECT COUNT(*) FROM `post_authorities`
=> 0
```

結果發現Post model噴了，查一下[rails API - ActiveRecord::Associations::ClassMethods](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)發現Post model這邊的`class_name "User"`寫錯了，要寫`class_name: "User"`

from

```
belongs_to :author, class_name "User", foreign_key: :user_id
```

to

```
belongs_to :author, class_name: "User", foreign_key: :user_id
```

然後再`rails c`後，每個model都下指令`ModelName.count`來測試看看，果然都能work了

# 重新定義路由的「概念」

依循不同的User story，會有不同的路由設計，在此註解`route.rb`為何如此設計
```
Rails.application.routes.draw do
                                 # 第一層：發表文章、編輯文章
  resources :learningnotes       # 學習資源
  resources :posts               # 實驗室公告
  resources :honors              # 榮譽榜
  resources :users               # 實驗室成員資料
  resources :professorworks      # 教授的著作

  devise_for :users              # 登入系統
  devise_for :managers

  get 'welcome/index'            # 首頁
  root 'welcome#index'

  namespace :dashboard do        # 實驗室成員：編輯個資、
                                 #           查看該帳號發表過什麼文章，點選文章後進入第一層觀看文章，並且編輯之
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

# 建立post controller

```
rails g controller Post
```
