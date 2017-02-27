require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/restaurant_bill'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

describe "RestaurantBill" do
  before do
    @my_bill = RestaurantBill.new
  end

  it "New instance of bill is created with an empty ordered_items" do
    @my_bill.must_be_instance_of RestaurantBill
    @my_bill.ordered_items.must_be_instance_of Array
    @my_bill.ordered_items.empty?.must_equal true
  end

  # Test the method order_item, it should expect that ordered_items includes the new item.
  it "Array of [item, cost] is shoveled into the ordered_items when called" do
      proc {
        @my_bill.order_item(222, "Invalid")
      }.must_raise ArgumentError

      proc {
        @my_bill.order_item(222, 222)
      }.must_raise ArgumentError



      @my_bill.order_item("Pizza", 500)
      @my_bill.order_item("Donut", 200)
      @my_bill.order_item("Wine", 700)
      @my_bill.order_item("Discount", -500)
      @my_bill.ordered_items.each do |item_cost_pair|
        item_cost_pair.must_be_instance_of Array
        item_cost_pair.length.must_equal 2
      end
      @my_bill.total_with_tax
      @my_bill.total.must_equal 900

    end

    it "Returns Total bill with tax" do
      @my_bill.order_item("Pizza", 500)
      @my_bill.order_item("Donut", 200)
      @my_bill.order_item("Wine", 700)
      @my_bill.total_with_tax.must_equal (1400 + 1400 * 0.1)
    end

    it "Returns Total bill with tip" do
      @my_bill.order_item("Pizza", 500)
      @my_bill.order_item("Donut", 200)
      @my_bill.order_item("Wine", 700)
      @my_bill.tip.must_equal 0
      @my_bill.add_tip(500)
      @my_bill.tip.must_equal 500
      proc {
        @my_bill.add_tip(-500)
      }.must_raise ArgumentError
    end

    it "Returns Total bill with tip and tax" do
      @my_bill.order_item("Pizza", 500)
      @my_bill.order_item("Donut", 200)
      @my_bill.order_item("Wine", 700)
      @my_bill.grand_total.must_equal (@my_bill.total + @my_bill.tip + @my_bill.total * 0.1)
    end



end

# Test that if the order_item method is called 3 times, there are 3 elements in the ordered_items array.
