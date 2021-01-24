require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    assert_equal ["John", "Smith"], names
  end

  def test_parallel_assignments
    # 这里是叫 parallel assign，应该是 Ruby 的说法。
    # 在我看来类似 Rust 或 C++17 的结构化绑定
    first_name, last_name = ["John", "Smith"]
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal "Smith", last_name
    # 多余的项会被舍弃
  end

  def test_parallel_assignments_with_splat_operator
    # 这个 asterisk 就类似 Python 的
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal ["Smith", 'III'], last_name
  end

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ["Cher"]
    assert_equal "Cher", first_name
    # 少了就是 nil，Python 则是抛出异常
    assert_equal nil, last_name
  end

  def test_parallel_assignments_with_subarrays
    # 数组闭包，或者叫广义表，不多解释了
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    assert_equal ["Willie", "Rae"], first_name
    assert_equal "Johnson", last_name
  end

  def test_parallel_assignment_with_one_variable
    # 唔，这很甜
    first_name, = ["John", "Smith"]
    assert_equal "John", first_name
  end

  def test_swapping_with_parallel_assignment
    # 十分经典的 swap
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    assert_equal "Rob", first_name
    assert_equal "Roy", last_name
  end
end
