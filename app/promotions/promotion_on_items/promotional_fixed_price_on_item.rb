require_relative('promotion_on_item')
require_relative('promotional_fixed_price_decorator')

class PromotionalFixedPriceOnItem < PromotionOnItem
  attr_accessor :min_quantity, :promotional_price

  def initialize(code:, min_quantity:, promotional_price:)
    @min_quantity = min_quantity
    @promotional_price = promotional_price
    super(code: code)
  end

  protected

  def satisfy_promotion?(promotional_basket_item:)
    promotional_basket_item[:quantity] >= min_quantity
  end

  def add_promotional_decorator(promotional_basket_item:)
    promotional_basket_item[:item] = PromotionalFixedPriceDecorator.new(promotional_price: @promotional_price, item: promotional_basket_item[:item])
    promotional_basket_item
  end
end
