# frozen_string_literal: true

require 'yaml'

# lib/tax_categories.rb
class TaxCategories
  TAX_RATES = { taxable: 10.0, imported: 5.0 }.freeze

  attr_accessor :categories, :file_path

  def initialize(file_path)
    @file_path = file_path
    @categories = YAML.load_file(file_path).transform_keys(&:to_sym)
  end

  def known_category?(name)
    categories.values.flatten.include?(name.downcase)
  end

  def taxation(name, imported: false)
    tax = 0.0
    tax += TAX_RATES[:taxable] unless exempt?(name)
    tax += TAX_RATES[:imported] if imported
    tax
  end

  %i[exempt taxable].each do |category|
    define_method("add_#{category}") do |name|
      categories[category] << name.downcase
      update
    end
  end

  private

  def exempt?(name)
    categories[:exempt].include?(name)
  end

  def update
    File.open(file_path, 'w') do |file|
      file.write(categories.to_yaml)
    end
  end
end

