require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    assert_equal ["John", "Smith"], names
  end

  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"]
    assert_equal "John", first_name     #gets first element
    assert_equal "Smith", last_name     #gets second element
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name   #same as above but no variable to hold for 3rd element
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name               #splat operator will assign first element to first_name..
    assert_equal ["Smith", "III"], last_name      #..and the remaining array to last_name
  end

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ["Cher"]
    assert_equal "Cher", first_name   #Cher's gonna end up with nil for a last name...
    assert_equal nil, last_name
  end

  def test_parallel_assignments_with_subarrays
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    assert_equal ["Willie", "Rae"], first_name #same concept, first_name will get first element, in this case is an array itself
    assert_equal "Johnson", last_name 
  end

  def test_parallel_assignment_with_one_variable
    first_name, = ["John", "Smith"]
    assert_equal "John", first_name #only has room for first element
  end

  def test_swapping_with_parallel_assignment
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    assert_equal "Rob", first_name  #Premade swap function, this can be really useful.
    assert_equal "Roy", last_name   #Starting to blow my mind.
  end
end
