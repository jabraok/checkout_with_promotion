class PromotionOnTotal
  def promotional_on_total?
    true
  end

  def calculate_discount(pre_discount_total)
    raise 'Please implement calculate_discount method'
  end
end
