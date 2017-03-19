require_relative 'test_task1'

describe '#cool_numbers' do
  it "adds 'st' to numbers ending with 1" do
    expect(cool_numbers(1)).to eq("1st")
    expect(cool_numbers(21)).to eq("21st")
    expect(cool_numbers(101)).to eq("101st")
  end

  it "adds 'nd' to numbers ending with 2" do
    expect(cool_numbers(2)).to eq("2nd")
    expect(cool_numbers(22)).to eq("22nd")
    expect(cool_numbers(102)).to eq("102nd")
  end

  it "adds 'rd' to numbers ending with 3" do
    expect(cool_numbers(3)).to eq("3rd")
    expect(cool_numbers(23)).to eq("23rd")
    expect(cool_numbers(103)).to eq("103rd")
  end

  it "adds 'th' to numbers 11, 12 and 13" do
    expect(cool_numbers(11)).to eq("11th")
    expect(cool_numbers(12)).to eq("12th")
    expect(cool_numbers(13)).to eq("13th")
  end

  it "adds correct suffix to negative numbers" do
    expect(cool_numbers(-1)).to eq("-1st")
    expect(cool_numbers(-11)).to eq("-11th")
    expect(cool_numbers(-100)).to eq("-100th")
    expect(cool_numbers(-22)).to eq("-22nd")
  end

  it "adds 'th' to 0" do
    expect(cool_numbers(0)).to eq("0th")
  end
end
