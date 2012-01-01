module Deklarativna

  class Renderable
    attr_accessor :tag_name

    def initialize &initialization_block
      initialization_block.call self
    end

    def extra_tags
    end
  end

  class DoubleTagRenderable < Renderable
    attr_accessor :content

    def to_s
      "<#{@tag_name}#{extra_tags}>#{proc_call}</#{@tag_name}>"
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
    def to_s
      "<#{@tag_name} />"
    end
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
end
