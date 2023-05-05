require_relative 'peep'

class PeepRepo
  def all
    peeps = []
    sql = 'SELECT * FROM peeps;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      peeps << new_peep(record)
    end
    
    return peeps.sort_by { |peep| peep.id }.reverse!
  end
  
  private
  
  def new_peep(record)
    peep = Peep.new
    peep.id = record['id'].to_i
    peep.content = record['content']
    peep.date = record['date']
    peep.time = record['time']
    peep.author_id = record['author_id'].to_i

    return peep
  end
end
