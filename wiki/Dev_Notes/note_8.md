# 權限控管

面試五倍紅寶石時，龍哥幫我抓到蟲

龍哥建議使用cancancan套件


測試：先想好我要測什麼東西


# 這問題想到的解法

[Rails讓網址不再只顯示ID « Wayne](http://waynechu.logdown.com/posts/205700-rails-web-site-no-longer-displays-only-id)




# 抓蟲趣

一開始舊文章始終沒看到friendly_id與babosa的效果，後來參考這篇才注意到
- [使用friendly_id優化URL，babosa讓URL呈現中文字](http://www.lkwu.site/rails-使用friendly_id優化urlbabosa讓url呈現中文字)

在使用`friendly_id`之前所發的文章，`post` schema的`slug`欄位裡頭的值都是`null`，所以開rubymine手動去把它填文章的`title`寫進去
