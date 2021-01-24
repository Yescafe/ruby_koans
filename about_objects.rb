require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutObjects < Neo::Koan
  def test_everything_is_an_object
    # 这个例子就是告诉我们万物皆为对象
    assert_equal true, 1.is_a?(Object)
    assert_equal true, 1.5.is_a?(Object)
    assert_equal true, "string".is_a?(Object)
    assert_equal true, nil.is_a?(Object)
    # 包括对象自己的“类类型”（不知道 Ruby 是不是这样称呼的）
    assert_equal true, Object.is_a?(Object)
  end

  def test_objects_can_be_converted_to_strings
    assert_equal '123', 123.to_s
    assert_equal '', nil.to_s
  end

  def test_objects_can_be_inspected
    assert_equal '123', 123.inspect
    # 在 about_nil 里有提到过 nil.to_s 和 nil.inspect 不同
    assert_equal 'nil', nil.inspect
  end

  def test_every_object_has_an_id
    obj = Object.new
    # 经测试是整数
    # 当然可以耍小聪明写 Object
    assert_equal Integer, obj.object_id.class
  end

  def test_every_object_has_different_id
    # 上面这个测试的名字已经写的很清楚了
    obj = Object.new
    another_obj = Object.new
    assert_equal true, obj.object_id != another_obj.object_id
  end

  def test_small_integers_have_fixed_ids
    assert_equal 1, 0.object_id
    assert_equal 3, 1.object_id
    assert_equal 5, 2.object_id
    assert_equal 201, 100.object_id

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow?
    # n 的 object ID 是 2n+1
  end

  def test_clone_creates_a_different_object 
    obj = Object.new
    copy = obj.clone

    # 测试名说明了 Object#clone 创建的是完全不同的对象
    assert_equal true, obj           != copy
    # 所以它们的 ID 也不同
    assert_equal true, obj.object_id != copy.object_id
  end
end
