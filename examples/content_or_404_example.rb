require 'sinatra/base'
require 'deklarativna'

class DynamicTemplate < BaseTemplate
  attr_accessor :content

  def initialize
    @content = {}
    yield self if block_given?
  end


  def _head
    [
      title { @content["title"] }
    ]
  end

  def _body
    begin
      #Just for showing how would a simple 404 would work
      raise "404" if @content.count < 1
      body_content = [
        h1 { @content["title"] },
        p { @content["first_line"] }
      ]
      if @content["a_list"].respond_to? :each
        @content["a_list"].each { |elem|
          body_content.push( p { elem })
        }
      end
      body_content
    rescue
      [
        h1 { "#{$!} - Object not found" },
        p { puts @content }
      ]
    end
  end
end

class DeklarativnaSinatraRemixed < Sinatra::Base
  get '/' do
    template = DynamicTemplate.new { |instance|
                 instance.content["title"] = "Deklarativna"
                 instance.content["first_line"] = "Hey how cool is this?"
                 instance.content["a_list"] = [
                   "really cool",
                   "cool cool",
                   "more than cool"
                 ]
               }
    template.render
  end

  get '/404' do
    DynamicTemplate.new.render
  end
end

DeklarativnaSinatraRemixed.run!
