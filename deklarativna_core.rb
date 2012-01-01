module Deklarativna

  class Renderable
    attr_accessor :tag_name, :extra_tags

    def initialize &initialization_block
      initialization_block.call self
    end

    def render_extra_tags
      rendering_tags = []
      if @extra_tags.respond_to? :each_pair
        @extra_tags.each_pair do |k, v|
          rendering_tags.push "#{k}=\"#{v}\""
        end
      end
      return " " + (rendering_tags.join " ") if !rendering_tags.empty?
    end
  end

  class DoubleTagRenderable < Renderable
    attr_accessor :content

    def to_s
      "<#{@tag_name}#{render_extra_tags}>#{proc_call}</#{@tag_name}>"
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
      "<#{@tag_name}#{render_extra_tags} />"
    end
  end

  def renderable_string renderable_class, block, extra_tags={}, tag_name=""
    (renderable_class.new { |instance|
      instance.tag_name = tag_name
      instance.extra_tags = extra_tags
      if instance.respond_to? :content
        instance.content = block
      end
    }).to_s
  end

  def single_tag_renderable_string tag_name, extra_tags={}
    renderable_string SingleTagRenderable, nil, extra_tags, tag_name
  end

  def nesting_renderable_string tag_name, block, extra_tags={}
    renderable_string NestingRenderable, block, extra_tags, tag_name
  end

  def text_renderable_string tag_name, block, extra_tags={}
    renderable_string TextRenderable, block, extra_tags, tag_name
  end

  def comment_renderable_string comment_block
    renderable_string CommentRenderable, comment_block
  end

  def form_input_renderable_string name, type, extra_tags
    extra_tags["name"] = name
    extra_tags["type"] = type
    single_tag_renderable_string "input", extra_tags
  end
end
