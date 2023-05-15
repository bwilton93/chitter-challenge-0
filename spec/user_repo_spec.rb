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

  context 'when checking for existing username and email' do
    it 'returns false if no entries found' do
      repo = UserRepo.new
      
      user = repo.check('user4', 'fake_email4@email.com')
      expect(user).to eq false
    end
    
    it 'returns true when some entries found' do
      repo = UserRepo.new
      
      user = repo.check('user1', 'fake_email2@email.com')
      expect(user).to eq true
    end
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
    
    it 'fails when email is not unique' do
      user = double(:user, display_name: 'User 3', username: 'user3', password: 'fake_password3', email: 'fake_email2@email.com')
      repo = UserRepo.new
      
      repo.create(user)

      users = repo.all
      expect(users.length).to eq 2
      expect(users.first.display_name).to eq 'User 1'
      expect(users.last.display_name).to eq 'User 2'
    end
    
    it 'fails when username is not unique' do
      user = double(:user, display_name: 'User 3', username: 'user2', password: 'fake_password3', email: 'fake_email3@email.com')
      repo = UserRepo.new
      
      repo.create(user)

      users = repo.all
      expect(users.length).to eq 2
      expect(users.first.display_name).to eq 'User 1'
      expect(users.last.display_name).to eq 'User 2'
    end
  end

  context 'logging in' do
    it 'returns false if the email doesnt exist' do
      repo = UserRepo.new
      email = 'email'
      password = 'wrong_password'
      result = repo.log_in(email, password)
      expect(result).to eq nil
    end

    it 'returns false if the username doesnt exist' do
      repo = UserRepo.new
      username = 'username'
      password = 'wrong_password'
      result = repo.log_in(username, password)
      expect(result).to eq nil
    end

    it 'returns user.id when the email and passwords match' do
      repo = UserRepo.new
      email = 'fake_email@email.com'
      password = 'fake_password'
      result = repo.log_in(email, password)
      expect(result).to eq 1
    end

    it 'returns the user.id when the username and passwords match' do
      repo = UserRepo.new
      username = 'user2'
      password = 'fake_password2'
      result = repo.log_in(username, password)
      expect(result).to eq 2
    end
  end
end
