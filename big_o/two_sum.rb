def pair_sum?(array, target_sum)
  hash = {}
  array.each { |el| hash[el] = target_sum - el }
  check = false
  hash.values.each do |val|
    check = true if hash.has_key?(val) 
  end
  check
end
