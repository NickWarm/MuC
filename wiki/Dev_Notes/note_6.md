# 學習資源

>年代有點久遠的舊筆記

要在 **學習資源** 這頁面發文

學習資源的表單設計，除了原本[MuCat_v1.md](../MuCat_v1/MuCat_v1.md)的
- ~~`author:string title:string content:text other_can_edit:boolean`~~
- 改成：`author:string title:string content:text is_editable:boolean`

後來參考
- [mackenziechild GitHub - blog_course_demo/db/migrate/20150509171512_create_projects.rb](https://github.com/mackenziechild/blog_course_demo/blob/master/db/migrate/20150509171512_create_projects.rb)
- [mackenziechild GitHub - blog_course_demo/app/views/projects/show.html.erb](https://github.com/mackenziechild/blog_course_demo/blob/master/app/views/projects/show.html.erb)

應該加個`link:string`才對，這樣才能連到外部文章，這樣也比較符合我的需求


>新筆記

學習資源用`note`表示
- 後台：`new`、`edit`
- 前台：`index`、`show`
- markdown語法
- 欄位：`author:string title:string content:text is_editable:boolean link_text:string link_site:string`
- `is_editable:boolean`是開放權限，看你是否要讓其他所有實驗室成員都能夠編輯
- 最後的`link_text:string link_site:string`是打算發布學習方法論那類文章，你只打算開個引言，然後導引到其他頁面時才用的。
- `link_text:string`：超連結的文字
- `link_site:string`：外部連結的網址


create `note schema`

`rails g migration CreateNoteTable`
