require 'deklarativna_core'

module Deklarativna

  def self.included(base)
    nesting_renderables = ["html", "head", "body", "p", "div", "span",
                           "table", "tr", "td", "ul", "ol", "li",
                           "center", "dd", "dl", "dt", "i", "b",
                           "em", "strong"]
    nesting_renderables.each do
      |e|
      send :define_method, e do
        |*args, &block|
        attributes = args[0] if !args.nil?
        nesting_renderable_string e, block, attributes
      end
    end

    text_renderables = ["title", "pre"]
    (1..6).each { |e| text_renderables.push "h#{e}" }
    text_renderables.each do
      |e|
      send :define_method, e do
        |*args, &block|
        attributes = args[0] if !args.nil?
        text_renderable_string e, block, attributes
      end
    end
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
