# 簡介
實驗室網站，由101學年入學已經畢業的研究生陳威齊製作，使用Ruby on rails開發
> ruby 2.2.2p95
> Rails 4.2.5.2

## 結構
```
├── features
├── icons
├── meetup
├── versions
└── wiki
```


1. 實驗室網站準備開發的功能，開發之前會練習於`MuWeb/features`
2. 實驗室網站候選的icons，請見`MuWeb/icons`
3. 實驗室網站的討論結果，請見`MuWeb/meetup`
4. 實驗室網站不同版本，請見`MuWeb/versions`
5. 實驗室網站的UserStorys與研究「哪些功能要寫、想寫」，請見`MuWeb/wiki`


# 待討論

1. 是否open source實驗室成員的論文、投影片、專題海報？
2. 實驗室icon要用哪一個好


# 思考中

## UserStorys_v6

#### 實驗室成員
- 已畢業與未畢業
  - 點進去實驗室成員，**只會看到在學成員**，橫排階層依序為
    - 博士生
    - 研究生
    - 專題生
  - 已經畢業的學生，給一個 **View More** 連結
    - 所以 **Member model** 要再`add_column`一個欄位 **畢業:boolean**
    - `graduation:boolean`

> rails model的boolean可以參考ihower的[Ruby on Rails 實戰聖經 | Active Record - 資料庫遷移(Migration)](https://ihower.tw/rails/migrations.html)這篇文章
>
>對於model裡用boolean，可以參考如意的[FUSAKIGG 專案的schema.rb](https://github.com/lustan3216/FUSAKIGG/blob/master/db/schema.rb)，按`cmd + f`搜尋boolean
>
>最先可以看到order model有一個 **paid** 欄位用boolean，然後去[orders_controller.rb](https://github.com/lustan3216/FUSAKIGG/blob/master/app/controllers/orders_controller.rb)搜尋 **paid** ，可以看到用`if order.paid?`來做boolean判斷
