module Deklarativna

  class Renderable
    attr_accessor :tag_name,:attributes

    def initialize &initialization_block
      initialization_block.call self
    end

    def render_attributes
      rendering_tags = []
      attribute_list = @attributes.sort if @attributes.respond_to? :sort
      if attribute_list.respond_to? :each
        attribute_list.each do |e|
          rendering_tags.push "#{e[0]}=\"#{e[1]}\""
        end
      end
      return " " + (rendering_tags.join " ") if !rendering_tags.empty?
    end
  end

  class NestingRenderable < Renderable
    attr_accessor :content

    def to_s
      "<#{@tag_name}#{render_attributes}>#{proc_call}</#{@tag_name}>"
    end

    def proc_call
      if @content.nil?
        return ""
      end
      _proc_call
    end

    def _proc_call
      if @content.call.respond_to? :join
        return @content.call.join("")
      end
      @content.call
    end
  end

  class CommentRenderable < NestingRenderable
    def to_s
      "<!--#{proc_call}-->"
    end
  end

  class SingleTagRenderable < Renderable
    def to_s
      "<#{@tag_name}#{render_attributes} />"
    end
  end

  def renderable_string renderable_class, block, attributes={}, tag_name=""
    (renderable_class.new { |instance|
      instance.tag_name = tag_name
      instance.attributes = attributes
      if instance.respond_to? :content
        instance.content = block
      end
    }).to_s
  end

  def single_tag_renderable_string tag_name, attributes={}
    renderable_string SingleTagRenderable, nil, attributes, tag_name
  end

  def nesting_renderable_string tag_name, block, attributes={}
    renderable_string NestingRenderable, block, attributes, tag_name
  end

  def comment_renderable_string comment_block
    renderable_string CommentRenderable, comment_block
  end

  def form_input_renderable_string name, type, attributes
    attributes["name"] = name
    attributes["type"] = type
    single_tag_renderable_string "input", attributes
  end

  def input_with_value tag_name, name, value, attributes
    attributes["value"] = value
    form_input_renderable_string name, tag_name, attributes
  end
end
