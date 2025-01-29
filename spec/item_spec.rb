# spec/item_spec.rb
require 'item'

describe Item do
  describe '#unit_price_with_tax' do
    it 'calculates the unit price including tax' do
      item = Item.new('book', 12.49, 1, 10)
      expect(item.unit_price_with_tax).to eq(13.74)
    end
  end

  describe '#total_price_with_tax' do
    it 'calculates the total price including tax for multiple quantities' do
      item = Item.new('book', 12.49, 2, 10)
      expect(item.total_price_with_tax).to eq(27.48)
    end
  end

  describe '#sales_tax' do
    it 'calculates the sales tax for the item' do
      item = Item.new('book', 12.49, 1, 10)
      expect(item.sales_tax).to eq(1.25)
    end
  end
end
