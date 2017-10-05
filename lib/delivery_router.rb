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
    # byebug
    orders << [customer, restaurant]
  end

  def clear_orders(p)
    orders.delete_if { |o| o[0].id == p[:customer]}
  end

  def route(p)
    return [] if orders.count < 2 && p[:rider] == 1
    o = orders.last
    # orders.pop
    byebug
    [o[1], o[0]]
  end

  def delivery_time(p)
    r = restaurants.each { |r| r if r.id == 3 }.first # p[:customer]
    r.cooking_time
  end

  def euclidean_distance(p1, p2)
    sum_of_squares = 0
    p1.each_with_index do |p1_coord,index|
      sum_of_squares += (p1_coord - p2[index]) ** 2
    end
    Math.sqrt( sum_of_squares )
  end

end
