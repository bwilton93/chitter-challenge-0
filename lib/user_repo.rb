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

  private 

  def user(record)
    user = User.new

    user.display_name = record['display_name']
    user.username = record['username']

    return user
  end
end
