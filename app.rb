require 'date'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/peep_repo'

DatabaseConnection.connect('chitter_test')

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end
  
  get "/" do
    return_all_peeps
  end

  post "/" do
    PeepRepo.new.create(new_peep)
    return_all_peeps
  end
  
  private
  
  def return_all_peeps
    repo = PeepRepo.new
    @peeps = repo.all
    return erb(:index)
  end

  def new_peep
    peep = Peep.new
    peep.content = params[:peep]
    peep.date = DateTime.now.strftime "%Y/%m/%d"
    peep.time = DateTime.now.strftime "%H:%M:%S"
    peep.author_id = 1
    return peep
  end
end
