require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutTrueAndFalse < Neo::Koan
  def truth_value(condition)
    if condition
      :true_stuff
    else
      :false_stuff
    end
  end

  def test_true_is_treated_as_true
    assert_equal :true_stuff, truth_value(true)
  end

  def test_false_is_treated_as_false
    assert_equal :false_stuff, truth_value(false)
  end

  def test_nil_is_treated_as_false_too
    # nil 表示一个非值
    assert_equal :false_stuff, truth_value(nil)
  end

  def test_everything_else_is_treated_as_true
    # Ruby 中除了表达式求值为 false 或者 nil 以外，其他表达式均为真
    assert_equal :true_stuff, truth_value(1)
    assert_equal :true_stuff, truth_value(0)
    assert_equal :true_stuff, truth_value([])
    assert_equal :true_stuff, truth_value({})
    assert_equal :true_stuff, truth_value("Strings")
    assert_equal :true_stuff, truth_value("")
  end

end
