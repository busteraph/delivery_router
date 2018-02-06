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
    last_order = orders.last
    customer = customers.map { |c| c if c.id == last_order.customer }.compact.first
    restaurant = restaurants.map { |rest| rest if rest.id == last_order.restaurant }.compact.first
    # route_distance[o] = euclidean_distance([rider.x, rider.y], [restaurant.x, restaurant.y])
    #                      + euclidean_distance([restaurant.x, restaurant.y], [customer.x, customer.y])
    # route_distance.sort_by { |o, distance| distance }
    # order, dist = route_distance.first

    [last_order.restaurant, last_order.customer]
  end

  def delivery_time(p)# p[:customer]
    o = customer_order_to_deliver(p)
    restaurants.map { |r| r if r.id == o.restaurant }.compact.first.cooking_time  # + euclidean_distance / o.rider.speed 
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
