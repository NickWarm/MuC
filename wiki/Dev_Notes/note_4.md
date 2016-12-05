# 編輯個人頁面

情境
- 可以用markdown語法編輯自我介紹(`profile:text`)、發表過的論文(`paper:text`)
- 上傳一張個人生活照片
- ~~點選自己現在幾年級~~，自動算出你現在幾年級
  - ~~總管理員要有權限去修~~，改成自動加總，從 **入學學年** `joined_CYCU_year:integer` 去推算你現在幾年級。現在寫筆記時是2016/12/5，聽說是105學年
  - 估狗發現人家演算法都幫你寫好了XD，只要寫個function就好了，請見：[公式： 如何把西元年轉為當前學年度 @ 毛哥資訊日誌 :: 痞客邦 PIXNET ::](http://awei791129.pixnet.net/blog/post/40554993-%5B公式%5D-如何把西元年轉為當前學年度)
- 身份狀態：還在讀書，還是已經離開學校
  - [Toggle - Checkbox | Semantic UI](http://semantic-ui.com/modules/checkbox.html#toggle)

so

User model
- 姓名:string、入學學年:integer、論文題目:~~string~~(改成`paper:text`)、自我介紹:text、現在幾年級、身份狀態:string、個人照片
- `name:string joined_CYCU_year:integer paper:text profile:text academic_degree:integer has_graduated:boolean`

實作順序
- 上傳個人照片
- markdown編輯
- Toggle
- 自動算現在幾年級

## 插曲：gitignore失效的解法

有些檔案想要隱藏不想被git追蹤，但是以前已經送出commit追蹤過了，再去gitignore不管怎麼設定都失效。後來參考這篇照著做就解掉了
- [Git 教學(1) : Git 的基本使用 - 好麻煩部落格](http://gogojimmy.net/2012/01/17/how-to-use-git-1-git-basic/)，搜尋「被加入 gitignore 的檔案一樣出現在 status 中」


# 上傳個人照片

先實作上傳個人照片的功能，因為以前做過XD

由於打算用paperclip實作實驗室個人沙龍照的上傳，參考
- [JCcart wiki - Step.3 註冊系統與產品圖片 - 產品圖片：paperclip](https://github.com/NickWarm/jccart/wiki/Step.3-註冊系統與產品圖片#產品圖片paperclip)
- [JCcart wiki - Step.11 加上圖片](https://github.com/NickWarm/jccart/wiki/Step.11-加上圖片)
