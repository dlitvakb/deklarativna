require 'test/unit'
require 'deklarativna'

class DeklarativnaTest < Test::Unit::TestCase
  include Deklarativna
  
  def test_html_renders_single_element
    assert_equal "<html></html>", html
    assert_equal "<body></body>", body
    assert_equal "<head></head>", head
    assert_equal "<script></script>", script
    assert_equal "<style></style>", style
    assert_equal "<p></p>", p
    assert_equal "<div></div>", div
    assert_equal "<span></span>", span
    assert_equal "<table></table>", table
    assert_equal "<tr></tr>", tr
    assert_equal "<td></td>", td
    assert_equal "<a></a>", a
    assert_equal "<form></form>", form
  end
    
  def test_nesting_renderable
    renderable = NestingRenderable.new { |instance|
                   instance.tag_name = "html"
                 }
    assert_equal "<html></html>", renderable.to_s
    renderable = NestingRenderable.new { |instance|
                   instance.tag_name = "html"
                   instance.content = Proc.new { body }
                 }
    assert_equal "<html><body></body></html>", renderable.to_s 
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

  def test_text_renderer
    renderable = TextRenderable.new { |instance|
                   instance.tag_name = "script"
                 }
    assert_equal "<script></script>", renderable.to_s
    renderable = TextRenderable.new { |instance|
                   instance.tag_name = "script"
                   instance.content = Proc.new {"var y = 2; alert(y);"}
                 }
    assert_equal "<script>var y = 2; alert(y);</script>", renderable.to_s
  end

  def test_render_many_tags_on_the_same_level
    renderable = html {
                   [
                     head,
                     body
                   ]
                 }
    assert_equal "<html><head></head><body></body></html>", renderable
    
    renderable = html {
                       [
                         head {
                           script
                         },
                         body {
                           [
                             p { "hola" },
                             p { "chau" }
                           ]
                         }
                       ]
                     }
    assert_equal "<html><head><script></script></head><body><p>hola</p><p>chau</p></body></html>", renderable
  end
  
  def test_style_can_render_css
    renderable = style {
      "h1, p {text-align: left;}"
    }
    assert_equal "<style>h1, p {text-align: left;}</style>", renderable
  end
  
  def test_script_can_render_script
    renderable = script {
      "var y = 2; alert(y);"
    }
    assert_equal "<script>var y = 2; alert(y);</script>", renderable
  end
end