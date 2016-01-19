class String

  def anagrams(other_string)
    self.split("").permutation.to_a.map{ |arr| arr.join }.include?(other_string)
  end

  def anagrams2(other_string)
    deleted = true
    orig = self.split("")
    other = other_string.split("")
    while deleted
      deleted = false

      orig.each.with_index do |letter1, i|
        other.each.with_index do |letter2, j|

          if letter1 == letter2
            orig.delete_at(i)
            other.delete_at(j)
            deleted = true

          end
        end

      end

    end

    orig.length == 0 && other.length == 0
  end

  def anagrams3(other_string)
    self.split("").sort == other_string.split("").sort
  end

  def anagrams4(other_string)
    letter_hash = Hash.new() { |h,k| h[k] = [0,0] }

    self.each_char do |chr|
      letter_hash[chr][0] += 1
    end

    other_string.each_char do |chr|
      return false unless letter_hash.has_key?(chr)
      letter_hash[chr][1] += 1
    end

    letter_hash.each_value do |value|
      return false unless value[0] == value[1]
    end
    true
  end

end

# require 'Benchmark'
# Benchmark.bm do |bm|
#   # bm.report("anagrams: ") do
#   #   "adjkotozgsp".anagrams("bpufihglkma")
#   # end
#   bm.report("anagrams: ") do
#     "abmkdjkotozppooiiuugasdfgsp".anagrams2("bpfihuarasdfgfgkmla")
#   end
#   bm.report("anagrams: ") do
#     "abmkdjkotozppooiiuugasdfgsp".anagrams3("bpfihuarasdfgfgkmla")
#   end
# end
