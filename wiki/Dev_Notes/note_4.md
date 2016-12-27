# 編輯個人頁面

情境
- 可以用markdown語法編輯自我介紹(`profile:text`)、發表過的論文(`paper:text`)
- 上傳一張個人生活照片
- ~~點選自己現在幾年級~~，自動算出你現在幾年級
  - ~~總管理員要有權限去修~~，改成自動加總，從 **入學學年** `joined_CYCU_year:integer` 去推算你現在幾年級。現在寫筆記時是2016/12/5，聽說是105學年
  - 估狗發現人家演算法都幫你寫好了XD，只要寫個function就好了，請見：[公式： 如何把西元年轉為當前學年度 @ 毛哥資訊日誌 :: 痞客邦 PIXNET ::](http://awei791129.pixnet.net/blog/post/40554993-%5B公式%5D-如何把西元年轉為當前學年度)
- 身份狀態：還在讀書，還是已經離開學校
  - [Toggle - Checkbox | Semantic UI](http://semantic-ui.com/modules/checkbox.html#toggle)

so

User model
- 姓名:string、入學學年:integer、論文題目:~~string~~(改成`paper:text`)、自我介紹:text、現在幾年級、身份狀態:string、個人照片
- `name:string joined_CYCU_year:integer paper:text profile:text academic_degree:integer has_graduated:boolean`

實作順序
- 上傳個人照片
- markdown編輯
- Toggle
- 自動算現在幾年級

## 插曲：gitignore失效的解法

有些檔案想要隱藏不想被git追蹤，但是以前已經送出commit追蹤過了，再去gitignore不管怎麼設定都失效。後來參考這篇照著做就解掉了
- [Git 教學(1) : Git 的基本使用 - 好麻煩部落格](http://gogojimmy.net/2012/01/17/how-to-use-git-1-git-basic/)，搜尋「被加入 gitignore 的檔案一樣出現在 status 中」


# 上傳個人照片

先實作上傳個人照片的功能，因為以前做過XD

由於打算用paperclip實作實驗室個人沙龍照的上傳，參考
- [JCcart wiki - Step.3 註冊系統與產品圖片 - 產品圖片：paperclip](https://github.com/NickWarm/jccart/wiki/Step.3-註冊系統與產品圖片#產品圖片paperclip)
- [JCcart wiki - Step.11 加上圖片](https://github.com/NickWarm/jccart/wiki/Step.11-加上圖片)

## 用Paperclip需要Imagemagick

使用Paperclip需要Imagemagick，如果沒裝過那要先裝
- [Image Processor - paperclip GitHub](https://github.com/thoughtbot/paperclip#image-processor)

由於以前我已經透過`brew install imagemagick`來安裝imagemagick，這邊就不再裝一遍，可以透過指令`convert --help`來查看imagemagick有哪些東西可以用

## 安裝Paperclip

edit `Gemfile`, add `gem "paperclip", "~> 5.0.0"`。由於我先前已經裝過了，所以這邊就不用了

在User model加入Paperclip所需的欄位

```
rails g migration add_user_cover
```

and then edit `db/migrate/20161207040316_add_user_cover.rb`

```
class AddUserCover < ActiveRecord::Migration
  def up
    add_attachment :users, :cover
  end

  def down
    remove_attachment :users, :cover
  end
end
```

首先，你會看到非傳統的加入欄位寫法，而是使用`add_attachment`
- [Quick Start - paperclip GitHub](https://github.com/thoughtbot/paperclip#quick-start)
  - [Schema Definition - paperclip GitHub](https://github.com/thoughtbot/paperclip#schema-definition)

and last `rake db:migrate`

## 上傳圖片

### User controller edit, update, show actions

情境：User登入後可以編輯個人資料

由於前面我還沒實作User的CRUD所以，先來實作之

理論上，我是不需要實作new, create actions，畢竟登入註冊那些devise都幫我們處理好了，我只需要去處理編輯(`edit action`)個人資料、更新(`update action`)個人資料、顯示(`show action`)個人資料即可

>在此其實不需要`edit`
>
>不考慮刪除(`destroy action`)成員，畢竟在真實情境下，實驗室成員只要待過我們實驗室，就該留下 **紀錄**，如果他已經離開我們實驗室了，就把它歸到已畢業即可

~~so edit `app/controllers/users_controller.rb`~~

上面這行不恰當，我希望實驗室成員進到 **使用者的後台** 去編輯他的個人資料，如我在`routes.rb`的設定
```
namespace :dashboard do        # 第二層：~~上線版要把dashboard改名，不能讓非實驗室成員能進入這頁面~~，
                               #          其實只要before_action :authenticate_user!即可
                               #          查看該帳號發表過什麼文章，點選文章後進入第一層觀看文章，並且編輯之
  resources :learningnotes
  resources :posts
  resources :honors
  resources :users             # 實驗室成員：編輯個資
                               #           查看該帳號發表過什麼文章，點選文章後進入第一層觀看文章，並且編輯之
```


參考過去JCcart的寫法
- [JCcart wiki - Step.5 後台的controller](https://github.com/NickWarm/jccart/wiki/Step.5-後台的controller)

create `app/controllers/dashboard/dashboard_controller.rb`

```
class Dashboard::DashboardController < ApplicationController
  before_action :authenticate_user!
end
```

之後learningnotes、posts、honors、users controller都只要繼承dashboard_controller，就不用再寫`before_action :authenticate_user!`

so create `app/controller/users_controller.rb`

```
class Dashboard::UsersController < Dashboard::DashboardController
end
```

so create `app/controller/honors_controller.rb`

```
class Dashboard::HonorsController < Dashboard::DashboardController
end
```

so create `app/controller/posts_controller.rb`

```
class Dashboard::PostsController < Dashboard::DashboardController
end
```

so create `app/controller/learningnotes_controller.rb`

```
class Dashboard::LearningnotesController < Dashboard::DashboardController
end
```

## 插曲：學習筆記的簡稱改名

原本我規劃「學習筆記」用Learningnotes來代表，但是今天寫learningnotes controller時，實在覺得這真的太長了，於是決定把學習筆記的英文改成用 **Notes** 來代表

so rename `app/controllers/dashboard/notes_controller.rb` and edit

```
class Dashboard::NotesController < Dashboard::DashboardController
end
```

and edit `wiki/Dev_Notes/MuCat_v1.md` change to **Note model** from **LearningNote model**

and edit `config/routes.rb`

```
Rails.application.routes.draw do
  devise_scope :user do
    ...
  end
                                 # 第一層：發表文章、編輯文章
  resources :notes               # 學習資源
  ...

  namespace :dashboard do        # 第二層：~~上線版要把dashboard改名，不能讓非實驗室成員能進入這頁面~~，
                                 #          其實只要before_action :authenticate_user!即可
                                 #          查看該帳號發表過什麼文章，點選文章後進入第一層觀看文章，並且編輯之
    resources :notes
    ...

    namespace :admin do          # 第三層：上線的版本要把admin改成亂碼
      ...
    end
  end

  get '*path' => redirect('/')
end
```

# 編輯個人頁面的情境

在使用者後台我們可以編輯個人資料，前台可以觀看個人資料，可以看到全部實驗室成員，所以controller會設計成

`app/controllers/`
- `dashboard`               
  - `users_controller.rb`
    - edit action
    - update action
- `users_controller.rb`
  - index action
  - show action

so edit `app/controllers/dashboard/users_controller.rb`

```
class Dashboard::UsersController < Dashboard::DashboardController
  before_action :find_user, only: [:edit, :update]

  def edit

  end

  def update

  end

  def find_user

  end
end
```  

架構如上，接下來我們要在`find_user` 這個`before_action`來撈user的id。

參考[blog_course_demo/app/controllers/projects_controller.rb](https://github.com/mackenziechild/blog_course_demo/blob/master/app/controllers/projects_controller.rb)與下面這些文章，我打算用`friendly_id`與`babosa`來做
- [使用 Babosa 配合 Friendly_id 解決中文網址問題 - 蟑螂窩](http://blog.roachking.net/blog/2014/01/17/babosa-friendly-id-solve-chinese-problems/)
  - 傳統rails的寫法會讓人知道你的資料庫裡有多少筆資料，這樣做不恰當，而且網站變得很好爬，所以我們用`friendly_id`
- [使用friendly_id優化URL，babosa讓URL呈現中文字](http://www.lkwu.site/rails-使用friendly_id優化urlbabosa讓url呈現中文字)
  - 這篇比上面那篇又更清楚了
- [Rails讓網址不再只顯示ID « Wayne](http://waynechu.logdown.com/posts/205700-rails-web-site-no-longer-displays-only-id)
  - 這篇最簡潔容易實作
- [Rails Quickstart - friendly_id GitHub](https://github.com/norman/friendly_id#rails-quickstart)
  - 讀完官方教學後，實在不覺得該在user這邊用friendly_id，如果只有臉書登入，還能用`fb_name`來實作，但是不能肯定每個人都有用臉書，如果只有用傳統登入沒用臉書登入，那程式就會出錯
- [建立使用者功能 « Rails 101 S](http://rails101s.logdown.com/posts/247881-20-4-adding-user-functions)，rails101s有實作過客製化login頁面，搜尋「devise_parameter_sanitizer」

結論：User model不實作`friendly_id`，其餘的都實作，先把實踐方法紀錄在[custom_devise_controller.md](../features/custom_devise_controller/custom_devise_controller.md)


so edit `app/controllers/dashboard/users_controller.rb`

```
class Dashboard::UsersController < Dashboard::DashboardController
  before_action :find_user, only: [:edit, :update]

  def edit

  end

  def update

  end

  def find_user
    @user = User.find(params[:id])
  end
end
```

and then create `app/views/dashboard/users/edit.html.erb`

一開始可能是長這樣

```
<%= form_for @user, url: do |f| %>


  <%= f.submit %>
<% end %>
```

注意，由於我們現在是在`app/views/dashboard/users/edit.html.erb`這層，去編輯user 的個人資料，所以他的`form_for`的路由跟傳統的不一樣，參考過去寫過的筆記
- [JCcart wiki - Step.9 開始修scaffold](https://github.com/NickWarm/jccart/wiki/Step.9-開始修scaffold)
  - 上面edit的寫法有錯喔，這邊有說為何錯：[JCCart wiki - Step.10 寫一支機器人塞亂數產品進去 - fix admin/items/edit.html.erb](https://github.com/NickWarm/jccart/wiki/Step.10-寫一支機器人塞亂數產品進去#fix-adminitemsedithtmlerb)
  - [jccart/app/views/dashboard/admin/items/edit.html.erb](https://github.com/NickWarm/jccart/blob/master/app/views/dashboard/admin/items/edit.html.erb)
    - [rails API - form_for](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_for)，搜尋「Resource-oriented style」，然後觀看這個寫法：`<%= form_for(@post, url: super_posts_path) do |f| %>`

我先`rake routes`查看路由，找URI Pattern那欄看到`/dashboard/users/:id/edit(.:format)`這個，它的prefix是`edit_dashboard_user`

由於我們在`dashboard`這層，所以我們要自己寫HTTP Verb，我們僅要部分更新所以用 **PATCH**
- [HTTP Verbs: 談 POST, PUT 和 PATCH 的應用 | ihower { blogging }](https://ihower.tw/blog/archives/6483)

so keep coding `app/views/dashboard/users/edit.html.erb`

```
<%= form_for @user, url: edit_dashboard_user, method: :patch do |f| %>


  <%= f.submit %>
<% end %>
```

然後就噴錯了

後來再去看了一次以前讀過的資料，發現應該用`url: edit_dashboard_user_path`
- [JCcart wiki - Step.9 開始修scaffold](https://github.com/NickWarm/jccart/wiki/Step.9-開始修scaffold#edit)
- [rails API - form_for](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_for)，搜尋「url: super_posts_path」


so fix `app/views/dashboard/users/edit.html.erb`

```
<%= form_for @user, url: edit_dashboard_user_path, method: :patch do |f| %>


  <%= f.submit %>
<% end %>
```

## 插曲

不知為何，以前直接`rake routes`就能查看路由，今天突然噴錯說這專案是`rake 11.3.0`，說我已經啟動了`rake 12.0.0`。必須要改用`bundle exec rake routes`才能work

後來我用`rake --version`查看rake版本的確是`12.0.0`。雖然每次都用`bundle exec rake routes`也可以運作，但這樣很麻煩。

後來讀到這篇的comment
- [comment1：ruby on rails - Use older version of Rake - Stack Overflow](http://stackoverflow.com/a/6243314)

我先在`Gemfile`裡給他加上`gem 'rake', '12.0.0'`然後`bundle install`

接著噴錯，跟我說可以試用`bundle update rake`

於是我改用`bundle update rake`，然後就順利讓`rake`升到`12.0.0`了。

至於在`Gemfile`裡加上`gem 'rake', '12.0.0'`，經過測試沒有必要，所以我就把這段砍了，然後重新`bundle install`，小bug順利解掉！！！


# Users index

臉書登入，有了帳號後，要進到User的index頁面修改個人資料。實作時發現devise會預設把user的index關掉，所以`rake routes`時找不到index的路由，後來參考這篇
- [comment：ruby on rails - Creating an index view for a devise user - Stack Overflow](http://stackoverflow.com/a/16931894)

so, fix `routes.rb`

```
devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }
resources :users, only: [:index]
```

and then it work!!!

剛剛發現，devise連`user#show`也是預設關掉的，so keep fixing `routes.rb`

```
devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }
resources :users, only: [:index, :show]
```

然後就可以撈到user的show頁面了

# 繼續實作上傳圖片

上面已經把上傳圖片基本的`form_for`格式(路由、HTTP Verb)打好了，現在繼續實作上傳圖片

~~情境：一開始註冊後，是沒有個人照片，必須進到user個人頁面去新增你的個人照片~~

~~首先我們要有一個顯現個人資料的頁面(show action)，然後裡面可以看到~~

中間停了一段時間，研究上傳個人照片的機制

# 實作semantic ui modal

需要給`f.file_field`加上個id，後來查詢rails API後，發現可以直接撈`#user_cover`
- [rails API - file_field](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-file_field)

AJAX的部分，我參考這篇來寫
- [comment2：javascript - how to use semantic-ui modal - Stack Overflow](http://stackoverflow.com/a/24885796)

```
<%= content_for :header do %>
  <script>
    $(function(){
      $('#user_cover').click(function(){
        $('.ui.modal').modal('show')
      })
    })
  </script>
<% end %>
```

後來發現，我沒有引用`semantic_ui.js`裡的`modal.js`、`dimmer.js`

so fix `vendor/assets/javascripts/semantic_ui.js`

```
//= require semantic_ui/definitions/modules/modal.js
//= require semantic_ui/definitions/modules/dimmer.js
```

成功啟動modal，但是這樣的寫法，會在我選照片時同時啟動modal。

我希望的情境是，選完照片後才顯示modal

一開始讀到MDN的input tag，type為`file`時的寫法
- [Dynamically adding a change listener - Using files from web applications | MDN](https://developer.mozilla.org/en-US/docs/Using_files_from_web_applications#Dynamically_adding_a_change_listener)

但是`addEventListener`不知為何一直噴錯


後來估狗下關鍵字「input type file eventlistner」找到這篇
- [comment：what listeners are called when a file is selected from a file chooser in javascript - Stack Overflow](http://stackoverflow.com/a/16701171)

so fix `app/views/dashboard/users/edit.html.erb`

```
<%= content_for :header do %>
  <script>
  $(function(){
    $('#user_cover').on('change', function(){
      $('.ui.modal').modal('show')
    })
  })
  </script>
<% end %>
```

之後估狗jQuery的API，發現可以更簡潔地直接用`.change`來寫
- [.change() | jQuery API Documentation](https://api.jquery.com/change/)

so fix `app/views/dashboard/users/edit.html.erb`

```
<%= content_for :header do %>
  <script>
  $(function(){
    $('#user_cover').change(function(){
      $('.ui.modal').modal('show')
    })
  })
  </script>
<% end %>
```

如此一來，就能成功地選完照片後，才顯示modal
