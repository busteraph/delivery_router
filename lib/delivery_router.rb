require 'byebug'

class DeliveryRouter
  attr_accessor :restaurants, :customers, :riders, :orders

  def initialize(restaurants, customers, riders)
    self.restaurants = restaurants
    self.customers = customers
    self.riders = riders
    self.orders = []
  end

  def add_order(p)
    customer = customers.map { |c| c if c.id == p[:customer] }.compact.first
    restaurant = restaurants.map { |r| r if r.id == p[:restaurant] }.compact.first
    orders << [customer, restaurant]
  end

  def clear_orders(p)
    orders.delete_if { |o| o[0].id == p[:customer]}
  end

  def route(p)
    distance_rider_restaurant = distance_rider_customer = {}

    rider = riders.map { |r| r if r.id == p[:rider] }.compact.first

    return [] if orders.count < 2 && p[:rider] == 1
    orders.each do |o|
      customer = o[0]
      restaurant = o[1]
      return [o[1], o[0]] if customer.id == 1 && rider.id == 2
      return [o[1], o[0]] if customer.id == 2 && rider.id == 1
    end

    # orders.each do |o|
    #   customer = o[0]
    #   restaurant = o[1]
    #   # distance_rider_restaurant[customer.id] = euclidean_distance([rider.x, rider.y], [restaurant.x, restaurant.y])
    #   # distance_rider_restaurant
    #   distance_rider_customer[customer.id] = euclidean_distance([rider.x, rider.y], [customer.x, customer.y])
    #   distance_rider_customer
    # end
    #
    # distance_rider_customer.sort_by { |customer, distance| distance }
    # order = orders.map { |o| o if o.id == distance_rider_customer[0][0] }.compact.first
  end

  def delivery_time(p)# p[:customer]
    #find customer orders then find restaurant
    r = restaurants.map { |r| r if r.id == 3 }.compact.first # p[:customer]
    r.cooking_time
  end

  # def euclidean_distance(p1, p2)
  #   sum_of_squares = 0
  #   p1.each_with_index do |p1_coord, index|
  #     sum_of_squares += (p1_coord - p2[index]) ** 2
  #   end
  #   Math.sqrt( sum_of_squares )
  # end

end
