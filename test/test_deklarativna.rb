require 'test/unit'
require 'deklarativna'

class DeklarativnaTest < Test::Unit::TestCase
  include Deklarativna

  def assert_double_tag tag_name_symbol
    assert_equal "<#{tag_name_symbol.id2name}></#{tag_name_symbol.id2name}>",
                 (self.method tag_name_symbol).call
  end

  def assert_single_tag tag_name_symbol
    assert_equal "<#{tag_name_symbol.id2name} />",
                 (self.method tag_name_symbol).call
  end

  def test_html_renders_single_element
    double_tag_renderables = [:html, :head, :title, :script, :style, :body,
                              :header, :footer, :h1, :h2, :h3, :h4, :h5, :h6,
                              :p, :div, :span, :table, :tr, :td, :ul, :ol, :li,
                              :a, :form, :textarea, :center, :dd, :dl, :dt, :i,
                              :b, :em, :strong, :pre, :select, :option,
                              :article, :section, :code, :abbr, :acronym,
                              :address, :bdo, :big, :tt, :small, :blockquote,
                              :button, :caption, :dfn, :cite, :code, :samp,
                              :kbd, :var, :colgroup, :del, :ins, :dir,
                              :fieldset, :legend, :frameset, :iframe,
                              :noframes, :noscript, :object, :optgroup,
                              :q, :sub, :sup, :thead, :tfoot, :tbody]
    double_tag_renderables.each { |e| assert_double_tag e }

    assert_equal "<script type=\"text/javascript\"></script>", javascript
    assert_equal "<style type=\"text/css\"></style>", css

    single_tag_renderables = [:br, :hr, :img, :base, :input, :col, :frame,
                              :param, :link, :meta]
    single_tag_renderables.each { |e| assert_single_tag e }

    assert_equal "<input type=\"text\" />", text
    assert_equal "<input type=\"password\" />", password
    assert_equal "<input type=\"radio\" />", radio
    assert_equal "<input type=\"checkbox\" />", checkbox
    assert_equal "<input type=\"submit\" />", submit

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
    assert_equal "<html><head><script type=\"text/javascript\">" + 
                 "</script></head><body><p>hola</p><p>chau</p></body></html>",
                 renderable
  end

  def test_style_can_render_css
    renderable = css {
      "h1, p {text-align: left;}"
    }
    assert_equal "<style type=\"text/css\">h1, p {text-align: left;}</style>",
                 renderable
  end

  def test_script_can_render_javascript
    renderable = javascript {
      "var y = 2; alert(y);"
    }
    assert_equal "<script type=\"text/javascript\">var y = 2;" +
                 " alert(y);</script>",
                 renderable
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
    assert_equal "<html><head></head><body></body></html>",
                 BaseTemplate.new.render
  end
end
