require_relative 'peep'

class PeepRepo
  def all
    peeps = []
    sql = 'SELECT peeps.*, users.display_name, users.username 
          FROM peeps JOIN users ON peeps.author_id=users.id;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      peeps << peep(record)
    end
    
    return peeps.sort_by { |peep| peep.id }.reverse!
  end

  def create(peep)
    params = [peep.content, peep.date, peep.time, peep.author_id]
    sql = 'INSERT INTO peeps (content, date, time, author_id) VALUES ($1, $2, $3, $4)'

    DatabaseConnection.exec_params(sql, params)
  end
  
  private
  
  def peep(record)
    peep = Peep.new
    peep.id = record['id'].to_i
    peep.content = record['content']
    peep.date = record['date']
    peep.time = record['time']
    peep.author_id = record['author_id'].to_i

    return peep
  end
end
