require 'test/unit'
require 'deklarativna_core'

class DeklarativnaCoreTest < Test::Unit::TestCase
  include Deklarativna

  def test_nesting_renderable
    renderable = NestingRenderable.new { |instance|
                   instance.tag_name = "html"
                 }
    assert_equal "<html></html>", renderable.to_s
    renderable = NestingRenderable.new { |instance|
                   instance.tag_name = "html"
                   instance.content = Proc.new {
                     NestingRenderable.new { |instance|
                       instance.tag_name = "body"
                     }
                   }
                 }
    assert_equal "<html><body></body></html>", renderable.to_s
  end

  def test_text_renderable
    renderable = TextRenderable.new { |instance|
                   instance.tag_name = "script"
                 }
    assert_equal "<script></script>", renderable.to_s
    renderable = TextRenderable.new { |instance|
                   instance.tag_name = "script"
                   instance.content = Proc.new {"var y = 2; alert(y);"}
                 }
    assert_equal "<script>var y = 2; alert(y);</script>", renderable.to_s
  end

  def test_comment_renderable
    renderable = CommentRenderable.new { |instance|
                   instance.content = Proc.new {
                     "some whacky comment"
                   }
                 }
    assert_equal "<!--some whacky comment-->", renderable.to_s
  end

  def test_single_tag_renderable
    renderable = SingleTagRenderable.new { |instance|
      instance.tag_name = "br"
    }
    assert_equal "<br />", renderable.to_s
    renderable = SingleTagRenderable.new { |instance|
      instance.tag_name = "link"
    }
    assert_equal "<link />", renderable.to_s
  end
end
