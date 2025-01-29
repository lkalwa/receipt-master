# frozen_string_literal: true

# lib/item.rb
class Item
  attr_reader :name, :price, :quantity, :taxation

  def initialize(name, price, quantity, taxation)
    @name = name
    @price = price
    @quantity = quantity
    @taxation = taxation
  end

  def unit_price_with_tax
    price + calculate_tax
  end

  def total_price_with_tax
    quantity * unit_price_with_tax
  end

  def sales_tax
    quantity * calculate_tax
  end

  private

  def calculate_tax
    tax = price * taxation / 100.0
    # nearest 0.05
    (tax * 20).ceil / 20.0
  end
end

