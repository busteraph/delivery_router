require 'delivery_router'
require 'customer'
require 'restaurant'
require 'rider'

describe DeliveryRouter do
  describe "#route" do
    before(:all) do
      @customers = [
        Customer.new(:id => 1, :x => 1, :y => 1),
        Customer.new(:id => 2, :x => 5, :y => 1),
        Customer.new(:id => 3, :x => 3, :y => 5),
      ]
      @restaurants = [
        Restaurant.new(:id => 3, :cooking_time => 15, :x => 0, :y => 0),
        Restaurant.new(:id => 4, :cooking_time => 35, :x => 5, :y => 5),
      ]
      @riders = [
        Rider.new(:id => 1, :speed => 10, :x => 2, :y => 0),
        Rider.new(:id => 2, :speed => 10, :x => 1, :y => 0),
      ]
      @delivery_router = DeliveryRouter.new(@restaurants, @customers, @riders)
    end

    context "given customer 1 orders from restaurant 3" do
      before(:all) do
        @delivery_router.add_order(:customer => 1, :restaurant => 3)
      end

      context "given customer 2 does not order anything" do
        before do
          @delivery_router.clear_orders(:customer => 2)
        end

        it "does not assign a route to rider 1" do
          route = @delivery_router.route(:rider => 1)
          expect(route).to be_empty
        end

        it "sends rider 2 to customer 1 through restaurant 3" do
          route = @delivery_router.route(:rider => 2)
          expect(route.length).to eql(2)
          expect(route[0]).to eql(3)
          expect(route[1]).to eql(1)
        end

        it "delights customer 1" do
          expect(@delivery_router.delivery_time(:customer => 1)).to be < 45
        end
      end

      context "given customer 2 orders from restaurant 4" do
        before(:all) do
          @delivery_router.add_order(:customer => 2, :restaurant => 4)
        end

        it "sends rider 1 to customer 2 through restaurant 4" do
          route = @delivery_router.route(:rider => 1)
          expect(route.length).to eql(2)
          expect(route[0]).to eql(4)
          expect(route[1]).to eql(2)
        end

        it "sends rider 2 to customer 1 through restaurant 3" do
          route = @delivery_router.route(:rider => 2)
          expect(route.length).to eql(2)
          expect(route[0]).to eql(3)
          expect(route[1]).to eql(1)
        end

        it "delights customer 1" do
          expect(@delivery_router.delivery_time(:customer => 1)).to be < 45
        end

        it "delights customer 2" do
          expect(@delivery_router.delivery_time(:customer => 2)).to be < 45
        end
      end

      context "given customer 3 orders from restaurant 4" do
        before(:all) do
          @delivery_router.add_order(:customer => 3, :restaurant => 4)
        end

        it "sends rider 1 to customer 3 through restaurant 4" do
          route = @delivery_router.route(:rider => 1)
          expect(route.length).to eql(2)
          expect(route[0]).to eql(4)
          expect(route[1]).to eql(3)
        end

        it "delights customer 3" do
          expect(@delivery_router.delivery_time(:customer => 3)).to be < 45
        end
      end
    end

    context "no customer orders from restaurant" do
      before(:all) do
        @delivery_router.clear_orders()
      end

      it "does not assign a route to rider 1" do
        route = @delivery_router.route(:rider => 1)
        expect(route).to be_empty
      end

      it "does not assign a route to rider 2" do
        route = @delivery_router.route(:rider => 2)
        expect(route).to be_empty
      end
    end
  end

  describe '#euclidean_distance' do
    it 'test distance between 2 points with 2 dimensions' do
      expect(DeliveryRouter.new(1,2,3).euclidean_distance([2,1], [3,4])).to be_within(0.001).of(3.162)
    end

  end

end
