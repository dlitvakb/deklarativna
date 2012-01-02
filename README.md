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
Partial support for *XML* tags with *xml_single_tag* and *xml_double_tag*
is added.

Core module classes and helpers have *full support* for attributes
```ruby
require 'deklarativna_core'
include Deklarativna

def p_with_class_attribute class_value, &html_block
  extra_tags = {"class"=>class_value}
  p extra_tags, &html_block
end

p_with_class_attribute "some-class" { "something" }
# => <p class="some-class">something</p>

(NestingRenderable.new { |instance|
  instance.tag_name = "p"
  instance.extra_tags = {"some_attribute"=>"some_value"}
  instance.content = Proc.new {"something"}
}).to_s # => <p some_attribute="some_value">something</p>
```

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
