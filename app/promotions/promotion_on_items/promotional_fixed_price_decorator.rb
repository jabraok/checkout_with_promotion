class PromotionalFixedPriceDecorator < SimpleDelegator
  def initialize(promotional_price:, item:)
    @promotional_price = promotional_price
    super(item)
  end

  def price
    @promotional_price
  end
end
