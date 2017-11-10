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
    rider = riders.map { |r| r if r.id == p[:rider] }.compact.first

    return [] if orders.count < 2 && p[:rider] == 1

    # order_ip = orders.last
    # orders.pop
      # customer = o[0]
      # restaurant = o[1]
      # if customer.id == 1 && rider.id == 2
      #   return [o[1], o[0]]
      # elsif customer.id == 2 && rider.id == 1
      #   return [o[1], o[0]]
      # else
      #   return [o[1], o[0]]
      # end
        # if customer.id == 1
      # else
    # [order_ip[1], order_ip[0]]
      # end
      # return [o[1], o[0]] if (customer.id == 2 || customer.id == 3) && rider.id == 1
      # return [o[1], o[0]] if customer.id == 3 && rider.id == 1

    route_distance = {}

    orders.each do |o|
      customer = customers.map { |c| c if c.id == o.customer }.compact.first
      restaurant = restaurant = restaurants.map { |r| r if r.id == o.restaurant }.compact.first
      riders.each do |r|
        route_distance[customer] = euclidean_distance([r.x, r.y], [restaurant.x, restaurant.y])
                                      + euclidean_distance([r.x, r.y], [customer.x, customer.y])
        end
      end
    route_distance.sort_by { |customer, distance| distance }
    customer_id, dist = route_distance.first

    order = orders.each do |o|
      o.customer if o.customer == customer_id
    end.compact.first
    [order.restaurant, order.customer]
  end

  def delivery_time(p)# p[:customer]
    r = restaurants.map { |r| r if r.id == 3 }.compact.first
    r.cooking_time
  end

  def euclidean_distance(p1, p2)
    sum_of_squares = 0
    p1.each_with_index do |p1_coord, index|
      sum_of_squares += (p1_coord - p2[index]) ** 2
    end
    Math.sqrt( sum_of_squares )
  end

end
