require 'deklarativna_core'

module Deklarativna

  def html attributes={}, &html_block
    nesting_renderable_string "html", html_block, attributes
  end

  def head attributes={}, &html_block
    nesting_renderable_string "head", html_block, attributes
  end

  def title &page_title_block
    text_renderable_string "title", page_title_block
  end

  def link rel="", href="", attributes={}
    attributes["href"] = href
    attributes["rel"] = rel
    single_tag_renderable_string "link", attributes
  end

  def meta attributes={}
    single_tag_renderable_string "meta", attributes
  end

  def script type="", attributes={}, &script_text_block
    attributes["type"] = type
    text_renderable_string "script", script_text_block, attributes
  end

  def javascript attributes={}, &script_text_block
    script "text/javascript", attributes, &script_text_block
  end

  def style type="", attributes={}, &style_text_block
    attributes["type"] = type
    text_renderable_string "style", style_text_block, attributes
  end

  def css attributes={}, &style_text_block
    style "text/css", attributes, &style_text_block
  end

  def body attributes={}, &html_block
    nesting_renderable_string "body", html_block, attributes
  end

  def h1 attributes={}, &html_block
    text_renderable_string "h1", html_block, attributes
  end

  def h2 attributes={}, &html_block
    text_renderable_string "h2", html_block, attributes
  end

  def h3 attributes={}, &html_block
    text_renderable_string "h3", html_block, attributes
  end

  def h4 attributes={}, &html_block
    text_renderable_string "h4", html_block, attributes
  end

  def h5 attributes={}, &html_block
    text_renderable_string "h5", html_block, attributes
  end

  def h6 attributes={}, &html_block
    text_renderable_string "h6", html_block, attributes
  end

  def p attributes={}, &html_block
    nesting_renderable_string "p", html_block, attributes
  end

  def div attributes={}, &html_block
    nesting_renderable_string "div", html_block, attributes
  end

  def span attributes={}, &html_block
    nesting_renderable_string "span", html_block, attributes
  end

  def table attributes={}, &html_block
    nesting_renderable_string "table", html_block, attributes
  end

  def tr attributes={}, &html_block
    nesting_renderable_string "tr", html_block, attributes
  end

  def td attributes={}, &html_block
    nesting_renderable_string "td", html_block, attributes
  end

  def ul attributes={}, &html_block
    nesting_renderable_string "ul", html_block, attributes
  end

  def ol attributes={}, &html_block
    nesting_renderable_string "ol", html_block, attributes
  end

  def li attributes={}, &html_block
    nesting_renderable_string "li", html_block, attributes
  end

  def a href="", attributes={}, &html_block
    attributes["href"] = href
    nesting_renderable_string "a", html_block, attributes
  end

  def form action="", method="", attributes={}, &html_block
    attributes["action"] = action
    attributes["method"] = method
    nesting_renderable_string "form", html_block, attributes
  end

  def text_input name="", attributes={}
    form_input_renderable_string name, "text", attributes
  end

  def password_input name="", attributes={}
    form_input_renderable_string name, "password", attributes
  end

  def radio_input name="", value="", attributes={}
    input_with_value "radio",  name, value, attributes
  end

  def checkbox_input name="", value="", attributes={}
    input_with_value "checkbox", name, value, attributes
  end

  def submit value="Submit", attributes={}
    attributes["type"] = "submit"
    attributes["value"] = value
    single_tag_renderable_string "input", attributes
  end

  def center attributes={}, &html_block
    nesting_renderable_string "center", html_block, attributes
  end

  def dd attributes={}, &html_block
    nesting_renderable_string "dd", html_block, attributes
  end

  def dl attributes={}, &html_block
    nesting_renderable_string "dl", html_block, attributes
  end

  def dt attributes={}, &html_block
    nesting_renderable_string "dt", html_block, attributes
  end

  def i attributes={}, &html_block
    nesting_renderable_string "i", html_block, attributes
  end

  def b attributes={}, &html_block
    nesting_renderable_string "b", html_block, attributes
  end

  def em attributes={}, &html_block
    nesting_renderable_string "em", html_block, attributes
  end

  def strong attributes={}, &html_block
    nesting_renderable_string "strong", html_block, attributes
  end

  def pre attributes={}, &preformatted_text_block
    text_renderable_string "pre", preformatted_text_block, attributes
  end

  def br attributes={}
    single_tag_renderable_string "br", attributes
  end

  def comment &comment_block
    comment_renderable_string comment_block
  end

  def img src="", alt="", attributes={}
    attributes["src"] = src
    attributes["alt"] = alt
    single_tag_renderable_string "img", attributes
  end

  def xml_single_tag tag_name, attributes={}
    single_tag_renderable_string tag_name.downcase, attributes
  end

  def xml_double_tag tag_name, attributes={}, &html_block
    nesting_renderable_string tag_name.downcase, html_block, attributes
  end
end
