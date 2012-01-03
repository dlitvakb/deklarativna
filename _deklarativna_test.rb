require 'test/unit'
require 'deklarativna'

class DeklarativnaTest < Test::Unit::TestCase
  include Deklarativna

  def test_html_renders_single_element
    assert_equal "<html></html>", html
    assert_equal "<head></head>", head
    assert_equal "<title></title>", title
    assert_equal "<link />", link
    assert_equal "<meta />", meta
    assert_equal "<script></script>", script
    assert_equal "<script type=\"text/javascript\"></script>", javascript
    assert_equal "<style></style>", style
    assert_equal "<style type=\"text/css\"></style>", css
    assert_equal "<body></body>", body
    assert_equal "<h1></h1>", h1
    assert_equal "<h2></h2>", h2
    assert_equal "<h3></h3>", h3
    assert_equal "<h4></h4>", h4
    assert_equal "<h5></h5>", h5
    assert_equal "<h6></h6>", h6
    assert_equal "<p></p>", p
    assert_equal "<div></div>", div
    assert_equal "<span></span>", span
    assert_equal "<table></table>", table
    assert_equal "<tr></tr>", tr
    assert_equal "<td></td>", td
    assert_equal "<ul></ul>", ul
    assert_equal "<ol></ol>", ol
    assert_equal "<li></li>", li
    assert_equal "<a></a>", a
    assert_equal "<form></form>", form
    assert_equal "<input />", input
    assert_equal "<input type=\"text\" />", text
    assert_equal "<input type=\"password\" />", password
    assert_equal "<input type=\"radio\" />", radio
    assert_equal "<input type=\"checkbox\" />", checkbox
    assert_equal "<input type=\"textarea\" />", textarea
    assert_equal "<input type=\"submit\" />", submit
    assert_equal "<center></center>", center
    assert_equal "<dd></dd>", dd
    assert_equal "<dl></dl>", dl
    assert_equal "<dt></dt>", dt
    assert_equal "<i></i>", i
    assert_equal "<b></b>", b
    assert_equal "<em></em>", em
    assert_equal "<strong></strong>", strong
    assert_equal "<pre></pre>", pre

    assert_equal "<br />", br
    assert_equal "<img />", img
    assert_equal "<!---->", comment

    assert_equal "<mysingletag />", (xml_single_tag "mysingletag")
    assert_equal "<mydoubletag></mydoubletag>", (xml_double_tag "mydoubletag")
  end

  def test_render_any_number_of_nestings
    renderable = html {
                   body {
                     p {
                       "hola"
                     }
                   }
                 }
    assert_equal "<html><body><p>hola</p></body></html>", renderable
  end

  def test_render_many_tags_on_the_same_level
    renderable = html {[
                   head,
                   body
                 ]}
    assert_equal "<html><head></head><body></body></html>", renderable

    renderable = html {[
                   head {
                     javascript
                   },
                   body {[
                     p { "hola" },
                     p { "chau" }
                   ]}
                 ]}
    assert_equal "<html><head><script type=\"text/javascript\"></script></head><body><p>hola</p><p>chau</p></body></html>", renderable
  end

  def test_style_can_render_css
    renderable = css {
      "h1, p {text-align: left;}"
    }
    assert_equal "<style type=\"text/css\">h1, p {text-align: left;}</style>", renderable
  end

  def test_script_can_render_javascript
    renderable = javascript {
      "var y = 2; alert(y);"
    }
    assert_equal "<script type=\"text/javascript\">var y = 2; alert(y);</script>", renderable
  end

  def test_comment_block
    renderable = comment {
      "This is a test"
    }
    assert_equal "<!--This is a test-->", renderable
  end

  def test_img
    renderable = img "src"=>"/this.jpg"
    assert_equal "<img src=\"/this.jpg\" />", renderable

    renderable = img "alt"=>"a photo"
    assert_equal "<img alt=\"a photo\" />", renderable

    renderable = img "src"=>"/this.jpg", "alt"=>"a photo"
    assert_equal "<img alt=\"a photo\" src=\"/this.jpg\" />", renderable
  end

  def test_nesting_elements_can_have_attributes
    renderable = p("class"=>"foo") { "something" }
    assert_equal "<p class=\"foo\">something</p>", renderable
  end

  def test_base_template
    assert_equal "<html><head></head><body></body></html>", BaseTemplate.new.render
  end
end
