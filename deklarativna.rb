require 'deklarativna_core'

module Deklarativna

  def html extra_tags={}, &html_block
    nesting_renderable_string "html", html_block, extra_tags
  end

  def head extra_tags={}, &html_block
    nesting_renderable_string "head", html_block, extra_tags
  end

  def title &page_title_block
    text_renderable_string "title", page_title_block
  end

  def link rel="", href="", extra_tags={}
    extra_tags["href"] = href
    extra_tags["rel"] = rel
    single_tag_renderable_string "link", extra_tags
  end

  def meta tags={}
    single_tag_renderable_string "meta", tags
  end

  def script type="", extra_tags={}, &script_text_block
    extra_tags["type"] = type
    text_renderable_string "script", script_text_block, extra_tags
  end

  def style type="", extra_tags={}, &style_text_block
    extra_tags["type"] = type
    text_renderable_string "style", style_text_block, extra_tags
  end

  def body extra_tags={}, &html_block
    nesting_renderable_string "body", html_block, extra_tags
  end

  def h1 extra_tags={}, &html_block
    text_renderable_string "h1", html_block, extra_tags
  end

  def h2 extra_tags={}, &html_block
    text_renderable_string "h2", html_block, extra_tags
  end

  def h3 extra_tags={}, &html_block
    text_renderable_string "h3", html_block, extra_tags
  end

  def h4 extra_tags={}, &html_block
    text_renderable_string "h4", html_block, extra_tags
  end

  def h5 extra_tags={}, &html_block
    text_renderable_string "h5", html_block, extra_tags
  end

  def h6 extra_tags={}, &html_block
    text_renderable_string "h6", html_block, extra_tags
  end

  def p extra_tags={}, &html_block
    nesting_renderable_string "p", html_block, extra_tags
  end

  def div extra_tags={}, &html_block
    nesting_renderable_string "div", html_block, extra_tags
  end

  def span extra_tags={}, &html_block
    nesting_renderable_string "span", html_block, extra_tags
  end

  def table extra_tags={}, &html_block
    nesting_renderable_string "table", html_block, extra_tags
  end

  def tr extra_tags={}, &html_block
    nesting_renderable_string "tr", html_block, extra_tags
  end

  def td extra_tags={}, &html_block
    nesting_renderable_string "td", html_block, extra_tags
  end

  def ul extra_tags={}, &html_block
    nesting_renderable_string "ul", html_block, extra_tags
  end

  def ol extra_tags={}, &html_block
    nesting_renderable_string "ol", html_block, extra_tags
  end

  def li extra_tags={}, &html_block
    nesting_renderable_string "li", html_block, extra_tags
  end

  def a href="", extra_tags={}, &html_block
    extra_tags["href"] = href
    nesting_renderable_string "a", html_block, extra_tags
  end

  def form action="", method="", extra_tags={}, &html_block
    extra_tags["action"] = action
    extra_tags["method"] = method
    nesting_renderable_string "form", html_block, extra_tags
  end

  def text_input name="", extra_tags={}
    form_input_renderable_string name, "text", extra_tags
  end

  def password_input name="", extra_tags={}
    form_input_renderable_string name, "password", extra_tags
  end

  def radio_input name="", value="", extra_tags={}
    extra_tags["value"] = value
    form_input_renderable_string name, "radio", extra_tags
  end

  def checkbox_input name="", value="", extra_tags={}
    extra_tags["value"] = value
    form_input_renderable_string name, "checkbox", extra_tags
  end

  def submit value="Submit", extra_tags={}
    extra_tags["type"] = "submit"
    extra_tags["value"] = value
    single_tag_renderable_string "input", extra_tags
  end

  def center extra_tags={}, &html_block
    nesting_renderable_string "center", html_block, extra_tags
  end

  def dd extra_tags={}, &html_block
    nesting_renderable_string "dd", html_block, extra_tags
  end

  def dl extra_tags={}, &html_block
    nesting_renderable_string "dl", html_block, extra_tags
  end

  def dt extra_tags={}, &html_block
    nesting_renderable_string "dt", html_block, extra_tags
  end

  def i extra_tags={}, &html_block
    nesting_renderable_string "i", html_block, extra_tags
  end

  def b extra_tags={}, &html_block
    nesting_renderable_string "b", html_block, extra_tags
  end

  def em extra_tags={}, &html_block
    nesting_renderable_string "em", html_block, extra_tags
  end

  def strong extra_tags={}, &html_block
    nesting_renderable_string "strong", html_block, extra_tags
  end

  def pre extra_tags={}, &preformatted_text_block
    text_renderable_string "pre", preformatted_text_block, extra_tags
  end

  def br extra_tags={}
    single_tag_renderable_string "br", extra_tags
  end

  def comment &comment_block
    comment_renderable_string comment_block
  end

  def img src="", alt="", extra_tags={}
    extra_tags["src"] = src
    extra_tags["alt"] = alt
    single_tag_renderable_string "img", extra_tags
  end

  def xml_single_tag tag_name, extra_tags={}
    single_tag_renderable_string tag_name.downcase, extra_tags
  end

  def xml_double_tag tag_name, extra_tags={}, &html_block
    nesting_renderable_string tag_name.downcase, html_block, extra_tags
  end
end
