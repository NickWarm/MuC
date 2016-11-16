# 原稿

這是最初的原稿
- 優點：方便比較思考版本的差異
- 缺點：閱讀不易

之後會依版本不同，開不同`.md`檔來記錄不同時期的思考與當下的結論

# 功能

我有一個需求

>傳統A發了一篇文章，只有A有權限編輯
>
>我現在想要A發一篇文章，可以給特定的B或C或D來編輯A的文章，其他人不可以編輯

不用寫多對多的中介表

直接在post裡開一個is_editable的布林欄位就好了


# 中介表 migration

參考自[rails API - Active Record Migrations](http://api.rubyonrails.org/classes/ActiveRecord/Migration.html)

## 中介表，第三版

一組多對多，要配一組中介表，中介表不能共用，所以要改名字

`rails g migration create_post_authority`

```
class CreatePostAuthorities < ActiveRecord::Migration
  def up
    create_table :post_authorities do |t|
      t.integer :user_id
      t.integer :post_id
  end

  def down
    drop_table :post_authorities
  end
end
```

## 中介表，第二版

第一版觀念錯誤，我們已經用中介表去撈id了，不需要再開個`is_editable:boolean`欄位

`rails g  migration create_authority`

```
class CreateAuthorities < ActiveRecord::Migration
  def up
    create_table :authorities do |t|
      t.integer :user_id
      t.integer :post_id
  end

  def down
    drop_table :authorities
  end
end
```

## 中介表，第一版：已廢棄

`rails g  migration create_authority`

```
class CreateAuthorities < ActiveRecord::Migration
  def up
    create_table :authorities do |t|
      t.boolean :is_editable, default: false
      t.integer :user_id
      t.integer :post_id
  end

  def down
    drop_table :authorities
  end
end
```

# model配置  

post與user的關係，參考自[rails Guide - 2.4 has_many :through 關聯](http://rails.ruby.tw/association_basics.html#has-many-through-關聯)

[rails API - belongs_to ](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-belongs_to)

A model 與 B model 多對多，配一個中介表：A_B -> **user, post_authority, post**

A model 與 C model 多對多，配一個中介表：A_C -> **user, honor_authority, honor**

A model 與 D model 多對多，配一個中介表：A_D -> **user, professor_work_authority, professor_work**

在此以實驗室公告 **Post Model** 為例

## model配置，WG第四版


```
class User < ActiveRecord::Base
  has_many :posts
  has_many :post_authorities
  has_many :editable_post, through: :post_authorities, source: :post
end

class PostAuthority < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end

class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :post_authorities
  has_many :editors, through: :post_authorities, source: :user

  <!-- 定義在model裡的method可以在view裡使用 -->

  <!-- 作者有權限編輯 -->
  def is_written_by?(user)
    user && user == author
  end

  <!-- 授權的人能夠編輯 -->
  def is_authorized_to_edit_by?(user)
    post_authority.where(post_id: self.id, user_id: user.id)
  end
end
```

## model配置，WG第三版：這是錯誤的

```
class User < ActiveRecord::Base
  has_many :post_authorities
  has_many :posts, through: :post_authorities
end

class PostAuthority < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end

class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :post_authorities
  has_many :users, through: :post_authorities

  <!-- 作者有權限編輯 -->
  def is_written_by?(user)
    user && user == author
  end

  <!-- 授權的人能夠編輯 -->
  def is_authorized_to_edit_by?(user)
    post_authority.where(post_id: self.id, user_id: user.id)
  end
end
```

在此說明一下錯在哪。我們可以看
- [Active Record Association « Rails 101 S](http://rails101s.logdown.com/posts/211428-active-record-association)，搜尋「:source」
- [rails API - has_many](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many)，搜尋「:source」然後看下面的 **Option examples** 最後一個使用`source: :user`的範例

從上面兩個連結，看了三次`:source`如何使用的範例之後，再回去看[Active Record Association « Rails 101 S](http://rails101s.logdown.com/posts/211428-active-record-association)這篇。一樣搜尋「:source」

sdlong舉了一個很棒的範例：

他在User與Group之間是透過group_user這張中介表。而多對多的部分

User
```
has_many :group_users
has_many :participated_groups, :through => :group_users, :source => :group
```

Group
```
has_many :group_users
has_many :members, :through => :group_users, :source => :user
```

我們可以看到，User與Group這兩個model`:through`(透過)`:group_users`來連結。

User `:participated_groups`(參與哪些群組)，這些群組被記錄起來(`:source => :group`)，透過(`:through`)中介表(`:group_users`)來保存

Group有很多`:members`(組員)，這些組員被記錄下來(`:source => :user`)，透過(`:through`)中介表(`:group_users`)來保存


依此概念回到我們這邊的例子，理所當然變成：

User
```
has_many :post_authority
has_many editable_post through: :post_authority, source: :post
```

Post
```
has_many :post_authority
has_many :editors, through: :post_authorities, source: :user
```
---------

另一個讓我思考許久的問題：**多對多的controller要怎麼寫**，資料如何被存進去中介表裡面。

我們再來看看sdlong的rails101s的[groups_controller.rb](https://github.com/sdlong/rails101s/blob/master/app/controllers/groups_controller.rb)

可以看到sdlong把 **user 加入某個group** 這行為寫成`join`function

rails101s/app/controllers/groups_controller.rb
```
def create
  @group = current_user.groups.create(group_params)

  if @group.save
    current_user.join!(@group)
    redirect_to groups_path
  else
    render :new
  end
end
```

現在讓我們去看sdlong的[5. user 可以加入、退出 group « Rails 101 S](http://rails101s.logdown.com/posts/247886-20-5-user-can-add-exit-group)這篇文章，然後我再重新依我的邏輯解釋一遍。

在這邊以`join`為例。開啟chrome，在[5. user 可以加入、退出 group « Rails 101 S](http://rails101s.logdown.com/posts/247886-20-5-user-can-add-exit-group)這篇文章搜尋「join」，頁面往下拉看到`app/views/group/show.html.erb`

sdlong這篇的情境是，我想要加入群組，所以在view裡

```
<% if current_user.present? %>
  <% if current_user.is_member_of?(@group) %>
    <%= link_to("Quit Group", quit_group_path(@group), method: :post, class: "btn btn-danger") %>
  <% else %>
    <%= link_to("Join Group", join_group_path(@group), method: :post, class: "btn btn-info") %>
  <% end %>
<% end %>
```

我們可以看到`link_to`的Join Group這個超連結，他的路由是`join_group_path(@group)`，傳了一個HTML Verb `post`。

但是`join_group_path`這路由是怎麼來的？

我們先回想一下，**加入群組** 這件事是一個 **action**。

接著我們回去思考路由的寫法，習慣上我們會用在`routes.rb`裡用`resources:`去寫，這好處是我們直接用rails的RESTful路由去寫。

這樣寫很方便，但在用RESTful之前，原本的寫法讓我們看以下例子，直接看範例code
- [Ruby on Rails 實戰聖經 | 路由(Routing)](https://ihower.tw/rails/routing.html)，搜尋「Regular Routes」
- [rails API - ActionDispatch::Routing](http://api.rubyonrails.org/classes/ActionDispatch/Routing.html)，搜尋「Non-resourceful routes」

用Non-resourceful routes的寫法很直觀，以ihower的例子：

`get 'meetings/:id', :to => 'events#show'`

我用HTTP Verb `get`去撈`meetings/:id`這串網址，他會讓controller導到`events#show'`，`events#show'`代表events controller的show action

用RESTful routes，也就是習慣寫的`resources: :posts`就會幫我們省下很多一個個自己去定義HTTP Verb與controller#action的匹配。

再來回到sdlong的Join Group的按鈕，我們知道他的路由`join_group_path`這跟只用`resources:`寫不同，於是我們去看rails101s的[routes.rb](https://github.com/sdlong/rails101s/blob/master/config/routes.rb)

我們可以在裡面看到他的resources層層寫法

```
resources :groups do
  resources :posts, except: [:show, :index]

  member do
    post :join
    post :quit
  end
end
```

這其實很好懂，我必須要進入一個群組(`:group`)，才會看到人家發的文章(`post`)，進到群組裡你可以決定要加入(`join`)或退出(`quit`)。

透過上面這段敘述，就能清楚知道sdlong的resources層層寫法了，其中有個有趣的
```
member do
  post :join
  post :quit
end
```

就是在`routes.rb`裡下了`member`這關鍵字，我們才能夠在`link_to`使用`join_group_path(@group)`，現在看一下這幾篇文章
- [JCcart GitHub - Step.13 購物車的邏輯](https://github.com/NickWarm/jccart/wiki/Step.13-購物車的邏輯)，搜尋「member」
- [rails API - member](http://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Resources.html#method-i-member)
- [Ruby on Rails 實戰聖經 | 路由(Routing)](https://ihower.tw/rails/routing.html)，搜尋「member」

看完後就能理解
```
resources :groups do
  resources :posts, except: [:show, :index]

  member do
    post :join
    post :quit
  end
end
```

上面這段code想表達：group controller中，我想進行`join`與`quit`這兩個action。

於是我們再回去看rails101s的[groups_controller](https://github.com/sdlong/rails101s/blob/master/app/controllers/groups_controller.rb)，可以看到裡面定義了`join`與`quit`這兩個action。
```
def join
  @group = Group.find(params[:id])

  if !current_user.is_member_of?(@group)
    current_user.join!(@group)
    flash[:notice] = "加入本討論版成功！"
  else
    flash[:warning] = "你已經是本討論版成員了！"
  end

  redirect_to group_path(@group)
end

def quit
  @group = Group.find(params[:id])

  if current_user.is_member_of?(@group)
    current_user.quit!(@group)
    flash[:alert] = "已退出討論版"
  else
    flash[:warning] = "你不是本討論版成員，怎麼退出 XD"
  end

  redirect_to group_path(@group)
end
```

再來，我們看`join` action。

```
def join
  @group = Group.find(params[:id])

  if !current_user.is_member_of?(@group)
    current_user.join!(@group)
    flash[:notice] = "加入本討論版成功！"
  else
    flash[:warning] = "你已經是本討論版成員了！"
  end

  redirect_to group_path(@group)
end
```

`if !current_user.is_member_of?(@group)`這段，可能會是新手第一次閱讀時不懂的地方。

先把`!current_user.is_member_of?(@group)`看成`!(current_user.is_member_of?(@group))`，`!`放在前面代表 **否定**，就像`!=`。

先直觀地看`current_user.is_member_of?(@group)`，語義就是「現在這個成員是不是在這群組」。

如果這串是true，再加上`!`，`!true` is equal to `false`，就會變成false，就會跳到else那串。

如果是false，也就是「現在這成員不在這群組」，false前面加上!，`!false` is equal to `true`，就會跳到要加入討論板那串。


> PS：我個人是不太喜歡這樣寫，太不直觀了

接著我們看`current_user`，`current_user`是devise內建的helper，只有登入後的帳號會使用
- [plataformatec/devise GitHub](https://github.com/plataformatec/devise)，搜尋「current_user」

我們可以看到`current_user`使用了`is_member_of`、`join!`這兩個function，過去提過你要使用的function會定義在model裡面，所以我們去rails101s的[user model](https://github.com/sdlong/rails101s/blob/master/app/models/user.rb)可以看到這些方法。

User model
```
has_many :participated_groups, through: :group_users, source: :group

def is_member_of?(group)
  participated_groups.include?(group)
end

def join!(group)
  participated_groups << group
end
```

這邊需要搭配groups_controller裡的join action來上下對照
```
def join
  @group = Group.find(params[:id])

  if !current_user.is_member_of?(@group)
    current_user.join!(@group)
    flash[:notice] = "加入本討論版成功！"
  else
    flash[:warning] = "你已經是本討論版成員了！"
  end

  redirect_to group_path(@group)
end
```

一開始`current_user`先透過`s_member_of?`來判斷是不是該群組(`group`)的成員。

我們可以在join action中看到，一開始先撈出該群組的id，然後存成`@group`，所以`@group`是一個id數字，這個id數字代表某一個group。

接著我們看到，`is_member_of?`裡面定義的內容是`participated_groups.include?(group)`

語意上就是「是否有包含在參與的群組裡面」，`participated_groups`是我們多對多關聯時所定義的

`has_many :participated_groups, through: :group_users, source: :group`

「是否有包含在參與的群組裡面」，如果是false，就會執行`current_user.join!(@group)`

接著我們看`join!`

```
def join!(group)
  participated_groups << group
end
```

先說`<<`，他其實就是array的push
- [Class: Array (Ruby 2.3.1) - push](http://ruby-doc.org/core-2.3.1/Array.html#method-i-push)
- [Class: Array (Ruby 2.3.1) - <<](http://ruby-doc.org/core-2.3.1/Array.html#method-i-3C-3C)

所以說，`join!`就是把一個group的id放進`participated_groups`，也就是我們的中介表裡面。

如此一來，我們就能透過中介表知道誰是該群組的組員，而誰不是。

基本上`group_users`是我們的中介表，而`participated_groups`可以看作中介表中，一筆又一筆的資料，我們可以搭配[Active Record Association « Rails 101 S](http://rails101s.logdown.com/posts/211428-active-record-association)，然後搜尋「participated_groups」看下面的表格

在研究關聯的設定時發現[4.3 has_many 關聯參考手冊 - Active Record 關聯 — Ruby on Rails 指南](http://rails.ruby.tw/association_basics.html#has-many-關聯參考手冊)的 **4.3.1.2** 節寫到「collection<< 方法透過將外鍵設為加入物件的主鍵，新增一個或多個物件到關聯集合」，例如：
```
@customer.orders << @order1
```

---

## model配置，WG第二版：第一版忘記備份...


```
class User < ActiveRecord::Base
  has_many :authorities
  has_many :posts, through: :authorities
end

class PostAuthority < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end

class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :post_authorities
  has_many :users, through: :post_authorities

  def is_editable_by?(user)
    user && user == author
  end

  def is_delegated_authority_to_edit_by?(user)
    post_authority.where(post_id: self.id, user_id: user.id)
  end
end
```

## model配置，Lui建議的寫法：第二版
概念：

我發一篇文章，post model裡有這篇文章的id，中介表裡，有這篇文章的post_id，以及可以編輯的人的user_id。

現在，我要判斷哪些人可以編輯，只要用SQL的條件語法，在中介表中撈出「這篇文章的post_id與相符合的user_id」。

我不需要把中介表全部都掃一遍，才撈出我要的東西

where
- [Ruby on Rails 實戰聖經 | ActiveRecord - 基本操作與關聯設計](https://ihower.tw/rails/activerecord.html)，搜尋「where」
- [rails API - where](http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where)
- [SQL WHERE - 1Keydata SQL 語法教學](http://www.1keydata.com/tw/sql/sqlwhere.html)

```
class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :post_authorities
  has_many :users, through: :post_authorities

  def  is_editable_by?(user)
     PostAuthority.where( user_id: user.id , post_id: self.id)
  end
end
```

這邊的`post_id: self.id`，會用`self.id`寫，是因為當我們在文章的顯示頁面時，是透過`@post`來撈資料，而`self`就是代表`@post`

## model配置，Lui建議的寫法：第一版

缺點：寫`post_authority.include?(user.id)`，透過`include?`要把中介表`post_authority`全部都搜尋一遍，才丟出我們要的，這樣寫效能沒那麼好
```
class User < ActiveRecord::Base
  has_many :authorities
  has_many :posts, through: :authorities
end

class PostAuthority < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end

class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :post_authorities
  has_many :users, through: :post_authorities

  def is_editable_by?(user)
    post_authority.include?(user.id)
  end
end
```





# 該篇post的view裡的edit button
參考
- sdlong的這篇：[4. 建立使用者功能 « Rails 101 S](http://rails101s.logdown.com/posts/247881-20-4-adding-user-functions)
- [一些 Ruby 命名的技巧 « Blog.XDite.net](http://blog.xdite.net/posts/2012/07/25/some-naming-tips)

## post的view裡的edit button，第三版

```
<!-- 作者自己可以編輯 -->
<% if post.is_written_by?(current_user) %>
  <%= link_to "edit" %>
  <%= link_to "delete" %>
<% end %>


<!-- 授權給他人編輯 -->
<% if @post.is_authorized_to_edit_by?(current_user) %>
  <%= link_to "edit" %>
<% end %>
```

## post的view裡的edit button，第二版

```
<!-- 作者自己可以編輯 -->
<% if post.is_editable_by?(current_user) %>
  <%= link_to "edit" %>
  <%= link_to "delete" %>
<% end %>


<!-- 開放給他人編輯 -->
<% if @post.is_delegated_authority_to_edit_by?(current_user) %>
  <%= link_to "edit" %>
<% end %>
```


## post的view裡的edit button，第一版：已廢棄

```
<!-- 作者自己可以編輯 -->
<% if post.editable_by(current_user) %>
  <%= link_to "edit" %>
  <%= link_to "delete" %>
<% end %>


<!-- 開放給他人編輯 -->
<% if @post.is_editable_by?(current_user) %>
```

# controller
一個實驗室成員，可以發很多實驗室公告，`user has_many posts`，一對多

## build vs create
build：多用於一對多情況下
- build 幾乎等於 new
- create = build + save，這觀念非常好懂，直接看rails API比較build與create就能理解了。
  - [rails API - build](http://api.rubyonrails.org/classes/ActiveRecord/Associations/CollectionProxy.html#method-i-build)
    - 我們可以看到用`person.pets.build`後，產生出的結果`Pet id: nil`，代表它還沒儲存，必須再用`save`才會存到資料庫裡
  - [rails API - create](http://api.rubyonrails.org/classes/ActiveRecord/Associations/CollectionProxy.html#method-i-create)
    - 我們可以看到`person.pets.create(name: 'Fancy-Fancy')`後，產出的結果`Pet id: 1`，代表這筆資料已經存到資料庫裡去了
  - [Rails new, build, create, save方法區別(轉) « HEROGWP's Blog](http://herogwp.logdown.com/posts/2015/02/19/rails-new-build-create-and-save-the-difference)
  - [ruby on rails - The differences between .build, .create, and .create! and when should they be used? - Stack Overflow](http://stackoverflow.com/questions/403671/the-differences-between-build-create-and-create-and-when-should-they-be-us)
  - [ruby on rails - Build vs Create in has many through relationship - Stack Overflow](http://stackoverflow.com/questions/26813274/build-vs-create-in-has-many-through-relationship)

## 為何要用build
參考以下幾篇
- [一對多關聯](http://openhome.cc/Gossip/Rails/OneToMany.html)
- [rails API - has_many](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many)
- [ActiveRecord::Associations::ClassMethods](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)

舉例來說`user has_many posts`，用了`has_many`來關聯後，我們可以使用`clear`、`empty?`、`size`、`find`、`where`、`exists?`、`build`、`create`

雖然說，new與build幾乎一樣，但由於我們用了`has_many`來關聯，所以我們只能用`build`來產生新的物件

## 實作controller

知道build與create的不同後，我們可以來實作 **一對多** 的controller了

ref
- [Ruby on Rails 實戰聖經 | RESTful 應用實作](https://ihower.tw/rails/restful-practices.html#sec2)，搜尋「build」
- [rails101s GitHub - posts_controller.rb](https://github.com/sdlong/rails101s/blob/master/app/controllers/posts_controller.rb)
- [mackenziechild/wiki GitHub - articles_controller.rb](https://github.com/mackenziechild/wiki/blob/master/app/controllers/articles_controller.rb)
- [FUSAKIGG GitHub - orders_controller.rb](https://github.com/lustan3216/FUSAKIGG/blob/master/app/controllers/orders_controller.rb)
- [關聯資料的 update - 雜談 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/update/550/2)





實驗室公告，Post model
- `title:string content:text user_id:integer`
- WYSIWYG editor

中介表，post_authority model
- `post_id:integer, user_id:integer`

## controller，第二版


## controller，第一版：這是錯的

```
def new
  @post = current_user.posts.build
  @post_authority = PostAuthority.new
end

def create
  @post = current_user.posts.build(post_params)
  @post_authority = PostAuthority.new(post_authority_params)

  if @post.save
    @post_authority.save
    redirect_to @post
  else
    render 'new'
  end  
end

def edit
  @post = current_user.posts.find(params[:id])
  @post_authority = PostAuthority.find(params[:id])
end

def update
  if @post.update(post_params)
    @post_authority.update(post_authority)
    redirect_to @post
  else
    render 'edit'
  end
end

def post_params
  params.require(:post).permit(:title, :content, :user_id)
end

def post_authority_params
  params.require(:post_authority).permit(:user_id, :post_id)
end
```

後來發現，這會與表單一起改，於是



# 表單設計情境

情境
- 發表一篇文章，指派「特定」實驗室成員擁有編輯權限。
- 透過 **下拉選單**「選複數個人」，但是下拉選單只需要有還在學校的成員，「不需要畢業成員」

為了判斷實驗室成員是「在學」還「已畢業」，我在user model有設一個欄位`has_graduated:boolean`

Lui建議的寫法
```
<%= f.select :user_id, User.all.map{|x| [x.name , x.id] unless x.has_gratuated } %>
```

unless只是「if的否定」，if是true就會run，unless是false就會run
- [Ruby Doc - Class: Object - unless](http://ruby-doc.org/docs/keywords/1.9/Object.html#method-i-unless)
- [Ruby 使用手冊 | 控制結構](http://guides.ruby.tw/ruby/control.html)，搜尋「unless」


# 單選下拉選單

影片教學
- [dropdown in rails - YouTube](https://www.youtube.com/watch?v=B2uEbkAk6aI)
- [Integrating a Dropdown Element into a Rails Form - YouTube](https://www.youtube.com/watch?v=FWIXWutlxIg)

ihower教學：「單選一個」的下拉選單
- [Ruby on Rails 實戰聖經 | RESTful 應用實作](https://ihower.tw/rails/restful-practices.html)，搜尋「用 select 單選一個 category」

rails原生的下拉選單
- [rails API - select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-select)

JCcart
- [Step.12 類別的下拉選單 · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.12--%E9%A1%9E%E5%88%A5%E7%9A%84%E4%B8%8B%E6%8B%89%E9%81%B8%E5%96%AE)

# 多重下拉框

發表一篇文章，要開authority給共同編輯者
- 共同編輯者可能有數位，使用多 **重選單**
- 使用前端套件：[select2 - multiple](https://select2.github.io/examples.html#multiple)
- [Rails 页面多选下拉框, form_for, form_tag 使用技巧及 select2 使用 - 简书](http://www.jianshu.com/p/7494b58f2498)
- [Rails 页面多选下拉框, form_for, form_tag 使用技巧及 select2 使用 - 只想安静地做个美男子 - 开源中国社区](https://my.oschina.net/huangwenwei/blog/730283)
  - `select(object, method, choices = nil, options = {}, html_options = {}, &block)`
  - [rails API - select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-select)
  - [Ruby on Rails form_for select field with class - Stack Overflow](http://stackoverflow.com/questions/4081907/ruby-on-rails-form-for-select-field-with-class)
  - [Ruby on Rails -- multiple selection in f.select - Stack Overflow](http://stackoverflow.com/questions/4864513/ruby-on-rails-multiple-selection-in-f-select)
  - [ruby on rails f.select options with custom attributes - Stack Overflow](http://stackoverflow.com/questions/5052889/ruby-on-rails-f-select-options-with-custom-attributes)
  - [rails API - options_for_select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-options_for_select)
  - [rails API - content_tag](http://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag)


### 多選下拉框，已廢棄
```
<%=
f.select :user_id,
         User.all.map{|x| [x.name, x.id] unless x.has_gratuated},
         { include_blank: true }, {class: "have_authority"}, {multiple: true}
%>         
```


### 先挖洞
參考自[jccart GitHub - Step.14 重頭戲：購物車的AJAX](https://github.com/NickWarm/jccart/wiki/Step.14-重頭戲：購物車的AJAX)


fix `app/views/layouts/application.html.erb`

```
<html>
<head>
  <title>MuCat</title>
  <%= stylesheet_link_tag    'application', media: 'all' %>
  <%= javascript_include_tag 'application' %>
  <%= csrf_meta_tags %>
  <%= yield :header %>
</head>
```

### form表單隨想

由於實驗室公告Post model與學習資源LearningNote model的表單設計不同

先前一直想到，不同表單設計要怎麼用

後來才想起來

不同model他的view，在rails的views資料夾裡會依據model不同去生成兩個獨立的資料夾，所以完全不用擔心表單，設計不同的問題，因為他們本就是各自獨立的，例如：[rails101s GitHub - rails101s/app/views/](https://github.com/sdlong/rails101s/tree/master/app/views)

### \_form.html.erb：第二版 2nd，已廢棄

其實是改`f.select`的使用權限，透過在post model裡定義的`is_written_by?()`，如果current_user是作者本人，就能夠設定，誰可以編輯文章，如果是被授權編輯文章的人，就不會有下拉選單可以選

fix `_form.html.erb`

```
<% content_for :header do %>
<script>
  $(".have_authority").select2();
</script>
<% end %>

<%= form_for @post do |f| %>
  ...
  <% if @post.is_written_by?(current_user) %>
    <%= f.select :user_id, User.all.map{|x| [x.name, x.id] unless x.has_graduated}
                 {include_blank: true}, {multiple: true}, {class: "have_authority"}
    %>
  <% end %>
  ...
<% end %>
```

與第二版1st的不同在於一寫筆誤

1st是寫
```
User.all.map{|x| x.name, x.id} unless x.has_graduated
```

這是不對的
- 第一：做下拉選單，從User model撈資料時，`x.name, x.id`應該放在中括號`[]`裡面
  - 正確：`User.all.map{|x| [x.name, x.id]}`
  - 參考自
    - [Ruby on Rails 實戰聖經 | RESTful 應用實作](https://ihower.tw/rails/restful-practices.html#sec2)，搜尋「讓 event 可以用 select 單選一個 category」
    - [Step.12 類別的下拉選單 · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.12--%E9%A1%9E%E5%88%A5%E7%9A%84%E4%B8%8B%E6%8B%89%E9%81%B8%E5%96%AE)
- 第二：我們用`unless x.has_graduated`這應該放在`User.all.map{|x|...}`裡面才對，這筆誤真的該牢記在心
  - 正確：`User.all.map{|x| [s.name, x.id] unless x.has_graduated}`

### \_form.html.erb：第二版 1st，已廢棄

其實是改`f.select`的使用權限，透過在post model裡定義的`is_written_by?()`，如果current_user是作者本人，就能夠設定，誰可以編輯文章，如果是被授權編輯文章的人，就不會有下拉選單可以選

fix `_form.html.erb`

```
<% content_for :header do %>
<script>
  $(".have_authority").select2();
</script>
<% end %>

<%= form_for @post do |f| %>
  ...
  <% if @post.is_written_by?(current_user) %>
    <%= f.select :user_id, User.all.map{|x| x.name, x.id} unless x.has_graduated
                 {include_blank: true}, {multiple: true}, {class: "have_authority"}
    %>
  <% end %>
  ...
<% end %>
```

### \_form.html.erb：第一版，已廢棄

~~fix `new.html.erb`、`edit.html.erb`~~

fix `_form.html.erb`

```
<% content_for :header do %>
<script>
  $(".have_authority").select2();
</script>
<% end %>

<%= form_for %>
  ...
  <%= f.select :user_id, User.all.map{|x| x.name, x.id} unless x.has_graduated
               {include_blank: true}, {multiple: true}, {class: "have_authority"}
  %>
  ...
<% end %>
```

# 多對多 ref

- [#82- Many to Many Association User and Stock in ruby on rails - YouTube](https://www.youtube.com/watch?v=e0JUKvYk1Lo)
- [rails Guide - 2.4 has_many :through 關聯](http://rails.ruby.tw/association_basics.html#has-many-through-關聯)
- [rails Guide - 2.8 has_many :through 與 has_and_belongs_to_many 的應用場景](http://rails.ruby.tw/association_basics.html#has-many-through-與-has-and-belongs-to-many-的應用場景)

搜尋「多對多關聯」
- [Active Record Association « Rails 101 S](http://rails101s.logdown.com/posts/211428-active-record-association)
  - [rails101s/app/models/group.rb](https://github.com/sdlong/rails101s/blob/master/app/models/group.rb)
  - [rails101s/app/models/group_user.rb](https://github.com/sdlong/rails101s/blob/master/app/models/group_user.rb)
  - [rails101s/app/models/user.rb](https://github.com/sdlong/rails101s/blob/master/app/models/user.rb)
  - [rails101s/db/schema.rb](https://github.com/sdlong/rails101s/blob/master/db/schema.rb)
- [Ruby on Rails 實戰聖經 | ActiveRecord - 基本操作與關聯設計](https://ihower.tw/rails/activerecord.html)
- [RailsFun.tw 新手教學 day2 HD 多對多問題 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/railsfun-tw-day2-hd/754)

# Lui 建議

## 中介表：第一版，已廢棄

研究many to many

中介表的欄位是 `user_id post_id is_editable is_readable`


這樣要再弄個關聯表

在弄個關聯表

一般是has_many post

但中間就在多個 中介表

這中介表的欄位是 user_id post_id is_editable is_readable

但是你的中介表

可以叫做authoiry

authority

中介表可以亂取

反正我幫你想好了

你的中介表就叫做authority這個了

然後多兩個column

一個是is_readable 一個是is_editable

這樣

然後給預設都是false

然後admin可以決定哪個使用者可以對哪篇文章做閱讀或修改

就這樣囉～

或是一個editable也可以啦

看你要做多複雜而已

但概念就是這樣囉
