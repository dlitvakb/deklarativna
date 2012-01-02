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

##Usage
```ruby
require 'deklarativna'
require 'deklarativna_utils'

include Deklarativna

renderable = html {[
              head {
                  css {
                      "p { float: right; color: #456546 }"
                  }
              },
              body {
                  p {
                      "Hello World!"
                  }
              }
            ]}

HTMLExporter.new.launch_rendered_html_on_browser renderable
```
