require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    # 顾名思义不解释
    empty_array = Array.new
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    # 这个符号相当于 Array#append
    array << 333
    assert_equal [1, 2, 333], array
  end

  def test_accessing_array_elements
    # PB&J 是花生果酱三明治
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    # 数组切片，第一个数字是起始位置，第二个数字是切多少个
    # 具体的上限和范围接下来测试
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    # 超出的数量不算
    assert_equal [:and, :jelly], array[2,20]
    # 注意这里的 4 已经超出 array 的索引范围，但是刚好等于 array 的 size
    # 经过测试此时返回的仍然是空数组
    assert_equal [], array[4,0]
    assert_equal [], array[4,100]
    # 但是比 4 更大的位置进行切片，返回的就是 nil 了，很奇怪
    assert_equal nil, array[5,0]
  end

  def test_arrays_and_ranges
    # 这是一个 Range 类型的
    assert_equal Range, (1..5).class
    # Range 不等于等价的 Array
    assert_not_equal [1,2,3,4,5], (1..5)
    # 在 Ruby 中，Range 的符号两个点是闭区间，三个点是半开区间
    assert_equal [1,2,3,4,5], (1..5).to_a
    assert_equal [1,2,3,4], (1...5).to_a
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    # 0 1 2 
    assert_equal [:peanut, :butter, :and], array[0..2]
    # 0 1 
    assert_equal [:peanut, :butter], array[0...2]
    # 2 3
    assert_equal [:and, :jelly], array[2..-1]
  end

  def test_pushing_and_popping_arrays
    # 简单的尾部 push 和 pop
    array = [1,2]
    array.push(:last)

    assert_equal [1, 2, :last], array

    popped_value = array.pop
    assert_equal :last, popped_value
    assert_equal [1, 2], array
  end

  def test_shifting_arrays
    # 首部的 push 和 pop
    array = [1,2]
    array.unshift(:first)

    assert_equal [:first, 1, 2], array

    shifted_value = array.shift
    assert_equal :first, shifted_value
    assert_equal [1, 2], array
  end

end
