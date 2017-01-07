## 更新

已經實踐了，紀錄於[note_5_1.md](../../Dev_Notes/note_5_1.md)


## ~~待實踐~~：客制devise controller

礙於開發時間不夠，這邊沒實作，只有寫下構想

### 情境

註冊時有信箱與密碼，信箱類似`XXXXX@gmail.com`，然後切出只要`XXXXX`，把這`XXXXX`存到User的一個欄位，然後用friendly_id撈這欄位

### 實作的想法

原本有想過用regular expression撈出`@gmail.com`...etc 前面的字串存到一個欄位裡去，用這欄位來friendly_id，~~但礙於現在能力不夠，這構想就先擱著~~

後來跟朋友討論，可以用Ruby的`split`就能撈出了，解法：`('XXXXX@gmail.com').split('@')[0]`

至於Regular expression的寫法可用：`a = ('XXXXX@gmail.com').match(/(.*)@.*/)`

自己實測後這兩種寫法都能work

![](../img/get_mail_account.png)

但是這樣寫就必須要自己定義devise controller
- [Configuring controllers - devise GitHub](https://github.com/plataformatec/devise#configuring-controllers)
  - devise 官方README可以參考中篇中譯：[Devise 快速上手 | DEVLOG of andyyou](http://andyyou.github.io/2015/04/04/devise/)

至於controller要如何寫，我們可以參考devise官方的寫法
- [devise/app/controllers/devise/sessions_controller.rb](https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb)

在我看來這是個可以實踐的功能，但是現在時間不夠，就先擱著吧
