# controller如何設計

# 舊的寫法為何不妥

為了詳細解釋，在此先列出原始的想法

## controller，第一版：準備廢棄

他的邏輯其實是有意義的，但是現在有更好的寫法

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

新的寫法會把表單的邏輯整個大改，我們先來看看已廢棄的表單第二版

### \_form.html.erb：第二版 2nd，準備廢棄

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

這是個不恰大的設計，要講必須把model也一起拉進來講


### model配置，WG第四版：準備廢棄


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

---

# 開始詳細說明論述

首先回歸我的需求：

>傳統A發了一篇文章，只有A有權限編輯
>
>我現在想要A發一篇文章，可以給特定的B或C或D來編輯A的文章，其他人不可以編輯


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



於是表單的程式碼會像是
```
form_for @post do |f|
  f.title
  f.text
  f.select?????

```

你會發現，如果用傳統的`f.select`會不知道要如何把資料存到`post_authority`中介表裡去。

傳統`f.select`只會讓我們存到post model去。如
- [JCcart - Step.12 類別的下拉選單](https://github.com/NickWarm/jccart/wiki/Step.12--類別的下拉選單)
- [rails API - select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-select)
- [3.2 處理 Models 的下拉選單 - Action View 表單輔助方法 — Ruby on Rails 指南](http://rails.ruby.tw/form_helpers.html#處理-models-的下拉選單)


後來我看到這影片後，才領悟到可以用`fields_for`來讓我們存到另一個model，用`collection_select`來生出多選選單。
- [Tutorial: Multi Select Drop Down with Ruby on Rails - YouTube](https://www.youtube.com/watch?v=ZNrNGTe2Zqk&t=34s)


影片有幾個有趣的點
1. 他是rails3的寫法，rails3沒有使用strong parameter，而是採用`attr_accessible`來處理傳到model的資料(請見[3:09](https://youtu.be/ZNrNGTe2Zqk?t=189))。所以我們有必要改成strong parameter的寫法
2. 再來是，存到中介表的寫法，這影片中的多重下拉選單的情境是「新增一位作者，用多選單選取寫過的數本著作」。
   - 他有三個model：author、authorbook、book。
   - authorbook是另外兩個model的中介表。(可以從[3:52](https://youtu.be/ZNrNGTe2Zqk?t=232)開始觀看)
   - 先看[5:32](https://youtu.be/ZNrNGTe2Zqk?t=332)，知道如何在new action裡撈資料
   - 繼續看影片看到[6:52](https://youtu.be/ZNrNGTe2Zqk?t=412)，會知道如何用`fields_for`來把資料存到中介表`authorbook`裡去，並透過`collection_select`來做多選選單
3. 最後是看controller，請看[9:00](https://youtu.be/ZNrNGTe2Zqk?t=540)。影片中透過`collection_select`撈取book model來選兩本書，接著用`fields_for`存入中介表`authorbook`。
   - 按下commit把表單傳送出去。接著去controller，來處理接收表單的params。由於影片中選了兩本書，所以邏輯上我們應該讓params用`each`去撈`book`然後把它存到`authorbook`裡去，如[10:09](https://youtu.be/ZNrNGTe2Zqk?t=609)所示。

#### 理解rails的下拉選單怎麼做
- [3 輕鬆製作下拉式選單 - Action View 表單輔助方法 — Ruby on Rails 指南](http://rails.ruby.tw/form_helpers.html#輕鬆製作下拉式選單)
  - 透過select_tag與options_for_select組成下拉選單
    - [rails API - select_tag](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-select_tag)
    - [rails API - options_for_select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-options_for_select)
  - select = select_tag + options_for_select
    - [JCcart - Step.12 類別的下拉選單](https://github.com/NickWarm/jccart/wiki/Step.12--類別的下拉選單)
    - [3.2 處理 Models 的下拉選單](http://rails.ruby.tw/form_helpers.html#處理-models-的下拉選單)
    - [rails API - select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-select)
  - [3.3 從任何物件集合產生選項](http://rails.ruby.tw/form_helpers.html#從任何物件集合產生選項)
    - rails用`select_tag`生成HTML的`<select>`，用`options_for_select`生成要選取的`<option>`。
    - 在`select`中，我們學會了用ruby語法寫出`City.all.map {|city| [city.name, city.id]}`來獲得options
    - 為了省掉寫ruby語法撈model建構options，可以直接用`options_from_collection_for_select`這helper，用更簡短的code去取得options
    - 若是「撈model建構options + 自動生成select」想用helepr包好，可以用`collection_select`
    - `collection_select`與`select`的差異僅在於：`select`我們要自己寫ruby用map來撈資料，而`collection_select`一次撈完外部model所有的資料
      - [rails API - options_from_collection_for_select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-options_from_collection_for_select)
      - [rails API - collection_select](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-collection_select)

#### fields_for如何使用
- [Tutorial: Multi Select Drop Down with Ruby on Rails，從5:32開始](https://youtu.be/ZNrNGTe2Zqk?t=332)
- [9 打造複雜表單](http://rails.ruby.tw/form_helpers.html#打造複雜表單)
- [rails API - fields_for](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for)
  - 透過fields_for，讓我們能在表單中，**存資料到外部model**
  - 現在開始解釋，首先你會注意到影片中的寫法與rails API的寫法不太一樣
  - rails API中的寫法`<%= fields_for :permission, @person.permission do |permission_fields| %>`多了一個參數`:permission`
  - 而rails Guide卻只有用symbol來存資料到外部model。其實rails API就已經有解答了。
  - 我們可以在[fields_for](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for)這邊的第三個example code看到。上面有段文字說，我們可以選擇性地使用`<%= fields_for @person.permission do |permission_fields| %>`這樣的寫法來存資料到外部model的資料。
  - 所以，影片的寫法是用rails API中的第三個example code的寫法，只是它把`@authorbook`定義在new action裡，而rails Guide的寫法是參照rails API的第二個example code的寫法。

#### accepts_nested_attributes_for的使用
- 在[9 打造複雜表單](http://rails.ruby.tw/form_helpers.html#打造複雜表單)我們看到，會用到`accepts_nested_attributes_for`。
- 首先閱讀[Ruby on Rails 實戰聖經 | RESTful 應用實作](https://ihower.tw/rails/restful-practices.html)，搜尋「accepts_nested_attributes_for」
- 還記得我們在[Tutorial: Multi Select Drop Down with Ruby on Rails的10:03](https://youtu.be/ZNrNGTe2Zqk?t=603)看到，在rails3必須自己手寫去把params存到外部model，現在只要透過`accepts_nested_attributes_for`就能幫我們省去這步驟了。
- 但是，光是閱讀ihower的片段解釋是沒有感覺的。現在讓我們來看Xdite在台灣開的rails即戰力購物車的範例Artstore
- 首先，我們來看一下Artstore的model
  - product has_one :photo，一對一
    - product用`accepts_nested_attributes_for`傳資料給外部model `:photo`
  - photo belongs_to :product，然後`mount_uploader :image, ImageUploader`
  - PS：`mount_uploader`是Carrierwave實作圖⽚上傳所用到的，可以參考[Rails如何使用Carrierwave上傳圖片 « Springok's Blog](http://springok-blog.logdown.com/posts/2015/10/21/railsgem-how-to-use-carrierwave-upload-pictures)
  - 在Artsotre的photo model使用`mount_uploader :image, ImageUploader`，是為了把圖片存到photo model的image這個欄位，我們可以在[artstore/db/schema.rb](https://github.com/growthschool/artstore/blob/week-3/db/schema.rb)看到
- 接著，我們先看Artstore的表單[artstore/app/views/admin/products/new.html.erb](https://github.com/growthschool/artstore/blob/week-3/app/views/admin/products/new.html.erb)
  - 要送出一份表單到product model裡去，透過fields_for存資料到photo model的`:image`欄位裡去。
  - 所以，應該要在product model裡設`accepts_nested_attributes_for :photo`，正如[artstore/app/models/product.rb](https://github.com/growthschool/artstore/blob/week-3/app/models/product.rb)所寫的
- 看懂之後，我們再去看[9 打造複雜表單](http://rails.ruby.tw/form_helpers.html#打造複雜表單)就非常清楚一目瞭然了。

#### 使用accepts_nested_attributes_for後如何寫controller
- 接著是controller的部分，我們一樣去看[Artstore的products controller](https://github.com/growthschool/artstore/blob/week-3/app/controllers/admin/products_controller.rb)
- 一開始會看到跟[影片many to many，見6:08](https://www.youtube.com/watch?v=ZNrNGTe2Zqk&feature=youtu.be&t=540)直接用`build`的不一樣。Artstore是`product has_one :photo`的一對一
  - 閱讀[4 關聯完整參考手冊 - Active Record 關聯 — Ruby on Rails 指南](http://rails.ruby.tw/association_basics.html#關聯完整參考手冊)，搜尋「build_」時可以看到一段文字
    - 「在初始化 has_one 或 belongs_to 關聯時，必須使用 build_ 前綴的方法來新建關聯，而不是使用 has_many 或 has_and_belongs_to_many 關聯的 association.build 方法。」
    - 在ihower[Ruby on Rails 實戰聖經 | RESTful 應用實作](https://ihower.tw/rails/restful-practices.html)的「一對一 Resource」這章的 **案例一：建立Location表單** 這節，搜尋「build_」，也可以看到event model與location model這 **一對一** 關聯初始化是用`@event.build_location`
- 有了這概念後，Artstore的new action就能完全理解了，接著去看重頭戲create action，可以看到只要寫送出表單的product model，完全不用管外部的photo model，用了`accepts_nested_attributes_for`這真的非常方便。

我們要做多選下拉選單，時常會看到`multiple: true`
- 這個可以在[rails API - select_tag](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-select_tag)看到，搜尋「multiple」
- 而select，也可以用`multiple: true`：[Ruby on Rails 4 select multiple - Stack Overflow](http://stackoverflow.com/questions/23253449/ruby-on-rails-4-select-multiple)

通盤理解後，我們就不需要照影片的教學用`collection_select`來弄下拉選單。因為，我的情境「選取實驗室成員」這件事，必須選的是「還在學校的」，選單要自動略掉「已經畢業的」。依此邏輯，用`select`然後寫ruby去撈是最佳解。

有了這些概念後，我該學習的是，建多對多的表單時，strong parameter要如何寫

#### strong parameter要如何寫
- 你可以看到，官方API沒有教多對多的寫法：[ActiveRecord::NestedAttributes::ClassMethods](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)
- 於是我找了[Working with nested forms and a many-to-many association in Rails 4 - Created by Pete](http://www.createdbypete.com/articles/working-with-nested-forms-and-a-many-to-many-association-in-rails-4/)這篇
  - 他的strong parameter一開始會比較難理解，但我們直接看他的表單
  - 第一層用`form_for`傳到survey model
  - 第二層用`fields_for`傳到question model
  - fields_for裡面又包一層，第三層用`fields_for`傳到answer model，所以才會看到這種巢狀的strong parameter
- 最好理解的反倒是rails guide的[9.3 Controller 部分](http://rails.ruby.tw/form_helpers.html#controller-部分)這篇，從[9.2 嵌套表單](http://rails.ruby.tw/form_helpers.html#嵌套表單)看完接著看9.3，根本一眼瞬間一目了然。

#### 沒引用到，但是不錯的閱讀資料
- [has_many :through « tienshunlo's Blog](http://tienshunlo-blog.logdown.com/posts/736617-has-many-through)
- [新增PROFILE: view/dashboard/profile/new.html.erb « tienshunlo's Blog](http://tienshunlo-blog.logdown.com/posts/737360-view-dashboard-profile-newhtmlerb)
- [Strong Parameter 解釋 & 一對一關聯製作 - Rails - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/strong-parameter/442)
- [Forum Series Part 3: Nested Attributes and fields_for (Example) - GoRails](https://gorails.com/episodes/forum-nested-attributes-and-fields-for)
  - [excid3/gorails-forum GitHub](https://github.com/excid3/gorails-forum)

---

# 實作

### model配置，WG第五版


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

  accepts_nested_attributes_for :post_authorities, allow_destroy: true

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

默默地發現，`belongs_to :author, class_name: "User", foreign_key: :user_id`這寫法最初是參考rails101s與rails API所寫的，但我從來沒記錄過理由，請見
- [4.1 belongs_to 關聯參考手冊 - Active Record 關聯 — Ruby on Rails 指南](http://rails.ruby.tw/association_basics.html#belongs-to-關聯參考手冊)，請看 **4.1.2.5**，或搜尋「foreign_key」

### 路由設定

```
Rails.application.routes.draw do # 發表文章、編輯文章

  resources :learningnotes       # 學習資源
  resources :posts               # 實驗室公告
  resources :honors              # 榮譽榜
  resources :users               # 實驗室成員資料
  resources :professorworks      # 教授的著作

  devise_for :users              # 登入系統
  devise_for :managers

  get 'welcome/index'            # 首頁
  root 'welcome#index'

  namespace :dashboard do        # 實驗室成員：編輯個資、查看該帳號發表過什麼文章，點選文章後進入第一層觀看文章，並且編輯之
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

### \_form.html.erb：第三版


表單參考自
- [jccart/app/views/dashboard/admin/items/new.html.erb](https://github.com/NickWarm/jccart/blob/master/app/views/dashboard/admin/items/new.html.erb)
- [blog_course_demo/app/views/posts/\_form.html.erb](https://github.com/mackenziechild/blog_course_demo/blob/master/app/views/posts/_form.html.erb)
- [gorails-forum/app/views/forum_threads/\_form.html.erb](https://github.com/excid3/gorails-forum/blob/master/app/views/forum_threads/_form.html.erb)
- [9.2 嵌套表單 - Action View 表單輔助方法 — Ruby on Rails 指南](http://rails.ruby.tw/form_helpers.html#嵌套表單)
- [JCcart GitHub - Step.12 類別的下拉選單](https://github.com/NickWarm/jccart/wiki/Step.12--類別的下拉選單)

create `_form.html.erb`

```
<%= form_for @post do |f| %>

  <%= f.label :title %><br>
  <%= f.text_field :title %>

  <br>
  <br>

  <% if @post.is_written_by?(current_user) %>
    <%= f.fields_for @post_authorities do |p| %>
      <%= p.select :user_id, User.all.map{|x| [x.name, x.id] unless x.has_graduated},
                   {include_blank: true}, {multiple: true}, {class: "ui fluid dropdown"}
      %>
    <% end %>
  <% end %>
  <br>
  <br>

  <%= f.label :content, "Write your article here"%>
  <%= f.text_area :content%>


<% end %>
```

前幾版的下拉選單是select2寫的
```
<% if @post.is_written_by?(current_user) %>
  <%= f.fields_for @post_authorities do |p| %>
    <%= p.select :user_id, User.all.map{|x| [x.name, x.id] unless x.has_graduated},
                 {include_blank: true}, {multiple: true}, {class: "have_authority"}
    %>
  <% end %>
<% end %>
```

決定從select2改成使用[Dropdown | Semantic UI](http://semantic-ui.com/modules/dropdown.html#multiple-selection)改寫

首先，按照[Semantic-Org/Semantic-UI-Rails-LESS - GitHub](https://github.com/Semantic-Org/Semantic-UI-Rails-LESS)的教學，在Gemfile加入

```
gem 'less-rails-semantic_ui'
gem 'autoprefixer-rails'
```

然後`bundle install`




### controller，第二版

ref
- [Tutorial: Multi Select Drop Down with Ruby on Rails - YouTube，觀看5:55](https://youtu.be/ZNrNGTe2Zqk?t=355)
- [Tutorial: Multi Select Drop Down with Ruby on Rails - YouTube，觀看10:05](https://youtu.be/ZNrNGTe2Zqk?t=605)
- [4.3 has_many 關聯參考手冊 - Active Record 關聯 — Ruby on Rails 指南](http://rails.ruby.tw/association_basics.html#has-many-關聯參考手冊)的 **4.3.1.14**
- [Ruby on Rails 實戰聖經 | RESTful 應用實作](https://ihower.tw/rails/restful-practices.html)，搜尋「event has_many :attendees」

關聯用`build`的寫法
- [mackenziechild - wiki/app/controllers/articles_controller.rb](https://github.com/mackenziechild/wiki/blob/master/app/controllers/articles_controller.rb)
  - [wiki/app/models/user.rb](https://github.com/mackenziechild/wiki/blob/master/app/models/user.rb)
  - [wiki/app/models/article.rb](https://github.com/mackenziechild/wiki/blob/master/app/models/article.rb)
- [Artstore的products controller](https://github.com/growthschool/artstore/blob/week-3/app/controllers/admin/products_controller.rb)
  - [4.1 belongs_to 關聯參考手冊 - Active Record 關聯 — Ruby on Rails 指南](http://rails.ruby.tw/association_basics.html#belongs-to-關聯參考手冊)

關聯用`new`的寫法
- [sdlong - rails101s/app/controllers/posts_controller.rb](https://github.com/sdlong/rails101s/blob/master/app/controllers/posts_controller.rb)
  - [rails101s/app/models/group.rb](https://github.com/sdlong/rails101s/blob/master/app/models/group.rb)
  - [rails101s/app/models/post.rb](https://github.com/sdlong/rails101s/blob/master/app/models/post.rb)
- [GoRails - gorails-forum/app/controllers/forum_threads_controller.rb](https://github.com/excid3/gorails-forum/blob/master/app/controllers/forum_threads_controller.rb)
  - [gorails-forum/app/models/forum_thread.rb](https://github.com/excid3/gorails-forum/blob/master/app/models/forum_thread.rb)
  - [gorails-forum/app/models/forum_post.rb](https://github.com/excid3/gorails-forum/blob/master/app/models/forum_post.rb)

這邊滿奇妙的，有人用build寫，有人用new寫，以前也看過build與new其實沒太大差別。當時做了筆記「new與build幾乎一樣，但由於我們用了`has_many`來關聯，所以我們只能用`build`來產生新的物件」

現在我決定用build來寫，主要是因為[rails Guide的4.3.14](http://rails.ruby.tw/association_basics.html#has-many-關聯參考手冊)裡都寫了

>collection.build 方法回傳一個或多個新關聯物件。這些物件由傳入的屬性來初始化，同時會自動設定外鍵。但關聯物件仍未儲存至資料庫。


```
before_action :find_post, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]

def new
  @post = current_user.posts.build
  @post_authority = @post.post_authorities.build
end

def create
  @post = current_user.posts.build(post_params)

  if @post.save
    redirect_to @post
  else
    render 'new'
  end  
end

def edit
end

def update
  if @post.update(post_params)
    redirect_to @post
  else
    render 'edit'
  end
end

def destroy
  @post.destroy
end

private

def find_post
  @post = Post.find(params[:id])
end

def post_params
  params.require(:post).permit(:title, :content, :user_id,
                                post_authorities_attributes: [:id, :post_id, :user_id])
end
```
