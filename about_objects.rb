require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutObjects < Neo::Koan
  def test_everything_is_an_object
    assert_equal true, 1.is_a?(Object)        #everything in ruby is an object. true for all cases
    assert_equal true, 1.5.is_a?(Object)
    assert_equal true, "string".is_a?(Object)
    assert_equal true, nil.is_a?(Object)
    assert_equal true, Object.is_a?(Object)
  end

  def test_objects_can_be_converted_to_strings
    assert_equal "123", 123.to_s    #same string representation of object. Not to be confused with .inspect which returns object name
    assert_equal "", nil.to_s
  end

  def test_objects_can_be_inspected
    assert_equal "123", 123.inspect    #human readable name of object.
    assert_equal "nil", nil.inspect
  end

  def test_every_object_has_an_id
    obj = Object.new
    assert_equal Fixnum, obj.object_id.class #passed Fixnum as parameter to hold obj int value ?*?*?
  end

  def test_every_object_has_different_id
    obj = Object.new
    another_obj = Object.new
    assert_equal true, obj.object_id != another_obj.object_id #all objects have unique id
  end

  def test_small_integers_have_fixed_ids #Object ID = value + Fixnum, but for int we simply shift bits over.
    assert_equal 1, 0.object_id          #0000 -> 0001 
    assert_equal 3, 1.object_id          #0001 -> 0011
    assert_equal 5, 2.object_id          #0010 -> 0101
    assert_equal 201, 100.object_id      #01100100 -> 011001001

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow? Answer: shifts one bit left (basically multiply by 2). + 1 to make it always odd.
    #
    # ** I"m still a little unclear on this part, I'll continue to read into what Fixnum and VALUE are and how they relate to .object_id **
    #
  end

  def test_clone_creates_a_different_object
    obj = Object.new
    copy = obj.clone

    assert_equal true, obj           != copy            #clone creates different object,
    assert_equal true, obj.object_id != copy.object_id  #and different object means different id!!
  end
end
