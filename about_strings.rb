require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutStrings < Neo::Koan
  def test_double_quoted_strings_are_strings
    # 双引号和单引号框住的串都是字符串字面量
    string = "Hello, World"
    assert_equal true, string.is_a?(String)
  end

  def test_single_quoted_strings_are_also_strings
    string = 'Goodbye, World'
    assert_equal true, string.is_a?(String)
  end

  def test_use_single_quotes_to_create_string_with_double_quotes
    # 这里我换成了对应的转义字符
    string = 'He said, "Go Away."'
    assert_equal "He said, \"Go Away.\"", string
  end

  def test_use_double_quotes_to_create_strings_with_single_quotes
    string = "Don't"
    assert_equal 'Don\'t', string
  end

  def test_use_backslash_for_those_hard_cases
    a = "He said, \"Don't\""
    b = 'He said, "Don\'t"'
    assert_equal true, a == b
  end

  def test_use_flexible_quoting_to_handle_really_hard_cases
    a = %(flexible quotes can handle both ' and " characters)
    b = %!flexible quotes can handle both ' and " characters!
    c = %{flexible quotes can handle both ' and " characters}
    assert_equal true, a == b
    assert_equal true, a == c
  end

  def test_flexible_quotes_can_handle_multiple_lines
    long_string = %{
It was the best of times,
It was the worst of times.
}
    assert_equal 54, long_string.length
    assert_equal 3, long_string.lines.count
    assert_equal "\n", long_string[0,1]
  end

  def test_here_documents_can_also_handle_multiple_lines
    # 这种文档注释，是不算首行（？）空白行的
    long_string = <<EOS
It was the best of times,
It was the worst of times.
EOS
    # end of string
    assert_equal 53, long_string.length
    assert_equal 2, long_string.lines.count
    assert_equal "I", long_string[0,1]
  end

  def test_plus_will_concatenate_two_strings
    # 字符串连接
    string = "Hello, " + "World"
    assert_equal "Hello, World", string
  end

  def test_plus_concatenation_will_leave_the_original_strings_unmodified
    hi = "Hello, "
    there = "World"
    string = hi + there
    assert_equal "Hello, ", hi
    assert_equal "World", there
  end

  def test_plus_equals_will_concatenate_to_the_end_of_a_string
    hi = "Hello, "
    there = "World"
    hi += there
    assert_equal "Hello, World", hi
  end

  def test_plus_equals_also_will_leave_the_original_string_unmodified
    original_string = "Hello, "
    # 说明一下，这里的 hi 其实和 original string 是同一个对象
    hi = original_string
    there = "World"
    # 而这里做的是加法运算，会创建一个新的对象挂到 hi 上面
    hi += there
    assert_equal "Hello, ", original_string
  end

  def test_the_shovel_operator_will_also_append_content_to_a_string
    hi = "Hello, "
    there = "World"
    hi << there
    assert_equal "Hello, World", hi
    assert_equal "World", there
  end

  def test_the_shovel_operator_modifies_the_original_string
    original_string = "Hello, "
    hi = original_string
    there = "World"
    # 这里调用了 hi 的一个类似方法的符号进行 append，并且这个 append 是 in-place 的
    hi << there
    assert_equal "Hello, World", original_string

    # THINK ABOUT IT:
    #
    # Ruby programmers tend to favor the shovel operator (<<) over the
    # plus equals operator (+=) when building up strings.  Why?
  end

  def test_double_quoted_string_interpret_escape_characters
    # 双引号转义
    string = "\n"
    assert_equal 1, string.size
  end

  def test_single_quoted_string_do_not_interpret_escape_characters
    # 单引号不转义，但是有特殊情况
    string = '\n'
    assert_equal 2, string.size
  end

  def test_single_quotes_sometimes_interpret_escape_characters
    # 特殊情况就是单引号自己，和转义它的 backslash
    string = '\\\''
    assert_equal 2, string.size
    assert_equal "\\'", string
  end

  def test_double_quoted_strings_interpolate_variables
    # 双引号进行字符串插值
    value = 123
    string = "The value is #{value}"
    assert_equal "The value is 123", string
  end

  def test_single_quoted_strings_do_not_interpolate
    # 单引号不进行字符串插值
    value = 123
    string = 'The value is #{value}'
    assert_equal "The value is \#{value}", string
  end

  def test_any_ruby_expression_may_be_interpolated
    # 测试任一 Ruby 表达式可以被插值
    string = "The square root of 5 is #{Math.sqrt(5)}"
    assert_equal "The square root of 5 is 2.23606797749979", string
  end

  def test_you_can_get_a_substring_from_a_string
    # 培根、莴苣和番茄
    string = "Bacon, lettuce and tomato"
    assert_equal "let", string[7,3]
    assert_equal "let", string[7..9]
  end

  def test_you_can_get_a_single_character_from_a_string
    string = "Bacon, lettuce and tomato"
    assert_equal "a", string[1]

    # Surprised?
    # 没啥好惊讶的，这个语言，不区分字符和字符串而已，跟 Python 一样
  end

  in_ruby_version("1.8") do
    def test_in_older_ruby_single_characters_are_represented_by_integers
      # 老版本的 Ruby 用 ? 引导单个字符转换为对应 ACSII 整数呀
      assert_equal 97, ?a
      assert_equal true, ?a == 97

      assert_equal true, ?b == (?a + 1)
    end
  end

  # 我用的 2.6.5，选这个
  in_ruby_version("1.9", "2") do
    def test_in_modern_ruby_single_characters_are_represented_by_strings
      # 1.9 版本之后的 Ruby，使用 ? 引导字符串
      assert_equal "a", ?a
      # 字符串不等于数字
      assert_equal false, ?a == 97
    end
  end

  def test_strings_can_be_split
    # 香肠 鸡蛋 芝士
    # 麻了，写着写着饿了
    string = "Sausage Egg Cheese"
    words = string.split
    assert_equal ["Sausage", "Egg", "Cheese"], words
  end

  def test_strings_can_be_split_with_different_patterns
    # regex
    string = "the:rain:in:spain"
    words = string.split(/:/)
    assert_equal ["the", "rain", "in", "spain"], words

    # NOTE: Patterns are formed from Regular Expressions.  Ruby has a
    # very powerful Regular Expression library.  We will become
    # enlightened about them soon.
    # 好耶！（禁止好耶
  end

  def test_strings_can_be_joined
    words = ["Now", "is", "the", "time"]
    assert_equal "Now is the time", words.join(" ")
    # 想到几句玛维的台词语音
    maiev_shadowsong = <<EOS
`Now is the time.'
`I can wait no longer!'
`We're wasting time here!'
`The guilty will suffer!'
`The end draws near.'
`Illidan is out there somewhere.'
EOS

  end

  def test_strings_are_unique_objects
    a = "a string"
    b = "a string"

    # 等值
    assert_equal true, a           == b
    # 不相同
    assert_equal false, a.object_id == b.object_id
  end
end
