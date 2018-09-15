class PromotionalBuilder
  attr_reader :promotional_rules

  def initialize(promotional_rules:)
    @promotional_rules = promotional_rules
  end

  # basket_item_list: Item array of hash { item: item, quantity: 2 }
  def calculate_total(basket_item_list:)
    basket_item_list = apply_discount_on_items(basket_item_list: basket_item_list) if promotional_on_item?

    total = get_total_of_list(basket_item_list: basket_item_list)

    # Apply discount on total rules
    discount = calculate_discount_on_total(total)
    (total - discount).round(2)
  end

  private

  def promotional_on_item?
    @promotional_on_item ||= promotional_rules.any? do |rule|
      rule.promotional_on_item? if rule.respond_to?('promotional_on_item?')
    end
  end

  def apply_discount_on_items(basket_item_list:)
    promotional_rules.each do |rule|
      next unless rule.respond_to?('promotional_on_item?')
      basket_item_list = rule.apply_discount(basket_item_list: basket_item_list)
    end

    basket_item_list
  end

  def promotional_on_total?
    @promotional_on_total ||= promotional_rules.any? do |rule|
      rule.promotional_on_total? if rule.respond_to?('promotional_on_total?')
    end
  end

  def calculate_discount_on_total(total)
    return 0 unless promotional_on_total?

    promotional_rules.inject(0) do |discount_total, rule|
      return discount_total unless rule.respond_to?('promotional_on_total?')
      discount_total + rule.calculate_discount(total)
    end
  end

  def get_total_of_list(basket_item_list: basket_item_list)
    basket_item_list.inject(0) do |total, basket_item|
      total + basket_item[:item].price * basket_item[:quantity]
    end
  end
end
