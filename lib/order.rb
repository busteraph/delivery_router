class Order
  attr_accessor :id, :restaurant, :customer, :state

  def initialize(p)
    self.customer = p[:customer]
    self.restaurant = p[:restaurant]
    self.state = "new"
  end

end
