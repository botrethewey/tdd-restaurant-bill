class RestaurantBill
  attr_reader :ordered_items, :tip, :total

  def initialize
    @ordered_items = []
    @tip = 0
    @total = 0
  end

  def order_item(item, cost)
   raise ArgumentError.new("You are using a invalid (item, cost) parameter value!") if !(item.class == String && cost.class == Integer)
    @ordered_items << [item, cost]
  end

  def total_with_tax
    total_with_tax = 0
    @ordered_items.each do |item_cost_pair|
      @total += item_cost_pair[1]
    end
    total_with_tax +=  @total + (@total * 0.1)
    return total_with_tax
  end

  def add_tip tip = 0
    raise ArgumentError.new("Must use positive value") if tip < 0
    @tip = tip
    return @total + @tip
  end

  def grand_total
    return total_with_tax + @tip
  end

end


# USE DELTA FOR COMPARING FLOAT VLUES!!
