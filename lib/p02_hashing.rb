CHAR_MAP = Hash.new(0)

("a".."z").each_with_index{ |letter, int| CHAR_MAP[letter] = int + 1 }
("0".."9").each_with_index{ |int, index| CHAR_MAP[int] = index }

class Fixnum
  # Done!
end

class Array
  def hash
    self.to_s.downcase.split("").map{|chr| CHAR_MAP[chr]}.join("").to_i
  end
end

class String
  def hash
    self.downcase.split("").map{|chr| CHAR_MAP[chr]}.join("").to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_s.downcase.split("").sort.map{|chr| CHAR_MAP[chr]}.join("").to_i
  end
end
