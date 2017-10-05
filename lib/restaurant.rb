class Restaurant
  attr_accessor :id, :cooking_time, :x, :y

  def initialize(p)
    self.id = p[:id]
    self.cooking_time = p[:cooking_time]
    self.x = p[:x]
    self.y = p[:y]
  end

  def self.find(id)
    self.id == id
  end

end
