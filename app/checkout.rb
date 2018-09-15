class Checkout
  attr_reader :promotional_rules

  def initialize(promotional_rules:)
    @promotional_builder = PromotionalBuilder.new(promotional_rules: promotional_rules)

    # Item array of hash: { item: item, quantity: 2 }
    @basket_item_list = []
  end

  def scan(item)
    existing_item = find_by_code(item.code)
    if existing_item
      existing_item[:quantity] += 1
    else
      @basket_item_list << { item: item, quantity: 1 }
    end
  end

  def total
    @promotional_builder.calculate_total(basket_item_list: @basket_item_list)
  end

  private

  def find_by_code(code)
    @basket_item_list.detect { |basket_item| basket_item[:item].code == code }
  end
end
