require_relative('promotion_on_item')
class PromotionalFixedPriceOnItem < PromotionOnItem
  # attr_accessor :min_total, :discount_percent

  # def initialize(min_total:, discount_percent:)
  #   @min_total = min_total
  #   @discount_percent = discount_percent
  # end

  # def calculate_discount(pre_discount_total)
  #   return 0 unless pre_discount_total > @min_total
  #   (pre_discount_total * @discount_percent / 100).round(2)
  # end
end