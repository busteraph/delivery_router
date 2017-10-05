class Rider
  attr_accessor :id, :speed, :x, :y

  def initialize(p)
    self.id = p[:id]
    self.speed = p[:speed]
    self.x = p[:x]
    self.y = p[:y]
  end

  def self.find(id)
    self.id == id
  end
  
end
