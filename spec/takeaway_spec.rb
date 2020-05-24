require 'takeaway'
require 'menu'

describe Takeaway do
  let(:menu) { double :menu }
  let(:order) { double :order }
  subject(:takeaway) { described_class.new(menu, order) }
  let(:list) { ["marinara - £5", "margherita - £6", "napoli - £6", "calzone - £8"] }

  it 'uses the class menu, show_menu method, to make the user visualise dishes in a menu format' do
    allow(menu).to receive(:show_menu).and_return(list)
    expect(subject.visualise_menu).to eq(["marinara - £5", "margherita - £6", "napoli - £6", "calzone - £8"])
  end

  context 'add order' do
    it 'interacts with Order class to add dishes to the current order and return message' do
      allow(menu).to receive(:dishes).and_return({ "marinara" => 5, "margherita" => 6, "napoli" => 6, "calzone" => 8 })
      allow(order).to receive(:add_dish).and_return({ "marinara" => 2 })
      expect(subject.add_to_order("marinara", 2)).to eq("marinara X 2 added to your order")
    end
    it 'raise an error if the dish is not in the dish list' do
      allow(menu).to receive(:dishes).and_return({ "marinara" => 5, "margherita" => 6, "napoli" => 6, "calzone" => 8 })
      expect { subject.add_to_order("prosciutto") }.to raise_error("item not available")
    end
  end

  

end
