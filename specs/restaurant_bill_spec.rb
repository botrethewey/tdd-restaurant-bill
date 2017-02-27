require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/restaurant_bill'


describe 'Test restaurant_bill' do

  it "Can create an instance of RestaurantBill" do
    bill = RestaurantBill.new

    bill.class.must_equal RestaurantBill
  end

  it "Bill initializes with no ordered items" do
    bill = RestaurantBill.new

    bill.ordered_items.must_be_empty
  end

  it "Bill has one item, after ordering" do
    bill = RestaurantBill.new
    bill.order_item("Waffles", 5)

    bill.ordered_items.length.must_equal 1
  end

  it "Bill has total cost of items, with tax" do
    bill = RestaurantBill.new
    bill.order_item("Waffles", 5)
    bill.order_item("Juice", 2)
    bill.order_item("Fruit", 4)

    bill.item_total.must_equal 11.63
  end
end
