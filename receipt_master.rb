# frozen_string_literal: true

require_relative 'lib/item'
require_relative 'lib/receipt'
require_relative 'lib/tax_categories'
require_relative 'lib/user_prompt'

# statics
TAX_CATEGORIES_PATH = 'data/tax_categories.yml'

user_prompt = UserPrompt.new
user_prompt.collect_items

items = user_prompt.items
if items.any?
  receipt = Receipt.new(items)
  receipt.print_receipt
else
  puts "No items entered."
end
