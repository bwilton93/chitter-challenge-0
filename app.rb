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
    repo = PeepRepo.new
    @peeps = repo.all
    return erb(:index)
  end

  post "/" do
    repo = PeepRepo.new
    new_peep = Peep.new
    new_peep.content = params[:peep]
    new_peep.date = DateTime.now.strftime "%Y/%m/%d"
    new_peep.time = DateTime.now.strftime "%H:%M:%S"
    repo.create(new_peep)

    @peeps = repo.all
    return erb(:index)
  end
end
