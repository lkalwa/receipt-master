# spec/receipt_spec.rb
require 'receipt'
require 'item'

describe Receipt do
  describe '#print_receipt' do
    let(:item1) { Item.new('bottle of perfume', 27.99, 1, 15.0) }
    let(:item2) { Item.new('bottle of perfume', 18.99, 1, 10.0) }
    let(:item3) { Item.new('headache pills', 9.75, 1, 0) }
    let(:item4) { Item.new('imported boxes of chocolates', 11.25, 3, 5.0) }
    let(:items) { [item1, item2, item3, item4] }
    let(:receipt) { Receipt.new(items) }

    before do
      @output = StringIO.new
      allow($stdout).to receive(:puts) { |msg| @output.puts(msg) }
    end

    it 'prints the correct itemized receipt' do
      receipt.print_receipt

      expected_output = <<~OUTPUT.chomp
        1 bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 headache pills: 9.75
        3 imported boxes of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
      OUTPUT

      expect(@output.string.strip).to eq(expected_output)
    end

    it 'calculates total sales tax correctly' do
      receipt.print_receipt

      expect(receipt.items.sum(&:sales_tax)).to eq(7.90)
    end

    it 'calculates total price correctly' do
      receipt.print_receipt

      expect(receipt.items.sum(&:total_price_with_tax)).to eq(98.38)
    end
  end
end
