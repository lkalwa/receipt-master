# spec/tax_categories_spec.rb
require 'tax_categories'

describe TaxCategories do
  let(:categories_file) { 'spec/data/test_tax_categories.yml' }
  let(:tax_categories) { TaxCategories.new(categories_file) }

  before do
    # Create a test YAML file with known categories
    File.open(categories_file, 'w') do |file|
      file.write <<~YAML
        exempt:
          - book
          - food
        taxable:
          - music cd
          - perfume
      YAML
    end
  end

  after do
    File.delete(categories_file) if File.exist?(categories_file)
  end

  describe '#known_category?' do
    it 'returns true for a known exempt category' do
      expect(tax_categories.known_category?('book')).to be true
    end

    it 'returns true for a known taxable category' do
      expect(tax_categories.known_category?('music CD')).to be true
    end

    it 'returns false for an unknown category' do
      expect(tax_categories.known_category?('unknown item')).to be false
    end
  end

  describe '#taxation' do
    it 'calculates tax for taxable items' do
      expect(tax_categories.taxation('music cd')).to eq(10.0)
    end

    it 'calculates tax for imported taxable items' do
      expect(tax_categories.taxation('music cd', imported: true)).to eq(15.0)
    end

    it 'calculates no tax for exempt items' do
      expect(tax_categories.taxation('book')).to eq(0.0)
    end

    it 'calculates tax for imported exempt items' do
      expect(tax_categories.taxation('book', imported: true)).to eq(5.0)
    end
  end

  describe '#add_exempt and #add_taxable' do
    it 'adds a new exempt category' do
      tax_categories.add_exempt('new exempt item')
      expect(tax_categories.known_category?('new exempt item')).to be true
    end

    it 'adds a new taxable category' do
      tax_categories.add_taxable('new taxable item')
      expect(tax_categories.known_category?('new taxable item')).to be true
    end

    it 'updates the YAML file with new categories' do
      tax_categories.add_taxable('another taxable item')
      updated_tax_categories = TaxCategories.new(categories_file)
      expect(updated_tax_categories.known_category?('another taxable item')).to be true
    end
  end
end
