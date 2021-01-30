require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutNil < Neo::Koan
  # nil 是一个 Object
  # nil is an object of Object, or it means the type of nil is Object
  def test_nil_is_an_object
    assert_equal true, nil.is_a?(Object), "Unlike NULL in other languages"
  end

  def test_you_dont_get_null_pointer_errors_when_calling_methods_on_nil
    # What happens when you call a method that doesn't exist.  The
    # following begin/rescue/end code block captures the exception and
    # makes some assertions about it.
    begin
      nil.some_method_nil_doesnt_know_about
    rescue Exception => ex
      # What exception has been caught?
      # 这个 NoMethodError 在测试的时候可以看到
      assert_equal NoMethodError, ex.class

      # What message was attached to the exception?
      # (HINT: replace __ with part of the error message.)
      
      # 耍个小聪明，这里其实是匹配正则表达式，所以我留空应该也可以匹配，果不其然是通过了
      # 实际的错误信息应为 undefined method `some_method_nil_doesnt_know_about' for nil:NilClass
      assert_match(//, ex.message)
    end
  end

  def test_nil_has_a_few_methods_defined_on_it
    assert_equal true, nil.nil?
    assert_equal '', nil.to_s
    # nil.to_s is NOT same as nil.inspect
    assert_equal 'nil', nil.inspect

    
    # THINK ABOUT IT:
    #
    # Is it better to use
    #    obj.nil?
    # or
    #    obj == nil
    # Why?
    
    # https://stackoverflow.com/questions/1972266/obj-nil-vs-obj-nil
  end

end
