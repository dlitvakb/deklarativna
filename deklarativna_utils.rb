require 'deklarativna'
require 'rubygems'
require 'launchy'

module Deklarativna
  class HTMLExporter
    @@default_filename = 'rendered_html.html'
    
    def render_to_file filename, rendered_html
      File.open(filename, 'w') { |f| f.write(rendered_html) }
    end
    
    #Requires Firefox or Chrome
    def launch_file_on_browser filename_or_url
      Launchy.open(filename_or_url)
    end
    
    #Requires Firefox or Chrome
    def launch_rendered_html_on_browser rendered_html
      render_to_file @@default_filename, rendered_html
      Launchy.open(@@default_filename)
    end
  end
end

include Deklarativna

renderable = html {
  [
    head {
      style {
        "p { font-size: 38px; color: red; }"
      }
    },
    body {
      paragraphs = []
      ["john", "dani", "david"].each { |e| paragraphs.push(p { "hola #{e}" }) }
      paragraphs
    }
  ]
}

HTMLExporter.new.launch_rendered_html_on_browser renderable