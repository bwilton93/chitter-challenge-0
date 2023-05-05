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
    expect(peeps.first.date).to eq '2023-01-03'
    expect(peeps.first.time).to eq '09:11:00'
    expect(peeps.first.author_id).to eq 1
    expect(peeps.last.content).to eq 'This is yet another peep'
    expect(peeps.last.date).to eq '2023-05-04'
    expect(peeps.last.time).to eq '17:11:00'
    expect(peeps.last.author_id).to eq 1
  end
end
