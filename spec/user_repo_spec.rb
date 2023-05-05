require 'user_repo'

RSpec.describe UserRepo do
  before(:each) do
    reset_test_tables
  end

  it 'can fetch all the user accounts' do
    repo = UserRepo.new

    users = repo.all
    expect(users.length).to eq 2
    expect(users.first.display_name).to eq 'User 1'
    expect(users.last.display_name).to eq 'User 2'
  end
end
