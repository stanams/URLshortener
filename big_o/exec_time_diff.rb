require "byebug"

# if we have time, figure out a big O calculator

def my_min(list)
  list.each do |el|
    equal_or_smaller = []
    list.each do |el2|
      equal_or_smaller << el2 if el2 < el
    end
    return el if equal_or_smaller.empty?
  end
end


def my_min2(list)
  min = list.shift
  list.each do |el|
    min = el if min > el
  end
  min
end



def big_subsum(list)
  subsets = []

  0.upto(list.length - 1) do |idx|

    idx.upto(list.length-1) do |jdx|
        subsets << list[idx..jdx]
    end

  end

  subsets.each do |sub_array|
    totals = []
    first_sum = sub_array.inject(&:+)
    subsets.each do |sub_array2|
      second_sum = sub_array2.inject(&:+)
      totals << second_sum if second_sum > first_sum
    end
    return first_sum if totals.empty?
  end
end




# list2 = (1..50).to_a.shuffle
# list3 = (1..100).to_a.shuffle
# list4 = (1..150).to_a.shuffle

# require 'Benchmark'
# Benchmark.bm do |bm|
#   bm.report("big_subsum 1-50: ") do
#     big_subsum(list2)
#   end
#   bm.report("big_subsum 1-100: ") do
#     big_subsum(list3)
#   end
#   bm.report("big_subsum 1-150: ") do
#     big_subsum(list4)
#   end
#   bm.report("my_min2: ") do
#     my_min2(list)
#   end
# end

def otter_sum(list)
  running_total = 0
  global_min = 0
  global_max = 0
  global_min_first = true
  all_negatives = true
  min_neg = list.first

  list.each do |el|
    if all_negatives == true
      if el < 0
        min_neg = el if el > min_neg
      else
        all_negatives = false
      end
    end

    running_total += el

    if running_total < global_min
      global_min = running_total
      global_min_first = false
    elsif running_total > global_max
      global_max = running_total
      global_min_first = true
    end

  end

  comp = [global_max, running_total - global_min]

  if global_min_first == true
    comp << global_max - global_min
  end

  return min_neg if all_negatives == true
  return comp.max
end

def gersacci_sum(list)
  max_sum = 0
  current = 0
  list.each do |el|
    current += el
    if el > max_sum && el > current
      max_sum = el
      current = max_sum
    end
    max_sum = current if current > max_sum
  end
  max_sum
end




















""
