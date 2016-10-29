# 下拉式選單：[一對多-2](https://www.youtube.com/watch?v=-fwl_aFNewM&feature=youtu.be)


### step.1
add category table and create relation
```
rails g model category
```
讓categories table加入`name`這欄位
在`XXXXX_create_categories.rb`的`create_table`加入`t.string :name`


建立關聯
```
add 「has_many :events」 to category.rb
add 「belongs_to :category」 to event.rb
```

加入方便搜尋的索引

在`XXXXX_create_categories.rb`加入
```
  add_column :events, :category_id, :integer
  add_index :events, :category_id
```

然後`rake db:migrate`

### step.2
進到consloe輸入一些資料
```
rails c

:001 > Category
:002 > Category.count
:003 > Category.create(name: "Course")
:004 > Category.create(name: "Meeting")
:005 > Category.create(name: "Conference")
:006 > exit
```
### step.3
開始準備做介面

#### step.3-1
一對多-2的影片跟前面教學進度有落差，少了一大段

首先我必須要開一個新的migrate來讓event table加入下列columns
```
t.string "state"
t.date "start_on"
t.datetime "schedule_at"
```
透過[新建獨立的遷移](http://rails.ruby.tw/active_record_migrations.html#%E6%96%B0%E5%BB%BA%E7%8D%A8%E7%AB%8B%E7%9A%84%E9%81%B7%E7%A7%BB)的寫法，我們可以改寫成

```
rails g migration AddDetailsToEvents state:string start_on:date schedule_at:datetime
```

下完這道指令後，他幫我們生成了`20160828080511_add_details_to_events.rb`

我們再`rake db:migrate`

就能生成跟 **一對多-2** 的影片相同的`schema.rb`

#### step.3-2
**目標：** 與影片相同的`index.html.erb`

**要有跟ihower在一對多-2相同的_form.html.erb**

因為我不希望影響到前面寫的code，所以我在events下新增了`_formlist.html.erb`，然後寫 **一對多-2** 裡`_form.html.erb`相同的code

**views/events/_formlist.html.erb**
```
<% if @event.errors.any? %>
    <ul>
      <% @event.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
    </ul>
<% end %>

<div class="form-group">
  <%= f.label :name, "Name" %>
  <%= f.text_field :name, required: true, class: "form-control" %>
</div>

<div class="form-group">
  <%= f.label :category_id, "Category" %>
  <%= f.select :category_id, [["Foo", 1], ["Bar", 2]], class: "form-control" %>
</div>

<div class="form-group">
  <%= f.label :start_on, "開始日期" %>
  <%= f.date_select :start_on, required: true, class: "form-control" %>
</div>

<div class="form-group">
  <%= f.label :schedule_at, "預約時間" %>
  <%= f.datetime_select :schedule_at, required: true, class: "form-control"  %>
</div>

<div class="form-group">
  <%= f.label :description, "Description" %>
  <%= f.text_area :description, class: "form-control"  %>
</div>
```

接著我去`events/index.html.erb`加入
```
//預約表單
<%= form_for @event do |f| %>

  <%= render :partial => "formlist", :locals => {:f => f} %>

  <%= f.submit "Save", class: "btn btn-primary" %>
  <%= link_to "Cancel", events_path, class: "btn btn-primary" %>
<% end %>
<br><br>
```

完成這一步後重整網頁會報錯，說第一個參數不能是空的，這是因為我們在index action裡沒有`@event`，所以`index.html`的form_for讀不到


於是，我們去`events_controller`的`index action`加入
```
@event = Event.new
```
就能看到跟ihower影片相同的index.html.erb了

#### step.3-3 下拉選單

新增下拉選單
```
<div class="form-group">
  <%= f.label :category_id, "Category" %>
  <%= f.select :category_id, [["Foo", 1], ["Bar", 2]], class: "form-control" %>
</div>
```
可以在Chrome裡用開發者工具查看。點到Foo與Bar的下拉選單，`右鍵 > 檢查`，來查看生出來的html

但是我們希望，印出來的Category是我們填入Category model的資料，所以我們再度進入console
```
:001 > Category
:002 > Category.all
:003 > Category.all.map{|x| [x.name, x.id]}
```
你可以在console中看到印出來的結果：
```
[["Course", 1], ["Meeting", 2], ["Conference", 3]]
```
這就是我們想要的，於是我們把這段code
```
Category.all.map{|x| [x.name, x.id]}
```
貼到我們的下拉選單，所以下拉選單那段code變為
```
<div class="form-group">
  <%= f.label :category_id, "Category" %>
  <%= f.select :category_id, Category.all.map{|x| [x.name, x.id]}, class: "form-control" %>
</div>
```

#### step.3-4 讓category能夠輸入與顯示資料

event params 加入`category_id`

add to `events_cotroller.rb`
```
def event_params
  params.require(:event).permit(:name, :description, :category_id)
end
```
然後在`index.html.erb`再輸入資料，就能看到輸入成功了，不過我們現在要更新`show.html.erb`

### step.4 編輯

**很可惜，這次又跟影片不一樣了，由於能力不夠，現在先求進入edit頁面時跟原本new的畫面類似**

把`edit.html.erb`改成
```
<h1>edit action</h1>
<%= form_for @event, :url => event_path(@event), method: :patch do |f| %>  

  <%= render :partial => "formlist", :locals => {:f => f} %>

  <%= f.submit "Update", class: "btn btn-primary" %>
<% end %>
```

### step.5 沒有category的錯誤處理
由於我們最早生data時，沒有寫category，所以 \@event.category 可能是 nil，這會導致 nil.name 發生錯誤

**解法一**

show.html.erb改寫成這樣
```
<p>Category: <%= @event.category.try(:name) %></p>
```

**解法二**

在event.rb加入這行
```
delegate :name, :to => :category, :prefix => true, :allow_nil => true
```
接著到show.html.erb，改寫成
```
<p>Category: <%= @event.category_name %></p>
```

以上兩種解法，我個人較偏好解法一

### step.6 下拉選單的第二種做法：collection_select
```
<%= f.collection_select :category_id, Category.all, :id, :name, class: "form-control" %>
```
若允許category是空白的可以寫成
```
<%= f.collection_select :category_id, Category.all, :id, :name, class: "form-control",
                        include_blank: "Please select" %>
```

#### 小插曲

如果嫌code太長，要換行時結尾一定要加「,」，如果把逗號加在下一行會噴錯

會噴錯
```
<%= f.collection_select :category_id, Category.all, :id, :name, class: "form-control"
                        , include_blank: "Please select" %>
```

正確的
```
<%= f.collection_select :category_id, Category.all, :id, :name, class: "form-control",
                        include_blank: "Please select" %>
```
若不用`include_blank`，另一種是用`prompt`

```
<%= f.collection_select :category_id, Category.all, :id, :name, class: "form-control",
                        prompt: "Please select" %>
```

`prompt`與`include_blank`的差異在於，使用`prompt`的話，若你最初送出表單時有選擇category，那麼編輯時就不會有空白的選項給你選

個人建議，知道就好，**只會用rails的helper，會被rails綁死而不知變通**。

### step.7 下拉選單的第三種做法：radio_button

基礎的寫法
```
<%= f.radio_button :category_id, 1 %> Foo
<%= f.radio_button :category_id, 1 %> Bar
```

跑迴圈撈出category model的資料
```
<% Category.all.each do |c| %>
  <%= f.radio_button :category_id, c.id %> <%= c.name %>
<% end %>
```
