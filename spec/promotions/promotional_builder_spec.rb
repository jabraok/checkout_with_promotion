require_relative '../spec_helper'

describe 'Promotional builder' do
  let(:promotional_percentage_on_total) do
    PromotionalPercentageOnTotal.new(min_total: 60, discount_percent: 10)
  end

  let(:promotional_fixed_price_on_item) do
    PromotionalFixedPriceOnItem.new(code: '001', min_quantity: 2, promotional_price: 8.5)
  end

  let(:lavender_heart) do
    Item.new(code: '001', name: 'Lavender heart', price: 9.25)
  end

  let(:personalised_cufflink) do
    Item.new(code: '002', name: 'Personalised cufflinks', price: 45)
  end

  let(:item_with_price_60) do
    Item.new(code: '004', name: 'Item with custom price', price: 60)
  end

  describe 'discount percentage on total' do
    let(:promotional_builder) do
      PromotionalBuilder.new(promotional_rules: [promotional_percentage_on_total])
    end

    it 'discount if spend over min_total' do
      basket_item_list = [
        { item: lavender_heart, quantity: 2 },
        { item: personalised_cufflink, quantity: 1 }
      ]

      total = promotional_builder.calculate_total(basket_item_list: basket_item_list)

      expect(total).to eq(57.15)
    end

    it 'not discount if spend less than min_total' do
      basket_item_list = [{ item: lavender_heart, quantity: 5 }]
      total = promotional_builder.calculate_total(basket_item_list: basket_item_list)

      expect(total).to eq(46.25)
    end

    it 'not discount if spend equal to min_total' do
      basket_item_list = [{ item: item_with_price_60, quantity: 1 }]
      total = promotional_builder.calculate_total(basket_item_list: basket_item_list)

      expect(total).to eq(60)
    end
  end

  describe 'promote fixed price on item' do
    let(:promotional_builder) do
      PromotionalBuilder.new(promotional_rules: [promotional_fixed_price_on_item])
    end

    it 'discount if buy promotional items more than min_quantity' do
      basket_item_list = [
        { item: lavender_heart, quantity: 3 },
        { item: personalised_cufflink, quantity: 1 }
      ]

      total = promotional_builder.calculate_total(basket_item_list: basket_item_list)

      expect(total).to eq(70.5)
    end

    it 'discount if buy promotional items equal to min_quantity' do
      basket_item_list = [
        { item: lavender_heart, quantity: 2 },
        { item: personalised_cufflink, quantity: 1 }
      ]

      total = promotional_builder.calculate_total(basket_item_list: basket_item_list)

      expect(total).to eq(62)
    end

    it 'not discount if buy promotional items less than min_quantity' do
      basket_item_list = [
        { item: lavender_heart, quantity: 1 },
        { item: personalised_cufflink, quantity: 1 }
      ]

      total = promotional_builder.calculate_total(basket_item_list: basket_item_list)

      expect(total).to eq(54.25)
    end
  end
end
