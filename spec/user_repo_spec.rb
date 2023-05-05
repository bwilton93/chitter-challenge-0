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
  
  context 'creating a new user' do
    it 'succeeds when the username and email are unique' do
      user = double(:user, display_name: 'User 3', username: 'user3', password: 'fake_password3', email: 'fake_email3@email.com')
      repo = UserRepo.new
      
      repo.create(user)

      users = repo.all
      expect(users.length).to eq 3
      expect(users.first.display_name).to eq 'User 1'
      expect(users.last.display_name).to eq 'User 3'
    end
    
    # it 'fails when email is not unique' do
    #   user = double(:user, display_name: 'User 3', username: 'user3', password: 'fake_password3', email: 'fake_email2@email.com')
    #   repo = UserRepo.new
      
    #   repo.create(user)

    #   expect(users.length).to eq 2
    #   expect(users.first.display_name).to eq 'User 1'
    #   expect(users.last.display_name).to eq 'User 2'
    # end
    
    # it 'fails when username is not unique' do
    #   user = double(:user, display_name: 'User 3', username: 'user2', password: 'fake_password3', email: 'fake_email3@email.com')
    #   repo = UserRepo.new
      
    #   repo.create(user)

    #   expect(users.length).to eq 2
    #   expect(users.first.display_name).to eq 'User 1'
    #   expect(users.last.display_name).to eq 'User 2'
    # end
  end
end
