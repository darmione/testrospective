require_relative "solution"

RSpec.describe Dog do

  let(:foxy) { Dog.new('Foxy', 'Pesho', false, 14) }
  let(:loxy) { Dog.new('Lassie', 'Jessie', true, 22) }

  context 'Dog has attributes' do
    describe '#name' do
      it "tells us Dog's name" do
        expect(foxy.name).to eq("Foxy")
      end
    end

    describe '#owner_name' do
      it "tells us whose Dog this is" do
        expect(foxy.owner).to eq("Pesho")
      end
    end

    describe '#bites' do
      it "tells if Dog bites" do
        expect(foxy.bites?).to eq(false)
      end
    end

    describe '#dog_years' do
      it "tells how old Dog is" do
        expect(foxy.dog_years).to eq(14)
      end
    end
  end

  describe '#owner=' do
    it "changes Dog's owner" do
      foxy.owner=("Radan")
      expect(foxy.owner).to eq("Radan")
    end
  end

  describe "#dog_years=" do
    it "changes Dog's years" do
      foxy.dog_years=(15)
      expect(foxy.dog_years).to eq(15)
    end
  end

  describe "#bark" do
    it "tells Dog to bark" do
      expect(foxy.bark).to eq("Bark! Bark!")
    end
  end

  describe "#bark!" do
    it "tells Dog to bark and makes it want to bite" do
      foxy.bark!
      expect(foxy.bark!).to eq("Bark! Bark!")
      expect(foxy.bites?).to eq(true)
    end
  end

  describe "#to_human_years" do
    it "tells how old Dog is in human years" do
      foxy.to_human_years
      expect(foxy.to_human_years).to eq(2)
      loxy.to_human_years
      expect(loxy.to_human_years).to eq(3)
    end
  end

  describe "#same_owner" do
    let(:roxy) { Dog.new('Lassie', 'Jessie', false, 22) }
    it "tells if Dog's owner is the same as other Dog's owner" do
      expect(foxy.same_owner?(loxy)).to eq(false)
      expect(roxy.same_owner?(loxy)).to eq(true)
    end
  end

  describe "#same_dog" do
    let(:roxy) { Dog.new('Lassie', 'Jessie', false, 22) }
    it "tells if Dog is the same as other Dog" do
      expect(foxy.==(loxy)).to eq(false)
      expect(roxy.==(loxy)).to eq(true)
    end
  end
end
