# frozen_string_literal: true

# lib/receipt.rb
class Receipt
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def print_receipt
    total_sales_tax = items.sum(&:sales_tax)
    total_price = items.sum(&:total_price_with_tax)

    items.each do |item|
      puts format_item(item)
    end

    puts "Sales Taxes: #{format('%.2f', total_sales_tax)}"
    puts "Total: #{format('%.2f' % total_price)}"
  end

  def format_item(item)
    "#{item.quantity} #{item.name}: #{format('%.2f', item.total_price_with_tax)}"
  end
end

