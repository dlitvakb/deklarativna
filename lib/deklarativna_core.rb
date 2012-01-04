module Deklarativna

  ## Abstract Class
  # Base Class for all renderables
  class Renderable
    attr_accessor :tag_name,:attributes

    def initialize &initialization_block
      initialization_block.call self
    end

    ## Private Method
    # This method renders the attributes for any Renderable class
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

  ## Public Class
  # This class is intended to render tags
  # following the '<tagname></tagname>' pattern
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

  ## Public Class
  # This class is intended to render comments
  class CommentRenderable < NestingRenderable
    def to_s
      "<!--#{proc_call}-->"
    end
  end

  ## Public Class
  # This class is intended to render tags
  # following the '<tagname />' pattern
  class SingleTagRenderable < Renderable
    def to_s
      "<#{@tag_name}#{render_attributes} />"
    end
  end

  ## Private Method
  # This is a helper for factory methods
  def renderable_string renderable_class, block, attributes={}, tag_name=""
    (renderable_class.new { |instance|
      instance.tag_name = tag_name
      instance.attributes = attributes
      if instance.respond_to? :content
        instance.content = block
      end
    }).to_s
  end

  ## Private Method
  # Factory Method for creating single tag renderables
  def single_tag_renderable_string tag_name, attributes={}
    renderable_string SingleTagRenderable, nil, attributes, tag_name
  end

  ## Private Method
  # Factory Method for creating nesting renderables
  def nesting_renderable_string tag_name, block, attributes={}
    renderable_string NestingRenderable, block, attributes, tag_name
  end

  ## Private Method
  # Factory Method for creating comment renderables
  def comment_renderable_string comment_block
    renderable_string CommentRenderable, comment_block
  end
end
