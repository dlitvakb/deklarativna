module Deklarativna

  class Renderable
    attr_accessor :tag_name, :content

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
  
  class NestingRenderable < Renderable
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
  
  class TextRenderable < Renderable
    def _proc_call
      @content.call
    end
  end
  
  def nesting_renderable_string tag_name, block
    (NestingRenderable.new { |instance|
      instance.tag_name = tag_name
      instance.content = block
    }).to_s  
  end
  
  def text_renderable_string tag_name, block
    (TextRenderable.new { |instance|
        instance.tag_name = tag_name
        instance.content = block
    }).to_s
  end
  
  def html &html_block
    nesting_renderable_string "html", html_block
  end
  
  def body &html_block
    nesting_renderable_string "body", html_block
  end
  
  def head &html_block
    nesting_renderable_string "head", html_block
  end
  
  def script type="", &script_text_block
    text_renderable_string "script", script_text_block
  end
  
  def style type="", &style_text_block
    text_renderable_string "style", style_text_block
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
  
  def a href="", &html_block
    nesting_renderable_string "a", html_block
  end
  
  def form action="", method="", &html_block
    nesting_renderable_string "form", html_block
  end
end
