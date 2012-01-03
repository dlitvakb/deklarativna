require 'rubygems'
require 'sinatra/base'
require 'deklarativna'

class IndexTemplate < BaseTemplate
  def _body
    [
      p { "Testing Dinamic File Generation using sinatra" },
      table("border"=>"1") {[
        tr {[
          td { "row 1, value 1" },
          td { "row 1, value 2" }
        ]},
        tr {[
          td("colspan"=>"2") { "Only value in this row" }
        ]}
      ]}
    ]
  end
end

class DeklarativnaSinatra < Sinatra::Base
  get '/' do
    IndexTemplate.new.render
  end
end

DeklarativnaSinatra.run!
