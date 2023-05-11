require_relative 'user'

class UserRepo
  def all
    users = []

    sql = 'SELECT * FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      users << user(record)
    end

    return users
  end

  def create(user)
    return if check(user.username, user.email)
    params = [user.display_name, user.username, user.password, user.email]

    sql = 'INSERT INTO users (display_name, username, password, email)
          VALUES ($1, $2, $3, $4);'

    DatabaseConnection.exec_params(sql, params)
  end

  def check(username, email)
    params = [username, email]

    sql = 'SELECT * FROM users WHERE username=$1 OR email=$2;'

    result = DatabaseConnection.exec_params(sql, params)
    
    return !result.first.nil?
  end

  def find_record(input)
    sql = 'SELECT * FROM users WHERE username=$1 OR email=$1;'

    result = DatabaseConnection.exec_params(sql, [input])

    return user(result.first)
  end

  private 

  def user(record)
    user = User.new
    user.id = record['id'].to_i
    user.display_name = record['display_name']
    user.username = record['username']
    user.password = record['password']
    user.email = record['email']
    return user
  end
end
