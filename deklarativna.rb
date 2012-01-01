module Deklarativna

  class Renderable
    attr_accessor :tag_name
  end

  class DoubleTagRenderable < Renderable
    attr_accessor :content

    def initialize &initialization_block
      initialization_block.call self
    end

    def to_s
      "<#{@tag_name}#{extra_tags}>#{proc_call}</#{@tag_name}>"
    end

    def extra_tags
    end

    def proc_call
      if @content.nil?
        return ""
      end
      _proc_call
    end

    def _proc_call
      raise Exception.new
    end
  end

  class NestingRenderable < DoubleTagRenderable
    def render_block block_result
      if block_result.respond_to? :join
        return block_result.join("")
      end
      block_result
    end

    def _proc_call
      render_block @content.call
    end
  end

  class TextRenderable < DoubleTagRenderable
    def _proc_call
      @content.call
    end
  end

  class CommentRenderable < TextRenderable
    def to_s
      "<!--#{proc_call}-->"
    end
  end

  class SingleTagRenderable < Renderable
  end

  def renderable_string renderable_class, tag_name, block
    (renderable_class.new { |instance|
      instance.tag_name = tag_name
      instance.content = block
    }).to_s
  end

  def nesting_renderable_string tag_name, block
    renderable_string NestingRenderable, tag_name, block
  end

  def text_renderable_string tag_name, block
    renderable_string TextRenderable, tag_name, block
  end

  def html &html_block
    nesting_renderable_string "html", html_block
  end

  def head &html_block
    nesting_renderable_string "head", html_block
  end

  def title &page_title_block
    text_renderable_string "title", page_title_block
  end

  def script type="", &script_text_block
    text_renderable_string "script", script_text_block
  end

  def style type="", &style_text_block
    text_renderable_string "style", style_text_block
  end

  def body &html_block
    nesting_renderable_string "body", html_block
  end

  def h1 &html_block
    text_renderable_string "h1", html_block
  end

  def h2 &html_block
    text_renderable_string "h2", html_block
  end

  def h3 &html_block
    text_renderable_string "h3", html_block
  end

  def h4 &html_block
    text_renderable_string "h4", html_block
  end

  def h5 &html_block
    text_renderable_string "h5", html_block
  end

  def h6 &html_block
    text_renderable_string "h6", html_block
  end

  def p &html_block
    nesting_renderable_string "p", html_block
  end

  def div &html_block
    nesting_renderable_string "div", html_block
  end

  def span &html_block
    nesting_renderable_string "span", html_block
  end

  def table &html_block
    nesting_renderable_string "table", html_block
  end

  def tr &html_block
    nesting_renderable_string "tr", html_block
  end

  def td &html_block
    nesting_renderable_string "td", html_block
  end

  def ul &html_block
    nesting_renderable_string "ul", html_block
  end

  def ol &html_block
    nesting_renderable_string "ol", html_block
  end

  def li &html_block
    nesting_renderable_string "li", html_block
  end

  def a href="", &html_block
    nesting_renderable_string "a", html_block
  end

  def form action="", method="", &html_block
    nesting_renderable_string "form", html_block
  end

  def center &html_block
    nesting_renderable_string "center", html_block
  end

  def dd &html_block
    nesting_renderable_string "dd", html_block
  end

  def dl &html_block
    nesting_renderable_string "dl", html_block
  end

  def dt &html_block
    nesting_renderable_string "dt", html_block
  end

  def i &html_block
    nesting_renderable_string "i", html_block
  end

  def b &html_block
    nesting_renderable_string "b", html_block
  end

  def em &html_block
    nesting_renderable_string "em", html_block
  end

  def strong &html_block
    nesting_renderable_string "strong", html_block
  end

  def pre &preformatted_text_block
    text_renderable_string "pre", preformatted_text_block
  end

  def br
    "<br>"
  end

  def comment &comment_block
    renderable_string CommentRenderable, "", comment_block
  end

  def img src="", alt=""
    "<img src=\"#{src}\" alt=\"#{alt}\" />"
  end
end
