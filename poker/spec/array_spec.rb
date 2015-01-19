require 'rspec'
require 'array.rb'


describe "#my_uniq" do
  let(:array1) { [1, 2, 4, 2] }


  it "returns array of unique elements" do
    expect(array1.my_uniq).to eq([1,2,4])
  end

  it "doesn't alter original array" do
    array1.my_uniq
    expect(array1).to eq([1,2,4,2])
  end
end

describe "#two_sum" do
  let(:array1) { [1, 2, -1, 0, 4, 1] }


  it "returns empty array if no pairs found" do
    expect([1,2,3].two_sum).to eq([])
  end

  it "returns ordered array of pairs positions" do
    expect(array1.two_sum).to eq([ [0,2], [2,5] ])
  end

end

describe "#my_transpose" do
  let(:matrix1) {[
                  [0, 1, 2],
                  [3, 4, 5],
                  [6, 7, 8]]}
  it "converts the rows into columns" do
    expect(matrix1.my_transpose).to eq([[0, 3, 6],[1, 4, 7],[2, 5, 8]])
  end

end

describe "#stockpicker" do
  it "returns a pair of best days" do
    expect([1, 2, 4, 2, 10].stockpicker).to eq([0, 4])
  end

  it "returns nil when there is no profitable pair" do
    expect([5, 4, 3, 2, 1].stockpicker).to eq(nil)
  end
end
