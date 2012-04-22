# -*- encoding: utf-8 -*-
def main()
  input = File.open(ARGV[0])
  output = ARGV[1] ? File.open(ARGV[1], 'w') : STDOUT
  
  num_of_testcases = input.gets.to_i

  num_of_testcases.times do |index|
    ary = input.gets.split.map(&:to_i)
    num_of_googlers  = ary[0]
    num_of_surprised = ary[1]
    threshold = ary[2]
    points = ary[3...ary.length]

    output.puts "Case ##{index+1}: #{calc(num_of_surprised, threshold, points)}"
  end
  
  output.close
  input.close
end

def calc(num_of_surprised, threshold, points)
  num_of_absolutely = 0
  num_of_over_if_surprising = 0
  points.each do |point|
    if absolutely_over?(threshold, point)
      num_of_absolutely += 1
    elsif best_result_if_surprising(point) >= threshold
      num_of_over_if_surprising += 1
    end
  end

  num_of_absolutely + [num_of_surprised, num_of_over_if_surprising].min
end

def absolutely_over?(threshold, point)
  threshold * 3 - 2 <= point
end

def best_result_if_surprising(point)
  return 0 if point == 0
  return 1 if point == 1

  n = point / 3
  case point % 3
  when 0
    n + 1 # [n - 1, n, n + 1]
  when 1
    n + 1 # [n - 1, n + 1, n + 1]
  when 2
    n + 2 # [n, n, n+2]
  end
end

main
