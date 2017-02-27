class RestaurantBill
  attr_reader :ordered_items, :total

  def initialize
    @ordered_items = []
    @total
    @tip
  end

  def order_item(item, cost)
    @ordered_items << [item, cost]
  end

  def item_total
    total =  0
    @ordered_items.each do |item|
      total += item[1]
    end

    total_with_tax = add_tax(total)
  end

  def add_tax(price)
    tax = price * 0.057
    total = price + tax
    @total = (total * 100).round / 100.0
  end

  def add_tip(tip)
    @tip = tip
    @total += tip
  end

end
