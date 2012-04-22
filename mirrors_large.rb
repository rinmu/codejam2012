# -*- encoding: utf-8 -*-
def main
  input = File.open(ARGV[0])
  output = ARGV[1] ? File.open(ARGV[1], 'w') : STDOUT
  
  num_of_testcases = input.gets.to_i

  num_of_testcases.times do |index|
    h, w, d = input.gets.split.map(&:to_i)
    table = h.times.map{ input.gets.chomp.chars.to_a }

    hall = Hall.new(h, w, d, table)

    vt = hall.virtual_table
    vt.display    
    x = hall.x_coord
    ms = vt.m_coordenates.select {|m| distance(x, m) <= d }
    count = ms.map{|m| [quadrant(x, m), slope(x, m)]}.uniq.size
    
    output.puts "Case ##{index+1}: #{count}"
  end
  
  output.close
  input.close
end

def quadrant(a, b)
  x = a[0] - b[0]
  y = a[1] - b[1]

  case
  when x >= 0 && y >= 0
    1
  when x < 0 && y >= 0
    2
  when x < 0 && y < 0
    3
  when x >= 0 && y < 0
    4
  end
end

def slope(a, b)
  (a[0] - b[0]).to_f / (a[1] - b[1]).to_f
end

def distance(a, b)
  Math.sqrt((a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2)
end

class Hall
  attr_accessor :height, :width, :distance, :table

  def initialize(h, w, d, t)
    self.height   = h - 2
    self.width    = w - 2
    self.distance = d
    t.shift; t.pop # 上下の鏡壁を取り除く
    self.table = t.map{|row| row.shift; row.pop; row} #左右の鏡壁を取り除く
  end

  def x_coord
    x = nil
    y = self.table.index do |row|
      x = row.index("X")
    end
    [x, y]
  end

  def to_s
    table.map{|row| "#{row.join}\n"}.join
  end

  def mirror_image
    @mirror_image || @mirror_image = self.table.map{|row| row.map{|c| c == "X" ? "M" : c} }
  end

  def flip_horizontal
    @flip_horizontal || @flip_horizontal = self.mirror_image.map(&:reverse)
  end

  def flip_vertical
    @flip_vertical || @flip_vertical = self.mirror_image.reverse
  end

  def rotate
    @rotate || @rotate = self.mirror_image.reverse.map(&:reverse)
  end

  def virtual_table
    VirtualTable.new(self)
  end
end

def m_coord(table)
  x = nil
  y = table.index do |row|
    x = row.index("M")
  end

  [x, y]
end

class VirtualTable
  def initialize(hall)
    @hall = hall
  end

  def [](x, y)
    return @hall.table if x == 0 && y == 0
    case
    when x % 2 == 0 && y % 2 == 0
      @hall.mirror_image
    when x % 2 == 0 && y % 2 == 1
      @hall.flip_vertical
    when x % 2 == 1 && y % 2 == 0
      @hall.flip_horizontal
    when x % 2 == 1 && y % 2 == 1
      @hall.rotate
    end
  end

  def display
    x_wing = @hall.distance / @hall.width + 1
    y_wing = @hall.distance / @hall.height + 1
    (-y_wing).upto(y_wing).each do |y|
      @hall.height.times do |i|
	(-x_wing).upto(x_wing).each do |x|
	  print self[x, y][i].join
	end
	puts
      end
    end
  end

  def m_coordenates
    result = []
    x_wing = @hall.distance / @hall.width + 1
    y_wing = @hall.distance / @hall.height + 1
    (-x_wing).upto(x_wing).each do |_x|
      (-y_wing).upto(y_wing).each do |_y|
	next if _x == 0 && _y == 0
	x, y = m_coord(self[_x, _y])
        x += @hall.width * _x
	y += @hall.height * _y
	result << [x, y]
      end
    end
    result
  end

end

main
