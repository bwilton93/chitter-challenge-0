require 'peep_repo'

RSpec.describe PeepRepo do
  before(:each) do
    reset_test_tables
  end

  it "returns a list of all peeps" do
    repo = PeepRepo.new

    peeps = repo.all
    expect(peeps.length).to eq 3
    expect(peeps.first.content).to eq 'This is a peep'
    expect(peeps.last.content).to eq 'This is yet another peep'
  end
end
