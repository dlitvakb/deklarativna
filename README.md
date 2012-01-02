#Deklarativna
###A declarative HTML embedded DSL

##Purpose
The purpose of **Deklarativna** is to make HTML template creation 
an integrated part of frontend development, allowing the programmer
to write *human readable code* with not much effort.

##Conception
This work has been started as a tool for teaching *declarative programming*
and *DSL creation* to univeritary students.
This is a work in progress and *I hope* someday will have integration
with the most popular web frameworks

##Current Status
All *HTML* common tags are implemented - frame, iframe and some html5 tags
had not been added.
Support for *XML* tags with *xml_single_tag* and *xml_double_tag*
is added. 
Core module classes and helpers have *full support* for attributes.

##Usage
For simple templating you can use the function approach

```ruby
require 'deklarativna'
require 'deklarativna_utils'

include Deklarativna
include DeklarativnaUtils

renderable = html {[
              head {
                  css {
                      ".hello { float: right; color: #456546 }"
                  }
              },
              body {
                  p("class"=>"hello") {
                      "Hello World!"
                  }
              }
            ]}

HTMLExporter.new.launch_rendered_html_on_browser renderable
```

For advance templating, supporting *inheritance* you can use a *Class
Based* approach

```ruby
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
```
