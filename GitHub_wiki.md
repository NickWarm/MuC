# 重點features

做這專案時一路採了各種雷，想要看詳細的開發過程請見wiki資料夾底下的[Dev_Notes](https://github.com/NickWarm/MuCat_v1/tree/dev/wiki/Dev_Notes)

## 開放權限給特定人編輯「實驗室公告」

功能
- 多重下拉選單
- 透過`scope`包好的method來執行SQL語法篩選出「在校學生」
- 指定可以編輯文章的人
  - 在後台的`post_controllers.rb`撰寫純Ruby來存入user與post的中介表，之後透過中介表去確認這篇文章能夠編輯的人

實作筆記
- [note_2_0.md](https://github.com/NickWarm/MuCat_v1/blob/dev/wiki/Dev_Notes/note_2_0.md)


抓蟲筆記
- [note_2_1.md - 爭扎時找到的資料](https://github.com/NickWarm/MuCat_v1/blob/dev/wiki/Dev_Notes/note_2_1.md#爭扎時找到的資料)
- [note_2_1.md - 解掉無法存入中介表的bug](https://github.com/NickWarm/MuCat_v1/blob/dev/wiki/Dev_Notes/note_2_1.md#解掉無法存入中介表的bug)
- [note_2_2.md - 抓蟲趣：被授權編輯的人按下update button後噴錯](https://github.com/NickWarm/MuCat_v1/blob/dev/wiki/Dev_Notes/note_2_2.md)

最初的構想
- [controller_design.md](wiki/features/professor_assigned/controller_design.md)
- [specific_one.md](wiki/features/professor_assigned/specific_one.md)

## 開放給所有人編輯「學習資源」

使用Semantic_UI的[Toggle](http://semantic-ui.com/modules/checkbox.html#toggle)

筆記
- 實作：[not6_6.md](https://github.com/NickWarm/MuCat_v1/blob/dev/wiki/Dev_Notes/note_6.md)
- 可行的想法：[onlyone_or_everyone.md](https://github.com/NickWarm/MuCat_v1/blob/dev/wiki/features/other_can_edit/onlyone_or_everyone.md)
- 最初的錯誤想法：[wrong_way.md](https://github.com/NickWarm/MuCat_v1/blob/dev/wiki/features/other_can_edit/wrong_way.md)

抓蟲筆記
- [not6_6 - 抓蟲趣1](https://github.com/NickWarm/MuCat_v1/blob/master/wiki/Dev_Notes/note_6.md#抓蟲趣)
- [note_6 - 抓蟲趣2](https://github.com/NickWarm/MuCat_v1/blob/master/wiki/Dev_Notes/note_6.md#抓蟲趣2)

## `user.rb`用`scope`把會常用到的`SQL`包成可串接的methods，來做資料篩選

筆記
- [note_5_3.md - index頁面的scope](https://github.com/NickWarm/MuCat_v1/blob/master/wiki/Dev_Notes/note_5_3.md#index頁面的scope)

抓蟲筆記
- [note_5_3.md - 抓蟲趣](https://github.com/NickWarm/MuCat_v1/blob/master/wiki/Dev_Notes/note_5_3.md#抓蟲趣)


## `text_area`用Markdown render

筆記
- [note_5_0.md - markdown](https://github.com/NickWarm/MuCat_v1/blob/master/wiki/Dev_Notes/note_5_0.md#markdown)

抓蟲筆記
- [note_5_1.md - debug markdown](https://github.com/NickWarm/MuCat_v1/blob/master/wiki/Dev_Notes/note_5_1.md#debug-markdown)
