require 'test/unit'
require 'deklarativna'

class DeklarativnaTest < Test::Unit::TestCase
  include Deklarativna

  def test_html_renders_single_element
    assert_equal "<html></html>", html
    assert_equal "<head></head>", head
    assert_equal "<title></title>", title
    assert_equal "<link href=\"\" rel=\"\" />", link
    assert_equal "<meta />", meta
    assert_equal "<script type=\"\"></script>", script
    assert_equal "<style type=\"\"></style>", style
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
    assert_equal "<a href=\"\"></a>", a
    assert_equal "<form method=\"\" action=\"\"></form>", form
    assert_equal "<input name=\"\" type=\"text\" />", text_input
    assert_equal "<input name=\"\" type=\"password\" />", password_input
    assert_equal "<input name=\"\" type=\"radio\" value=\"\" />", radio_input
    assert_equal "<input name=\"\" type=\"checkbox\" value=\"\" />", checkbox_input
    assert_equal "<input value=\"Submit\" type=\"submit\" />", submit
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
    assert_equal "<!---->", comment
    assert_equal "<img src=\"\" alt=\"\" />", img

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
                     script
                   },
                   body {[
                     p { "hola" },
                     p { "chau" }
                   ]}
                 ]}
    assert_equal "<html><head><script type=\"\"></script></head><body><p>hola</p><p>chau</p></body></html>", renderable
  end

  def test_style_can_render_css
    renderable = style {
      "h1, p {text-align: left;}"
    }
    assert_equal "<style type=\"\">h1, p {text-align: left;}</style>", renderable
  end

  def test_script_can_render_script
    renderable = script {
      "var y = 2; alert(y);"
    }
    assert_equal "<script type=\"\">var y = 2; alert(y);</script>", renderable
  end

  def test_comment_block
    renderable = comment {
      "This is a test"
    }
    assert_equal "<!--This is a test-->", renderable
  end

  def test_img
    renderable = img src="/this.jpg"
    assert_equal "<img src=\"/this.jpg\" alt=\"\" />", renderable

    renderable = img src="", alt="a photo"
    assert_equal "<img src=\"\" alt=\"a photo\" />", renderable

    renderable = img src="/this.jpg", alt="a photo"
    assert_equal "<img src=\"/this.jpg\" alt=\"a photo\" />", renderable
  end

end
