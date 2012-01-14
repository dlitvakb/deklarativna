require 'deklarativna_core'

## Module
# Deklarativna is a module thought for creating embedded HTML/XML
# templates fully written in ruby
#
# It can provide its functionallity to any of your ruby existing code
# just by adding  `include Deklarativna` inside your classes or modules
module Deklarativna

  ## Private Method
  # It metaprograms most of the module's methods
  def self.included(base)
    nesting_renderables = ["html", "head", "body", "header", "footer",
                           "p", "div", "span", "table", "tr", "td",
                           "ul", "ol", "li", "center", "dd", "dl",
                           "dt", "i", "b", "em", "strong", "title",
                           "pre", "script", "style", "a", "form", "textarea"]
    (1..6).each { |e| nesting_renderables.push "h#{e}" }

    nesting_renderables.each do
      |tag_name|
      send :define_method, tag_name do
        |*args, &block|
        attributes = args[0] if !args.nil?
        nesting_renderable_string tag_name, block, attributes
      end
    end

    single_tag_renderables = ["meta", "br", "hr",
                              "link", "input", "img"]
    single_tag_renderables.each do
      |tag_name|
      send :define_method, tag_name do
        |*args|
        attributes = args[0] if !args.nil?
        single_tag_renderable_string tag_name, attributes
      end
    end

    form_input_renderables = ["text", "password", "checkbox",
                              "radio", "submit"]
    form_input_renderables.each do
      |type|
      send :define_method, type do
        |*args|
        attributes = args[0] if !args.nil?
        attributes ||= {}
        attributes["type"] = type
        input attributes
      end
    end
  end

  ## Public Method
  # Helper for adding your javascript to the template
  def javascript attributes={}, &script_text_block
    attributes["type"] = "text/javascript"
    script attributes, &script_text_block
  end

  ## Public Method
  # Helper for adding your css to the template
  def css attributes={}, &style_text_block
    attributes["type"] = "text/css"
    style attributes, &style_text_block
  end

  ## Public Method
  # Helper for adding your comments to the template
  def comment &comment_block
    comment_renderable_string comment_block
  end

  ## Public Method
  # Helper for adding XML tags with the format '<tagname />'
  def xml_single_tag tag_name, attributes={}
    single_tag_renderable_string tag_name.downcase, attributes
  end

  ## Public Method
  # Helper for adding XML tags with the format '<tagname></tagname>'
  def xml_double_tag tag_name, attributes={}, &html_block
    nesting_renderable_string tag_name.downcase, html_block, attributes
  end
end

## Public Class
# Base Class for Template Creation using Deklarativna Class Based Model
# If you need any special implementation, you can create your own using
# this one as example, or just extend this one
class BaseTemplate
  include Deklarativna

  ## Public Method
  # Creates the rendered html
  def render
    html {[
      head {
        _head
      },
      body {
        _body
      }
    ]}
  end

  ## Template Method
  # Should be redefined in your own classes
  def _head
  end

  ## Template Method
  # Should be redefined in your own classes
  def _body
  end
end
