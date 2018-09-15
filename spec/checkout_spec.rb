require_relative 'spec_helper'

describe 'Checkout' do
  let(:promotional_rules) do
    [
      PromotionalPercentageOnTotal.new(min_total: 60, discount_percent: 10),
      PromotionalFixedPriceOnItem.new(code: '001', min_quantity: 2, promotional_price: 8.5)
    ]
  end

  let(:checkout) do
    Checkout.new(promotional_rules: promotional_rules)
  end

  let(:lavender_heart) do
    Item.new(code: '001', name: 'Lavender heart', price: 9.25)
  end

  let(:personalised_cufflink) do
    Item.new(code: '002', name: 'Personalised cufflinks', price: 45)
  end

  let(:kids_t_shirt) do
    Item.new(code: '003', name: 'Kids T-shirt', price: 19.95)
  end

  it 'discount on total' do
    checkout.scan(lavender_heart)
    checkout.scan(personalised_cufflink)
    checkout.scan(kids_t_shirt)

    expect(checkout.total).to eq(66.78)
  end

  it 'discount on items' do
    checkout.scan(lavender_heart)
    checkout.scan(kids_t_shirt)
    checkout.scan(lavender_heart)

    expect(checkout.total).to eq(36.95)
  end

  it 'discount on total and items' do
    checkout.scan(lavender_heart)
    checkout.scan(personalised_cufflink)
    checkout.scan(lavender_heart)
    checkout.scan(kids_t_shirt)

    expect(checkout.total).to eq(73.76)
  end

  it 'no discount' do
    checkout.scan(lavender_heart)
    checkout.scan(personalised_cufflink)

    expect(checkout.total).to eq(54.25)
  end
end
