# frozen_string_literal: true

require_relative 'tax_categories'
require_relative 'item'

require 'bigdecimal'

# lib/user_prompt.rb
class UserPrompt
  attr_accessor :tax_categories, :items

  def initialize
    @tax_categories = TaxCategories.new(TAX_CATEGORIES_PATH)
    @items = []
  end

  def collect_items
    puts "Enter your items (format: quantity (imported) name at price), type 'done' when finished:"
    loop do
      line = gets.chomp.strip
      return if line.downcase == 'done'

      if line =~ /^(\d+)\s+(imported\s+)?(.+) at (\d+\.\d{2})$/
        quantity = ::Regexp.last_match(1).to_i
        imported = ::Regexp.last_match(2) ? true : false
        name = ::Regexp.last_match(3)&.strip
        price = BigDecimal(::Regexp.last_match(4).to_f.to_s)
      else
        puts "Invalid format. Please use 'quantity (imported) name at price'."
      end

      ask_about_unknown_category(name) unless tax_categories.known_category?(name)
      items << Item.new("#{imported ? 'imported' : ''} #{name}", price, quantity, tax_categories.taxation(name, imported:))
    end
  end

  private

  def ask_about_unknown_category(name)
    puts "\nUnrecognized category for '#{name}'. Please specify if it's taxable: (yes/no; default yes)"
    msg = gets.chomp.downcase.strip
    if msg == 'no'
      tax_categories.add_exempt(name)
    else
      tax_categories.add_taxable(name)
    end
  end
end





