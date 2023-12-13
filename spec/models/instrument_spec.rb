require 'rails_helper'

RSpec.describe Instrument, type: :model do
    describe "a valid Instrument" do
        let(:instrument) { build(:instrument) }
        it "is valid with valid attributes" do
          expect(instrument).to be_valid
        end
        it "is not valid without a name" do
        instrument.name=nil
          expect(instrument).to_not be_valid
        end
        it "is not valid without a unique name" do
            second_instrument = create(:instrument)
            instrument.name=second_instrument.name
              expect(instrument).to_not be_valid
            end
      end
end
