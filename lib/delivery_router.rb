require 'byebug'
require 'order'

class DeliveryRouter
  attr_accessor :restaurants, :customers, :riders, :orders

  def initialize(restaurants, customers, riders)
    self.restaurants = restaurants
    self.customers = customers
    self.riders = riders
    self.orders = []
  end

  def add_order(p)
    o = Order.new(p)
    orders << o
  end

  def clear_orders(p=nil)
    orders.clear if p.nil?
    orders.delete_if { |o| o.id == p[:customer]}
  end

  def route(p)
    return [] if orders.count == 0
    return [] if orders.count < 2 && p[:rider] == 1

    rider = riders.map { |r| r if r.id == p[:rider] }.compact.first

    route_distance = {}

    orders.each do |o|
      customer = customers.map { |c| c if c.id == o.customer }.compact.first
      restaurant = restaurants.map { |r| r if r.id == o.restaurant }.compact.first
      route_distance[o] = euclidean_distance([rider.x, rider.y], [restaurant.x, restaurant.y])
                                      + euclidean_distance([rider.x, rider.y], [customer.x, customer.y])
    end
 
    route_distance.sort_by { |o, distance| distance }
    order, dist = route_distance.first

     [order.restaurant, order.customer]
  end

  def delivery_time(p)# p[:customer]
    o = customer_order_to_deliver(p)
    restaurants.map { |r| r if r.id == o.restaurant }.compact.first.cooking_time# + euclidean_distance / o.rider.speed 
  end

  def euclidean_distance(p1, p2)
    sum_of_squares = 0
    p1.each_with_index do |p1_coord, index|
      sum_of_squares += (p1_coord - p2[index]) ** 2
    end
    Math.sqrt( sum_of_squares )
  end

  def customer_order_to_deliver(c)
    o = orders.select { |o| o.customer if c[:customer] == o.customer}
    o.compact.first
  end

end
