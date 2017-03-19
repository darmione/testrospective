require_relative 'patch_arrays'

RSpec.describe Array do

  describe '#to_hash' do
    it 'turns array into hash' do
      expect([[:one, 1], [:two, 2]].to_hash).to eq({:one => 1, :two => 2})
      expect([[1, 2], [3, 4]].to_hash).to eq({1 => 2, 3 => 4})
    end

    it 'turns empty array into empty hash' do
      expect([].to_hash).to eq({})
    end
  end

  describe '#index_by' do
    it 'turns array into hash with given block' do
      expect(['John Coltrane', 'Miles Davis'].index_by { |name| name.split(' ').last })
      .to eq({'Coltrane' => 'John Coltrane', 'Davis' => 'Miles Davis'})
      expect(%w[foo larodi bar].index_by { |s| s.length })
      .to eq({3 => 'bar', 6 => 'larodi'})
    end
  end

  describe '#subarray_count' do
    it 'counts how many times subarray is contained in the array' do
      expect([1, 2, 3, 2, 3, 1].subarray_count([2, 3])).to eq 2
      expect([1, 2, 2, 2, 2, 1].subarray_count([2, 2])).to eq 3
      expect([1, 1, 2, 2, 1, 1, 1].subarray_count([1, 1])).to eq 3
    end
  end

  describe '#occurences_count' do
    it 'returns hash with each element and count how many times it is contained in the array' do
      expect([:foo, :bar, :foo].occurences_count).to eq({:foo => 2, :bar => 1})
      expect(%w[a a b c b a].occurences_count).to eq({'a' => 3, 'b' => 2, 'c' => 1})
      expect([:a, :a, :b].occurences_count).to eq({:a => 2, :b => 1})
    end
  end
end
