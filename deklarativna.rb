require 'deklarativna_core'

module Deklarativna

  def self.included(base)
    nesting_renderables = ["html", "head", "body", "p", "div", "span",
                           "table", "tr", "td", "ul", "ol", "li",
                           "center", "dd", "dl", "dt", "i", "b",
                           "em", "strong", "title", "pre", "script",
                           "style", "a", "form"]
    (1..6).each { |e| nesting_renderables.push "h#{e}" }

    nesting_renderables.each do
      |tag_name|
      send :define_method, tag_name do
        |*args, &block|
        attributes = args[0] if !args.nil?
        nesting_renderable_string tag_name, block, attributes
      end
    end

    single_tag_renderables = ["meta", "br", "link", "input", "img"]
    single_tag_renderables.each do
      |tag_name|
      send :define_method, tag_name do
        |*args|
        attributes = args[0] if !args.nil?
        single_tag_renderable_string tag_name, attributes
      end
    end

    form_input_renderables = ["text", "password", "textarea", "checkbox",
                              "radio", "submit"]
    form_input_renderables.each do
      |type|
      send :define_method, type do
        |*args|
        attributes = args[9] if !args.nil?
        attributes ||= {}
        attributes["type"] = type
        input attributes
      end
    end
  end

  def javascript attributes={}, &script_text_block
    attributes["type"] = "text/javascript"
    script attributes, &script_text_block
  end

  def css attributes={}, &style_text_block
    attributes["type"] = "text/css"
    style attributes, &style_text_block
  end

  def comment &comment_block
    comment_renderable_string comment_block
  end

  def xml_single_tag tag_name, attributes={}
    single_tag_renderable_string tag_name.downcase, attributes
  end

  def xml_double_tag tag_name, attributes={}, &html_block
    nesting_renderable_string tag_name.downcase, html_block, attributes
  end
end
