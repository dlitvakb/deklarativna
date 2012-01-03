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
###Function Based Approach

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

###Class Based Approach

```ruby
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

HTMLExporter.new.launch_rendered_html_on_browser ChildTemplate.new.render, "child.html"
```

###Sinatra Integration

```ruby
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
```

Test this by running

```bash
$ruby dinamic_sinatra_example.rb
```
And open your browser on **localhost:4567**
