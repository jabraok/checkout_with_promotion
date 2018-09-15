class PromotionOnItem
  attr_accessor :code
  include Cloneable

  def initialize(code:)
    @code = code
  end

  def promotional_on_item?
    true
  end

  # basket_item_list: Item array of hash { item: item, quantity: 2 }
  def apply_discount(basket_item_list:)
    promotional_basket_item = fetch_promotional_item(basket_item_list: basket_item_list)
    return basket_item_list unless promotional_basket_item && satisfy_promotion?(promotional_basket_item: promotional_basket_item)

    apply_discount_for_list(basket_item_list: basket_item_list)
  end

  protected

  def satisfy_promotion?(promotional_basket_item:)
    raise 'Please implement satisfy_promotion? method'
  end

  def add_promotional_decorator(promotional_basket_item)
    raise 'Please implement add_promotional_decorator method'
  end

  private

  def fetch_promotional_item(basket_item_list:)
    basket_item_list.detect { |basket_item| basket_item[:item].code == @code }
  end

  def apply_discount_for_list(basket_item_list:)
    promotional_basket_item_list = clone_object(basket_item_list)
    promotional_basket_item = fetch_promotional_item(basket_item_list: promotional_basket_item_list)

    # Delete current promotional from list
    promotional_basket_item_list.delete(promotional_basket_item)

    promotional_basket_item_list << add_promotional_decorator(promotional_basket_item: promotional_basket_item)
  end
end
