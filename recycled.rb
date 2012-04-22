# -*- encoding: utf-8 -*-
def main()
  number_of_testcases = ARGF.gets.to_i

  number_of_testcases.times do |index|
    a, b = ARGF.gets.split.map(&:to_i)

    puts "Case ##{index+1}: #{num_of_pairs(a, b)}"
  end
end

def num_of_pairs(a, b)
  result = 0
  a.upto(b) do |num|
    lp = large_pairs(num).select{|n| a <= n && n <= b}
    result += lp.size
  end
  result
end

@pairs = Hash.new([])
def create_pairs
  
end

def large_pairs(num)
  num_of_digits = num.to_s.length

  pairs = []
  (1...num_of_digits).each do |i|
    pair = recycle(num, i)
    pairs << pair if num < pair
  end

  pairs.uniq
end

def recycle(num, digits)
  s = num.to_s
  front, back = s[0...(s.length - digits)], s[(s.length - digits)...s.length]
  (back + front).to_i
end

main
