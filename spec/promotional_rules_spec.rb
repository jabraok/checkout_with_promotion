require_relative 'spec_helper'

describe 'Promotional rules' do
  it 'should discount 10% on total if spend over £60' do
    checkout = Checkout.new([promotional_percentage_on_total])
    checkout.scan Item.new('003', 'Kids T-shirt', 70)
    expect(checkout.total).to eq(63)
  end
end
