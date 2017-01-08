# styling

由於要用user profile的edit view，所以開始上先前寫過的UI CSS

參考
- [blog_course_demo/app/assets/stylesheets/](https://github.com/mackenziechild/blog_course_demo/tree/master/app/assets/stylesheets)
- [Styling and create welcome page -How to build a blog & portfolio with Rails 4 - YouTube，請看1:06](https://youtu.be/7jF33-S_LAs?list=PL23ZvcdS3XPK9Y4DRU-BiJtiY5L_QhUUq&t=66)
- [FUSAKIGG/app/assets/stylesheets/application.scss](https://github.com/lustan3216/FUSAKIGG/blob/master/app/assets/stylesheets/application.scss)

最後決定參考FUSSAKIGG的寫法

把`application.css`改名成`application.scss`，並在裡面外部引用先前寫好的`mucat_v1.scss`

edit `app/assets/stylesheets/application.scss`

```
@import "mucat_v1";
```

add files to `app/assets/stylesheets`
- `_normalize.scss`
- `mucat_v1.scss`
- `post_project.scss`
- `welcome.scss`


# markdown

主要參考自
- [Markdown & Syntax Highlighting - How to build a blog & portfolio with Rails 4 - YouTube，請看6:59](https://youtu.be/fY2SuLqMD_w?list=PL23ZvcdS3XPK9Y4DRU-BiJtiY5L_QhUUq&t=419)

其他參考資料
- [Klog开发笔记——Markdown 与 Redcarpet 简介 - 万神劫 - Chaos的Blog](http://chaoskeh.com/blog/markdown-and-redcarpet.html)


先在`Gemfile`裝下面兩個gem

```
gem 'pygments.rb', '~> 0.6.3'
gem 'redcarpet', '~> 3.3.4'
```

pygments.rb
- 裝它時最新版本是`0.6.3`
  - [pygments.rb | RubyGems.org | Ruby 社群 Gem 套件管理平台](https://rubygems.org/gems/pygments.rb/versions/0.6.3)
- 需要先裝python，我個人是裝Python2.7.12
  - [tmm1/pygments.rb: pygments syntax highlighting in ruby - GitHub](https://github.com/tmm1/pygments.rb)
  - [Python Release Python 2.7.12 | Python.org](https://www.python.org/downloads/release/python-2712/)

redcarpet
- [redcarpet | RubyGems.org | Ruby 社群 Gem 套件管理平台](https://rubygems.org/gems/redcarpet/versions/3.3.4)
- [vmg/redcarpet: The safe Markdown parser, reloaded. - GitHub](https://github.com/vmg/redcarpet)

and then `bundle install`

然後 `ctrl + c` and `rails s` 來 restart server

## 建立markdown helper

edit `app/helpers/application_helper.rb`

```
module ApplicationHelper
  # 依照不同語言來syntax highlighting
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  # render markdown語法
	def markdown(content)
		renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
		options = {
			autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
		}
		Redcarpet::Markdown.new(renderer, options).render(content).html_safe
	end
end
```

create new file `app/assets/stylesheets/pygments.scss`
- 這邊我是直接複製貼上的：[blog_course_demo/app/assets/stylesheets/pygments.css.scss](https://github.com/mackenziechild/blog_course_demo/blob/master/app/assets/stylesheets/pygments.css.scss)
- 原始出處：[gh-like.css - github markdown css+script with syntax highlighting.](https://gist.github.com/somebox/1082608)

and then fix `app/assets/stylesheets/mucat_v1.scss` to `@import 'pygments';`
