require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class   #empty_hash is of class Hash
    assert_equal({}, empty_hash)          #it's empty. {}
    assert_equal 0, empty_hash.size       #yes.
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size     #2 keys/value pair in this hash
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal "uno", hash[:one]        #hash value of symbol :one is "uno"
    assert_equal "dos", hash[:two]        #"dos" !!
    assert_equal nil, hash[:doesnt_exist] #nil cause it does not exist!! :)
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }
    assert_equal "uno", hash.fetch(:one)    #fetches the hash value of :one
    assert_raise(IndexError::KeyError) do   #KeyError, when no Key found. Subclass of IndexError.
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys? 
    # Answer: #fetch can accept additional parameters such as default_value. #[] will only get you the value or return nil if no value found.
  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => "eins", :two => "dos" }
    assert_equal expected, hash  #Can you also do assert_equal({ :one => "eins", :two => "dos" },hash) ??

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
    # Answer: Ruby will treat passing hash literals as blocks.
  end

  def test_hash_is_unordered
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    assert_equal true, hash1 == hash2 #hash key/values are still the same
  end

  def test_hash_keys
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.keys.size              #there are 2 hash keys
    assert_equal true, hash.keys.include?(:one) #:one is there
    assert_equal true, hash.keys.include?(:two) #so is :two !!
    assert_equal Array, hash.keys.class         #and they are both of class type Array
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.values.size                #similiar to above, 2 hash values
    assert_equal true, hash.values.include?("uno")  #"uno" is one of them
    assert_equal true, hash.values.include?("dos")  #"dos" is another!
    assert_equal Array, hash.values.class           #both are of type Array. So array of keys  -Hash to -> array of values??
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 }) #key "jim" gets new hash value of 54

    assert_equal true, hash != new_hash                   #so they are not equal

    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    assert_equal true, expected == new_hash #yes that is the new hash.
  end

  def test_default_value
    hash1 = Hash.new              #creates new hash
    hash1[:one] = 1               #key :one gets value 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two] #no value for key :two

    hash2 = Hash.new("dos")       #Initialize hash with default "dos" value for all keys
    hash2[:one] = 1               #:one key gets new hash value of 1

    assert_equal 1, hash2[:one]
    assert_equal "dos", hash2[:two] #still has default value of "dos"
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([])    #Now it's initializing with a SINGLE default array for ALL keys

    hash[:one] << "uno"    #Since :one does not exist, returns default array to push "uno" into
    hash[:two] << "dos"    #:two is also not there, now it pushes "dos" into ["uno"] -> ["uno", "dos"]

    assert_equal ["uno", "dos"], hash[:one]     #:one was not found before so it started off with "uno" but got "dos" when :two was not found
    assert_equal ["uno", "dos"], hash[:two]     #:two was not found so the default array with "uno" was called to add "dos" to
    assert_equal ["uno", "dos"], hash[:three]   #:there is not there so it now has "uno" and "dos" from the previous 2 attempted pushes.

    assert_equal true, hash[:one].object_id == hash[:two].object_id #
  end

  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] } #same as above but now EACH key gets its own array

    hash[:one] << "uno"           #pushes "uno" to the default empty [] for key :one
    hash[:two] << "dos"           #does the same but only do the array for :two

    assert_equal ["uno"], hash[:one]
    assert_equal ["dos"], hash[:two]
    assert_equal [], hash[:three] #three never had anything done to it so it still has it's own default array
  end
end
