require 'deklarativna'
require 'deklarativna_utils'

include Deklarativna

renderable = html {[
               head {
                 css {
                   "p { font-size: 38px; color: red; }"
                 }
               },
               body {
                 paragraphs = []
                 ["john", "dani", "david"].each { |e| paragraphs.push(p { "hola #{e}" }) }
                 paragraphs
               }
             ]}

HTMLExporter.new.launch_rendered_html_on_browser renderable
