# -*- encoding: utf-8 -*-

@mapping = {}

def infer_mapping(g, e)
  g_enum, e_enum = g.chars, e.chars
  loop do
    @mapping[g_enum.next] = e_enum.next
  end


  #g.chars.each_with_index do |c, index|
  #  @mapping[c] = e[index]
  #end
end

def translate(g)
  g.gsub(/[a-z]/, @mapping)
end

googlerese = ["zq",
  "ejp mysljylc kd kxveddknmc re jsicpdrysi",
  "rbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd",
  "de kr kd eoya kw aej tysr re ujdr lkgc jv"]

english = ["qz",
  "our language is impossible to understand",
  "there are twenty six factorial possibilities",
  "so it is okay if you want to just give up"]

ge = googlerese.each
ee = english.each
loop do
  infer_mapping(ge.next, ee.next)
end

number_of_testcases = ARGF.gets.to_i

number_of_testcases.times do |index|
  e = translate(ARGF.gets.chomp)
  
  puts "Case ##{index+1}: #{e}"
end
