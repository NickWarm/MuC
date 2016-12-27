# 實作更新圖片

## 請承轉合

最初是想要弄上傳圖片後AJAX更新個人資料的圖片，但是實作上實在不容易，相關筆記請見
- [AJAX_upload_image_ref.md](../../features/AJAX_update_image/AJAX_upload_image_ref.md)
- [implement_AJAX_upload_image.md](../../features/AJAX_update_image/implement_AJAX_upload_image.md)

# 構想

觀察GitHub的大頭貼上傳照片的流程

>編輯個人頁面 -> 點選 **Upload new picture** -> 跳出modal裁剪圖片  -> 重新刷新頁面

有趣的事，在user的edit view 有著兩個完全獨立的表單，送出一邊的表單就會刷新頁面。
- 左邊：個人資料
- 右邊：大頭貼

>換句話說：**他們的action各自獨立**


後來發現，真的有讓表單各自獨立action的寫法
- 請看這則comment：[ruby - rails multiple forms in one view - Stack Overflow](http://stackoverflow.com/a/16850052)
- 後來我在[rails API - form_for](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_for)的「Customized form builders」這節也有找到指定action的寫法


發現這樣的作法後，決定放棄AJAX上傳圖片的寫法。

>流程1st：編輯個人頁面 -> button上傳圖片 -> 跳出semantic-ui的[modal](http://semantic-ui.com/modules/modal.html#/examples)顯示圖片  -> 重新刷新頁面

~~不打算實作「手動裁切圖片」的功能~~

後來發現可以用[Jcrop](https://github.com/tapmodo/Jcrop/wiki/Manual)實作手動裁切圖片的功能
- Rails3：[Ruby on Rails - Railscasts PRO #182 Cropping Images (revised) - YouTube](https://www.youtube.com/watch?v=ltoPZEzmtJA)
  - 程式碼：[#182 Cropping Images - RailsCasts](http://railscasts.com/episodes/182-cropping-images)
- [rails3 - 用 Paperclip 和 jcrop 做图片上传和裁剪 · Ruby China](https://ruby-china.org/topics/13393)
- ~~一個包jCrop的gem：[rsantamaria/papercrop GitHub](https://github.com/rsantamaria/papercrop)~~，**目前看到的範例都沒用gem**
- Rails4範例：[awijeet/Image_cropping_in_rails4 GitHub](https://github.com/awijeet/Image_cropping_in_rails4)
- ~~[Rails 上傳 Upload - Jex’s Note](http://blog.jex.tw/blog/2015/07/13/rails-upload/)~~，**不是我要的手動裁切**
- 可惜看不懂日文：[rails 4.2, paperclip, Jcropを使ってユーザが写真切り取りし保存する機能をつける - Qiita](http://qiita.com/gymnstcs/items/69d319a6415a53a6576e)
- 可惜看不懂日文2：[Paperclip + Jcrop + Railsでサムネイルを正方形に切り抜き - 木木木](http://source.hatenadiary.jp/entry/2014/03/23/144122)


既然如此，就可以實作「手動裁切圖片」這功能啦

>流程2nd：編輯個人頁面 -> button上傳圖片 -> modal顯示與裁切圖片  -> 重新刷新頁面

實作材料
- [paperclip](https://github.com/thoughtbot/paperclip)
- [Semantic UI - Modal](http://semantic-ui.com/modules/modal.html#/examples)
- [Jcrop](https://github.com/tapmodo/Jcrop/wiki/Manual)


# 裁剪圖片

我已經實作paperclip + Jcrop放在GitHub上
- [rails_paperclip_jcrop_WG](https://github.com/NickWarm/rails_paperclip_jcrop_WG)
