require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class #empty_array is of class "Array"
    assert_equal 0, empty_array.size      #0 for it is empty! :)
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array      #empty array

    array[0] = 1
    assert_equal [1], array     #index 0 gets '1'

    array[1] = 2
    assert_equal [1, 2], array  #index 1 gets 2, assert [1,2]

    array << 333                #pushes 333 into the array. Cool!!
    assert_equal [1, 2, 333], array      
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]    #symbol :peanut is at index 0
    assert_equal :peanut, array.first #:peanut is up first
    assert_equal :jelly, array[3]     #:jelly at index 3
    assert_equal :jelly, array.last   #:jelly is last
    assert_equal :jelly, array[-1]    #:jelly is at reverse index 1
    assert_equal :butter, array[-3]   #:butter at reverse index 3
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1]            #slice 1 element from starting with 0
    assert_equal [:peanut, :butter], array[0,2]   #slice 2 elements starting from 0
    assert_equal [:and, :jelly], array[2,2]       #slice 2 elements starting from 2
    assert_equal [:and, :jelly], array[2,20]      #slice 20 elements starting from 2. (only 2 elements sliced.)
    assert_equal [], array[4,0]                   #slice no elements from 4 (nil)
    assert_equal [], array[4,100]                 #slice 100 elements after nil -> [nil]
    assert_equal nil, array[5,0]                  #This is crazy.
  end

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class          #(1..5) is of class Range
    assert_not_equal [1,2,3,4,5,6], (1..5)    #added 6 to make it not equal to (1..5)
    assert_equal [1,2,3,4,5], (1..5).to_a     #to array representation of (1..5)
    assert_equal [1,2,3,4], (1...5).to_a      #to array of (1..5) with exclusive on higher bound
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut, :butter, :and], array[0..2]  #same as array[0,2]
    assert_equal [:peanut, :butter], array[0...2]       #... exclude higher bound
    assert_equal [:and, :jelly], array[2..-1]           #from index 2 to reverse index -1
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal [1,2,:last], array     #pushed :last to last place

    popped_value = array.pop
    assert_equal :last, popped_value    #pop :last, so it's a stack? O_o
    assert_equal [1, 2], array          
  end

  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first)

    assert_equal [:first, 1, 2], array  #pushes :first to first using unshift method

    shifted_value = array.shift
    assert_equal :first, shifted_value  #now it's popping the other way. O_O
    assert_equal [1,2], array           #What madness!!!
  end

end
