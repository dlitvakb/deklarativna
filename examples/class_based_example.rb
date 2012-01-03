require 'deklarativna'
require 'deklarativna_utils'

class ChildTemplate < BaseTemplate
  def _head
    css { "h1 { color: red; }" }
  end

  def _body
    [
      h1 { "Deklarativna" },
      p { "how cool is this??" },
      p { "really cool" }
    ]
  end
end

include DeklarativnaUtils

HTMLExporter.new.launch_rendered_html_on_browser ChildTemplate.new.render
