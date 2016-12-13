# 更新圖片後，AJAX顯示新圖片

做之前，我研究了一下臉書的大頭貼上傳方式

>點選大頭貼 -> 開啟一個modal -> 選擇你的照片 -> 拖曳照片位置，並詢問是否要裁剪 -> 按下儲存

這篇是搜尋資料

# 最初的想法

由於以前是用paperclip實作的，所以一開始是考慮用paperclip做，後來研究發現~~要用paperclip實踐這功能的AJAX難度比想像中高~~
- [Edit and New Views - paperclip GitHub](https://github.com/thoughtbot/paperclip#edit-and-new-views)
- [AJAX Photo Uploading the Easy Way with Rails 4 and Paperclip - JustPayme — Muno Creative](http://www.munocreative.com/nerd-notes/justpayme)
  - [rails API - form_tag](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-form_tag)
  - [form_tag 是啥？跟 form_for 有什麼不一樣？ | Motion Express | Ruby, Rails, Crystal & developers' techniques](http://motion-express.com/blog/rails-form-tag-form-for)
  - [Using form_tag in Ruby on Rails » Saalon Muyo](http://www.saalonmuyo.com/2010/01/27/using-form_tag-in-ruby-on-rails/)
  - [Ruby on Rails 實戰聖經 | Action View - Helpers 方法](https://ihower.tw/rails/actionview-helpers.html)，搜尋「forform_tag」
- [Ruby on Rails : Rails 3.2 Ajax Paperclip Image uploading](http://jyothu-mannarkkad.blogspot.tw/2013/01/rails-32-ajax-paperclip-image-uploading.html)
  - 必須要在`form_for`裡寫沒見過的controller寫法，外加下面這個沒用過的jQuery Plugin
  - [jQuery Form Plugin - form GitHub](https://github.com/malsup/form#jquery-form-plugin)
  - [5 檔案上傳 - Action View 表單輔助方法 — Ruby on Rails 指南](http://rails.ruby.tw/form_helpers.html#檔案上傳)
  - [rails API - content_for](http://api.rubyonrails.org/classes/ActionView/Helpers/CaptureHelper.html#method-i-content_for)
  - [3.3 使用 content_for 方法 - Rails 算繪與版型 — Ruby on Rails 指南](http://rails.ruby.tw/layouts_and_rendering.html#使用-content-for-方法)
  - [Rails:自定Layout內容 - yield & content_for « Bro's World](http://blog.bro.tw/post/2016/02/08/488892)
  - [Ruby on Rails 實戰聖經 | Action View - 樣板設計](https://ihower.tw/rails/actionview.html)，搜尋「content_for」


# 一種可行的做法：carrierwave

在上面辜狗不順後，發現carrierwave有不少實踐作法
- [CarrierWave GitHub](https://github.com/carrierwaveuploader/carrierwave)
- [AJAX Image Uploads with Rails](https://codediode.io/lessons/4475-ajax-image-uploads-with-rails)
  - [How to: Easy Ajax file uploads with Remotipart - carrierwave wiki](https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Easy-Ajax-file-uploads-with-Remotipart)
- [Simplest AJAX upload with Rails Carrierwave and jQuery | Bill Harding's Tech Blog](http://www.williambharding.com/blog/rails/the-simplest-means-for-ajax-uploading-with-rails-carrierwave-and-jquery/)


# 最後採取的作法

最後找到用paperclip實作我的目標的教學影片
- [Part1：Ruby on Rails Ajax Files Upload with Dropzone - Upload, Drag and drop files - YouTube](https://www.youtube.com/watch?v=ic4MeDEfT08)
- [Part2：Ruby on Rails Ajax Files Upload with Dropzone - List and delete file on server - YouTube](https://www.youtube.com/watch?v=PupYpBKOieA)
  - 除了paperclip外，也用了這個Gem：[dropzonejs-rails](https://github.com/ncuesta/dropzonejs-rails)
    - 看了該Gem的README，發現他是改編自[Dropzone.js](http://www.dropzonejs.com/#events)
      - 必須要搭配這個API看，才看得懂他寫的code在幹麻
- 該作者也把專案放到GitHub上面：[rails_dropzone example - GitHub](https://github.com/edomaru/rails_dropzone)
