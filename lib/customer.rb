class Customer
  attr_accessor :id, :x, :y

  def initialize(p)
    self.id = p[:id]
    self.x = p[:x]
    self.y = p[:y]
  end

  def self.find(id)
    self.id == id
  end
end
