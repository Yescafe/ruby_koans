require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan

  # 哈希表，也就是 Ruby 中的 C++ std::map，Python dictionary

  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    # 这里给的圆括号已经在明示这是什么意思了。参考下一个测试的字面量表示，这里很明显要用 {}
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    # Hash 的字面量表示
    # uno 和 dos 分别是西语的“一”和“二”
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal "uno", hash[:one]
    assert_equal "dos", hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }
    assert_equal "uno", hash.fetch(:one)
    # Hash#fetch 会抛出一个 KeyError 错误
    assert_raise(KeyError) do
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
    # 因为可能会出现 { one: nil } 这样的情形吧
  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => "eins", :two => "dos" }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
    # 不知道
  end

  def test_hash_is_unordered
    # 我觉得与其说 Hash 是无序的，不如说它的内部是排序的（sorted）
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    assert_equal true, hash1 == hash2
  end

  def test_hash_keys
    # Hash#keys 是一个 key 组成的 Array
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?("uno")
    assert_equal true, hash.values.include?("dos")
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_equal true, hash != new_hash

    # 这个例子告诉我们，Hash#merge 的行为有二，其一为添加不存在键的键值对，
    # 其二是修改存在键的键值
    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    assert_equal true, expected == new_hash
  end

  def test_default_value
    # Hash 的默认值，这个行为类似 Python 中的 defaultdict 的行为
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new("dos")
    hash2[:one] = 1

    assert_equal 1, hash2[:one]
    assert_equal "dos", hash2[:two]
  end

  def test_default_value_is_the_same_object
    # 这个测试告诉我们默认值是同一个对象
    hash = Hash.new([])

    # 往默认值数组中 append "uno"
    hash[:one] << "uno"
    # 往默认值数组中 append "dos"
    hash[:two] << "dos"
    # 所以现在默认值数组为 ["uno", "dos"]
    # 并且 one 和 two 键并没有被生成出来，hash.size 仍然为 0
    # assert 0 == hash.size

    assert_equal ["uno", "dos"], hash[:one]
    assert_equal ["uno", "dos"], hash[:two]
    assert_equal ["uno", "dos"], hash[:three]

    assert_equal true, hash[:one].object_id == hash[:two].object_id

    # 实际上，出于编码目的考虑，这个测试中的结果应该并不是 programmer 预期的
  end

  def test_default_value_with_block
    # 使用 Ruby 强大的 block 达到上一个测试中我（们）预期的行为
    hash = Hash.new {|hash, key| hash[key] = [] }

    hash[:one] << "uno"
    hash[:two] << "dos"

    assert_equal ["uno"], hash[:one]
    assert_equal ["dos"], hash[:two]
    assert_equal [], hash[:three]
  end
end
