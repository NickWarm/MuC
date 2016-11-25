# 情境

實驗室成員新增論文

MuCat_v1 放棄nested_form。決定採用Dynamic_form

# 我的寫法 v1

情境：

實驗室成員新登入 -> 依據信箱自動創建帳號  -> 點到實驗室成員頁面  -> 修改自己的個人資料

跟老師要歷年實驗室成員的信箱

我自己手動一個一個幫他們註冊，預先密碼用`lab515`

在controller設定
```
if member.profile.blank?
  render to edit頁面
else
  render to 實驗室首頁

```

建立
- 名字
- 入學學年
- 簡介
- 論文題目 (一個或一個以上)

MuCat_v1 放棄nested_form。決定採用Dynamic_form
- [Dynamic Input Fields in Rails | Dan Barbarito - Student, Web Developer, Musician, Programmer](http://www.barbarito.me/blog/dynamic-input-fields-in-rails/)
  - 用CoffeScript的寫法
  - [ActionView::Helpers::FormHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html)，點進去後搜尋「Resource-oriented style」，讀完後就能看懂這篇的`form_for`在寫什麼
  - 這篇很棒，請見 **筆記1**
- [實作動態增加的表單 - RailsFun 新手教學 Day 6](https://youtu.be/r1pq5wvRS7c?list=PLJ6M-k9dQEQ3VsyOZQwjZ5GdjaLJH3eB_&t=3254)
  - 可以搭配[RailsDemoHasMany/multi.html.erb](https://github.com/JokerCatz/RailsDemoHasMany/blob/master/app/views/items/multi.html.erb)這code來閱讀，會比較清楚
  - [text_field_tag - rails API](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-text_field_tag)
  - 有教 [params 的包裝與使用 - Rails Fun](http://railsfun.tw/t/params/55) 這篇文章要怎麼看，可以理解要怎麼送資料進controller


# 可能的問題

MuCat_v1先用nested_form去實作，最簡單的那種，不要用深度解析的寫法
- 必須考量，**刪除論文**
  - 放棄nested_form，改成獨立頁面做dynamic form

# 學習資源

## Dynamic Form

#### form_tag
- [form_tag與form_for的差別 - RailsFun.tw 新手教學 day3 HD](https://youtu.be/MVMrVl0Pj80?t=5392)
- [ActionView::Helpers::FormTagHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-form_tag)
- [form_tag / form_for 互換使用 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/form-tag-form-for/747/4)
  - 這篇很讚，學會不用`form_for`用`form_tag`自幹自己想要的表單

#### 影片
- [實作動態增加的表單 - RailsFun 新手教學 Day 6](https://youtu.be/r1pq5wvRS7c?list=PLJ6M-k9dQEQ3VsyOZQwjZ5GdjaLJH3eB_&t=3254)
  - 可以搭配[RailsDemoHasMany/multi.html.erb](https://github.com/JokerCatz/RailsDemoHasMany/blob/master/app/views/items/multi.html.erb)這code來閱讀，會比較清楚
  - [text_field_tag - rails API](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-text_field_tag)
  - 有教 [params 的包裝與使用 - Rails Fun](http://railsfun.tw/t/params/55) 這篇文章要怎麼看，可以理解要怎麼送資料進controller
- [Ruby on Rails - Railscasts PRO #403 Dynamic Forms (pro) - YouTube](https://www.youtube.com/watch?v=t_FNKR7jahM)
  - 雖然是[用coffescript](https://youtu.be/t_FNKR7jahM?t=283)，不過那code看起來就jQuery啊XD

#### 文章
- [Ruby on Rails - Accepts_nested_attributes_for - Leon's Blogging](http://mgleon08.github.io/blog/2015/12/13/ruby-on-rails-accepts-nested-attributes-for/)
- [Dynamic Input Fields in Rails | Dan Barbarito - Student, Web Developer, Musician, Programmer](http://www.barbarito.me/blog/dynamic-input-fields-in-rails/)
  - 用CoffeScript的寫法
  - [ActionView::Helpers::FormHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html)，點進去後搜尋「Resource-oriented style」，讀完後就能看懂這篇的`form_for`在寫什麼
  - 這篇很棒，請見 **筆記1**
  - [respond_to 與 respond_with](http://openhome.cc/Gossip/Rails/RespondToWith.html)
  - [respond_to 與 respond_with | Rails 102](https://rocodev.gitbooks.io/rails-102/content/chapter1-mvc/c/respond_to__respond_with.html)
  - [respond_to - rails API](http://api.rubyonrails.org/classes/ActionController/MimeResponds.html#method-i-respond_to)
- [RailsFun 新手教學 Day 6 實作動態增加的表單](https://youtu.be/r1pq5wvRS7c?list=PLJ6M-k9dQEQ3VsyOZQwjZ5GdjaLJH3eB_&t=3254)
- [form_for相關問題：想要把複選題改成單選題 - Rails - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/form-for/445/13)
- [動態一對多表單建立 - 教學 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/topic/447)
  - `@item = Item.where(:id => params[:id]).first`是什麼請見[JC的留言](http://railsfun.tw/t/topic/447/6)
  - 在controller上看到的`where`，是因為在model裡用了`has_many`，請參考[一對多關聯](http://openhome.cc/Gossip/Rails/OneToMany.html)
  - controller程式碼請看[RailsDemoHasMany/items_controller.rb](https://github.com/JokerCatz/RailsDemoHasMany/blob/master/app/controllers/items_controller.rb)，搭配[JC的解釋](http://railsfun.tw/t/topic/447/8)會更清楚
  - [each_pair - Hash - RailsFun day1](https://youtu.be/6XUnYRB0Zpo?t=6913)
  - [Hash Class | Grady's Programming Notes](https://gradyli.wordpress.com/2007/11/24/hash/)，搜尋「each_pair」
  - 對於update_attributes可以看[update_attribute - rails API](http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-update_attribute)，就只是更新複數attributes
- [Strong Parameter 解釋 & 一對一關聯製作 - Rails - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/strong-parameter/442)




> 筆記1：[Dynamic Input Fields in Rails | Dan Barbarito - Student, Web Developer, Musician, Programmer](http://www.barbarito.me/blog/dynamic-input-fields-in-rails/)

[ActionView::Helpers::FormHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html)這篇讓我們學會，不用rails來自幹表單。

在這篇的`form_for`中，你會看到它寫`format: :json`，在[ActionView::Helpers::FormHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html)的「Resource-oriented style」這節，我們會知道`format: :json`這寫法是為了要傳`json`，為何要設定成傳json呢

因為表單送出時，他的順序是 **view -> controller -> model**，controller會收到json，然後再把json拆解後送到model裡去。所以，我們可以直接用`form_for`或`form_tag`混著HTML、jQuery來寫，就能生出易懂好修改的表單，而不用花費時間成本，學習只能用rails解的官方helper

#### ref
- [form_tag / form_for 互換使用 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/form-tag-form-for/747/4)

> 筆記1 end

> 筆記2：`params[]`到底抓出什麼

我們在controller常看到的`params[:ic]`其實是從`<input>`的`name`這個attribute去取得的

需要知道`text_field_tag`到底生出了什麼
- [text_tield_tag - RailsFun 新手教學 Day 6](https://youtu.be/r1pq5wvRS7c?list=PLJ6M-k9dQEQ3VsyOZQwjZ5GdjaLJH3eB_&t=3787)
- [text_field_tag - rails API](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-text_field_tag)
- [params 的包裝與使用 - Rails Fun](http://railsfun.tw/t/params/55)

**範例.1**：[JokerCatz/RailsDemoHasMany](https://github.com/JokerCatz/RailsDemoHasMany)

先看html：[RailsDemoHasMany/multi.html.erb](https://github.com/JokerCatz/RailsDemoHasMany/blob/master/app/views/items/multi.html.erb)
```
<%= form_tag multi_save_item_path do %>
  <% age_list = (18..30).to_a %>
  <ol>
    <li class="template">name<input data-name="ic[name][]"> , age<select data-name="ic[age][]"><%= options_for_select(age_list) %></select><span class="add">add</span><span class="del">del</span></li>
    <% @item_childs.each do |old_ic| %>
      <li class="old_record">name<%= text_field_tag "ic_old[#{old_ic.id}][name]" , old_ic.name %> , age<%= select_tag "ic_old[#{old_ic.id}][age]" , options_for_select(age_list , old_ic.age) %></select><span class="add">add</span><span class="del">del</span> (<%= old_ic.id %>)</li>
    <% end %>
  </ol>
  <button type="submit">Submit</button>
<% end %>
```


再看controller：[RailsDemoHasMany/items_controller.rb](https://github.com/JokerCatz/RailsDemoHasMany/blob/master/app/controllers/items_controller.rb)
```
def multi
    @item_childs = ItemChild.where(:item_id => @item.id)
  end

  def multi_save
    #取出所有關連id
    ids = (params[:ic_old] || {}).keys.map{|i|i.to_i}

    #語意：排除送出的id之外的所有隸屬item的都刪除
    ItemChild.where("item_id = #{@item.id} AND id NOT IN (#{ids.join(',')})").delete_all

    #更新舊的資料
    if params[:ic_old]
      params[:ic_old].each_pair do |id , data|
        ic = ItemChild.where(:item_id => @item.id , :id => id).first
        if ic
          #這邊要過 permit 或是一個一個指定都行
          ic.update_attributes(:name => data[:name] , :age => data[:age])
        end
      end
    end

    #額外新增的都再塞入
    if params[:ic]
      params[:ic][:name].each_index do |index|
        ItemChild.create(:item_id => @item.id , :name => params[:ic][:name][index] , :age => params[:ic][:age][index])
      end
    end
    redirect_to :back
  end

```

會需要用`multi`與`multi_save`這兩個action，是因為在route定義的
```
resources :items , :except => [:show] do
  member do
    get :multi
    post :multi_save
  end
end
root "items#index"
```

**範例.2**：[Dynamic Input Fields in Rails | Dan Barbarito](http://www.barbarito.me/blog/dynamic-input-fields-in-rails/)

先看html：

動態增加的子表單：`_poll_choice.html.erb`

```
<div class="choiceForm">
  <%= label_tag "Choice" %>
  <br>
  <%= text_field_tag "choices[]" %> <a href="#" onclick="removeChoice($(this))" class="remove-choice" > X </a>
  <br>
</div>
```

預設加四個子表單
```
<div id="poll_choices">
   <%= render 'poll_choice' %>
   <%= render 'poll_choice' %>
   <%= render 'poll_choice' %>
   <%= render 'poll_choice' %>
</div>
```

表單頁面
```
<%= form_for(@poll, remote: true, format: :json, html: {class: :poll_form} ) do |f| %>

  <div class="fields">
    <%= f.label :title %><br>
    <%= f.text_field :title %><br>
    <div id="poll_choices">
        <%= render 'poll_choice' %>
        <%= render 'poll_choice' %>
        <%= render 'poll_choice' %>
        <%= render 'poll_choice' %>
    </div>
    <a href="javascript:;" id="addNewChoice">Add New Choice</a>
  </div>

  <div class="actions">
    <%= hidden_field_tag :user_id, current_user.id %>
    <%= f.submit %>
  </div>

<% end %>


<div style="display: none;" id="new_choice_form">
    <%= render partial: "poll_choice", locals: {poll: false} %>
</div>
```

動態增加的coffescript
```
<!-- 新增 -->
$("#addNewChoice").on "click", ->
    $("#poll_choices").append($("#new_choice_form").html())

<!-- 刪除 -->
@removeChoice = (element) ->
  element.parent().remove()
```

最後再看controller
```
def create
    @poll = Poll.new(poll_params)
    choices_param = params[:choices]
    @choices = []
    choices_param.each.with_index(1) do |choice, index|
      choice = Choice.create(:text => choice, :location => index)
      @choices.push(choice)
    end
    @poll.choices = @choices
    @poll.user = User.find(params[:user_id])
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render json: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors.full_messages, status: :unprocessable_entity }
      end
    end
end
```

controller所收到的json長成
```
{"utf8"=>"✓",
  "poll"=>{"title"=>"Should you comment below?"},
  "choices"=>["Yes",
              "Most definitely",
              "No reason not to",
              "Only an idiot would say no",
              "Of Course"],
  "user_id"=>"1",
  "commit"=>"Create Poll"
}
```
controller會取出`choices`，然後把它存入資料庫。

> 筆記2 end

## Nested Form

學習順序
1. [Understanding Nested Forms in Rails 4.2 - YouTube](https://www.youtube.com/watch?v=WVR-oDQRrFs)
2. [Ruby on Rails 實戰聖經 | RESTful 應用實作](https://ihower.tw/rails/restful-practices.html)
  - 搜尋「accepts_nested_attributes_for」
2. [Nested Forms for Ruby on Rails 4.2 - YouTube](https://www.youtube.com/watch?v=a61yKxi3pL0)
  - [Rails new, build, create, save方法區別| Ruby迷](http://rubyer.me/blog/262/)
  - [build - ActiveRecord::Associations::CollectionProxy](http://api.rubyonrails.org/classes/ActiveRecord/Associations/CollectionProxy.html#method-i-build)
  - [一對多關聯](http://openhome.cc/Gossip/Rails/OneToMany.html)
3. [如何讓 strong_parameter 接受 nested_attributes « Haneric's Blog](http://haneric-blog.logdown.com/posts/377327-how-to-make-strong-parameter-accept-nested-attributes)
4. [Nested form | Rails 102](https://rocodev.gitbooks.io/rails-102/content/chapter1-mvc/v/nested-form.html)
5. [Rails Nested Forms: Deep Dive - YouTube](https://www.youtube.com/watch?v=zZn0xWry6TE)
6. [Rails Nested Model forms — Ruby on Rails 指南](http://rails.ruby.tw/nested_model_forms.html)
7. [Active Record Nested Attributes | rails API](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)
8. [Rails nested form 的問題 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/rails-nested-form/685)
9. [RailsFun 新手教學 Day 6 實作動態增加的表單](https://youtu.be/r1pq5wvRS7c?list=PLJ6M-k9dQEQ3VsyOZQwjZ5GdjaLJH3eB_&t=3254)
10. [Ruby on Rails - Railscasts PRO #403 Dynamic Forms (pro) - YouTube](https://www.youtube.com/watch?v=t_FNKR7jahM)

#### 影片
- [Understanding Nested Forms in Rails 4.2 - YouTube](https://www.youtube.com/watch?v=WVR-oDQRrFs)
- [Nested Forms for Ruby on Rails 4.2 - YouTube](https://www.youtube.com/watch?v=a61yKxi3pL0)
- [Rails Nested Forms: Deep Dive - YouTube](https://www.youtube.com/watch?v=zZn0xWry6TE)
  - 講得非常深，而且有pry更靈活的用法
  - 不打算實作，第一版用nested form helper做即可，全部做出來有時間再用form_tag與jQuery做dynamic form
- [RailsFun 新手教學 Day 6 實作動態增加的表單](https://youtu.be/r1pq5wvRS7c?list=PLJ6M-k9dQEQ3VsyOZQwjZ5GdjaLJH3eB_&t=3254)
  - 以下用form_tag做dynamic form
  - [Ruby on Rails - Railscasts PRO #403 Dynamic Forms (pro) - YouTube](https://www.youtube.com/watch?v=t_FNKR7jahM)
    - 雖然是用coffescript，不過那code看起來就jQuery啊XD


#### 文章
- [如何讓 strong_parameter 接受 nested_attributes « Haneric's Blog](http://haneric-blog.logdown.com/posts/377327-how-to-make-strong-parameter-accept-nested-attributes)，講的東西有缺，不過還好有影片教學
- [Nested form | Rails 102](https://rocodev.gitbooks.io/rails-102/content/chapter1-mvc/v/nested-form.html)，講得很爛，但還是能稍微看一下
- [Rails Nested Model forms — Ruby on Rails 指南](http://rails.ruby.tw/nested_model_forms.html)
- [Ruby on Rails 實戰聖經 | RESTful 應用實作](https://ihower.tw/rails/restful-practices.html)
  - 搜尋「accepts_nested_attributes_for」
- [Active Record Nested Attributes | rails API](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)
- [Rails nested form 的問題 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/rails-nested-form/685)
- ~~[Ruby on Rails 如何實作可動態新增欄位的表單(dynamic nested form) – 先求有再求好](https://krammer0.wordpress.com/2016/05/04/ror-%E5%8B%95%E6%85%8B%E6%96%B0%E5%A2%9E%E6%AC%84%E4%BD%8D%E7%9A%84%E8%A1%A8%E5%96%AE/)~~，**這個code有夠亂，閱讀不易**
- ~~[simple_form nested attribute 巢狀表格 Rails 要注意的點 - 丹哥的技術培養皿](http://tech.guojheng-lin.com/posts/2014/07/01/simple-form-nested-nested-table-attribute-rails-to-note-the-points/)~~，**完全沒打算用simple form**
- [Strong Parameter 解釋 & 一對一關聯製作 - Rails - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/strong-parameter/442)


accepts_nested_attributes_for的官方極清晰API
- [ActiveRecord::NestedAttributes::ClassMethods](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)
- [fields_for - ActionView::Helpers::FormHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for)
- [ActionController::StrongParameters](http://api.rubyonrails.org/classes/ActionController/StrongParameters.html)
  - [Strong Parameter 解釋 & 一對一關聯製作 - Rails - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/strong-parameter/442)

> 筆記3：`accepts_nested_attributes_for`到底在幹麻

直接看官方API，這篇[ActiveRecord::NestedAttributes::ClassMethods](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)，就會非常容易理解。

過去我們知道了，在前台頁面填完表單後，按下submit，在controller收到的是一串json。這串json的格式又會依據我們前台表單頁面的input欄位的`name`屬性，來決定名字。

現在我們看[ActiveRecord::NestedAttributes::ClassMethods](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)的 **One-to-many** 這節。

一開始在`member.rb`下定義

```
class Member < ActiveRecord::Base
  has_many :posts
  accepts_nested_attributes_for :posts
end
```

表單送出後，所收到的json長成
```
params = { member: {
  name: 'joe', posts_attributes: [
    { title: 'Kari, the awesome Ruby documentation browser!' },
    { title: 'The egalitarian assumption of the modern citizen' },
    { title: '', _destroy: '1' } # this will be ignored
  ]
}}
```

換句話說，`accepts_nested_attributes_for`幫我們在nested_form定義的input欄位，他的`name`命名為`posts_attributes`。

而controller收到`posts_attributes`後，會把它裡頭的東西送到資料庫裡去。

> 筆記3 end

## random note

develop
- pry
- pry-rails
- pry-nav

scaffold
- Author name:string
- Book title:string author:references

**accepts_nested_attributes_for**

fields_for

accepts_nested_attributes_for :model_name

reject_if: proc {|attributes| attributes['columen_name'].blank?}


```
def create
  @author.books.bulid
end
```
