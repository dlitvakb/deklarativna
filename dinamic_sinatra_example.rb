require 'rubygems'
require 'sinatra/base'
require 'deklarativna'
require 'deklarativna_utils'

class BaseTemplate
  include Deklarativna
  include DeklarativnaUtils

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
  get '/' do
    IndexTemplate.new.render
  end
end

DeklarativnaSinatra.run!
