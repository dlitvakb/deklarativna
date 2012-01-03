require 'rubygems'
require 'sinatra/base'
require 'deklarativna'
require 'deklarativna_utils'

class BaseTemplate
  include Deklarativna
  include DeklarativnaUtils

  def initialize url
    @url = url
  end

  def render
    html {[
      head {[
        title {
          _title
        },
        _head
      ]},
      body {[
        h1 {
          "Deklarativna"
        },
        div {
          _content
        }
      ]}
    ]}
  end

  def _title
    "Deklarativna"
  end

  def _head
  end

  def _content
  end

  def to_file
    HTMLExporter.new.render_to_file @url, render
  end
end

class IndexTemplate < BaseTemplate
  def _content
    p { "Testing Static File Generation using sinatra" }
  end
end

class DeklarativnaSinatra < Sinatra::Base
  set :static, true
  set :public_folder, File.dirname(__FILE__)
end

(BaseTemplate.new "base.html").to_file
(IndexTemplate.new "index.html").to_file
DeklarativnaSinatra.run!
