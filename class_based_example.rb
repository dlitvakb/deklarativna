require 'deklarativna'
require 'deklarativna_utils'

class BaseTemplate
  include Deklarativna

  def render
    html {[
      head {
        _head
      },
      body {[
        h1 { "My Totally Awesome Example" },
        _body
      ]}
    ]}
  end

  def _head
  end

  def _body
  end
end

class ChildTemplate < BaseTemplate
  def _head
    css { "h1 { color: red; }" }
  end

  def _body
    [p { "how cool is this??" }, p { "really cool" }]
  end
end

include DeklarativnaUtils

HTMLExporter.new.launch_rendered_html_on_browser BaseTemplate.new.render, "base.html"
HTMLExporter.new.launch_rendered_html_on_browser ChildTemplate.new.render, "child.html"
