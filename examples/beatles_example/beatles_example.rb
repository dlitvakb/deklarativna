require 'rubygems'
require 'sinatra/base'
require 'deklarativna'

# Run this example and try the following urls
# localhost:4567/photo/john
# localhost:4567/photo/george
# localhost:4567/photo/paul
# localhost:4567/photo/ringo
class BeatlesController < Sinatra::Base
  get '/photo/:image' do |image|
    (BeatlesView.new image).render
  end
  set :public_folder, File.dirname(__FILE__)
end

class BeatlesView < BaseTemplate
  def initialize image=""
    @image = image
  end

  def _body
    [
    h1 { @image.upcase },
    img("src"=>"/#{@image}.jpg")
    ]
  end
end

BeatlesController.run!

