# 權限控管

面試五倍紅寶石實習生時，龍哥幫我抓到蟲

龍哥建議使用cancancan套件來做 **權限控管**
- [使用CanCanCan进行权限管理（一） « 王梦琪的博客](http://wangmengqi.logdown.com/posts/1209114-cancancan-rights-management-a)
- [cancancan wiki](https://github.com/CanCanCommunity/cancancan/wiki)

當時的情境：

>公告欄的文章是用傳統的ID顯示
>
>一篇指定編輯權限的文章，複製edit頁面的網址，我換了不同帳號，並進到「edit頁面網址」發現居然進得去....


當初高見龍建議的寫法，`app/controllers/dashboard/post_controller.rb`

```
def find_post
  # @post = Post.find(params[:id])
  @post = current_user.posts.find(params[:id])  #高見龍建議寫法，但是不能全部都work
end
```

事後我有思考高見龍寫法不能work的原因。因為公告欄的文章，除了作者本人(**author**)發文外，還有指派文章編輯者(**editor**)，可是文章並不屬於文章編輯者，而是屬於作者本人。所以當登入身份是文章編輯者(**editor**)時，`current_user`底下並不會有原作者(**author**)的文章，於是就會噴錯。

五倍紅寶石實習生面試時，也向高見龍請教了「測試」，心法

>先想好我要測什麼東西
>
>通常能寫測試的都是很熟練的，對於需要的功能很清楚明確

# 這問題想到的解法

我現在尚未研究cancancan要如何用。當時是因為文章網址顯示ID，所以才會讓人家有動機去駭。所以我當下想到的解法是用以前查到的，不要讓文章顯示ID即可
- [Rails讓網址不再只顯示ID « Wayne](http://waynechu.logdown.com/posts/205700-rails-web-site-no-longer-displays-only-id)

add to `Gemfile` and then `bundle install`

```
gem 'friendly_id', '~> 5.2.0' # 讓文章網址不要顯示ID
gem 'babosa', '~> 1.0.2'      # 讓文章網址能顯示中文
```

and then

```
rails g friendly_id
rails g migration add_slug_to_posts slug:string:uniq
rails g migration add_slug_to_notes slug:string:uniq
rake db:migrate
```

fix `app/models/post.rb`

```
class Post < ActiveRecord::Base
  ...

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def slug_candidates
    [
      :title,
      [:title, :created_at]
    ]
  end

  ...
end
```

and then fix `app/controllers/post_controller.rb`

```
def show
  @post = Post.friendly.find(params[:id])
end
```

and then fix `app/controllers/dashboard/post_controller.rb`

```
def find_post
  @post = Post.friendly.find(params[:id])
  # @post = current_user.posts.find(params[:id])  #高見龍建議寫法，但是不能全部都work
end
```

至於`notes.rb`也是依照相同的步驟去改

# 抓蟲趣

一開始舊文章始終沒看到friendly_id與babosa的效果，後來參考這篇才注意到
- [使用friendly_id優化URL，babosa讓URL呈現中文字](http://www.lkwu.site/rails-使用friendly_id優化urlbabosa讓url呈現中文字)

在使用`friendly_id`之前所發的文章，`post` schema的`slug`欄位裡頭的值都是`null`，所以開rubymine手動去把它填文章的`title`寫進去，然後就能work了。
