require 'date'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/peep_repo'

DatabaseConnection.connect('chitter_test')

class Application < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end
  
  get "/" do
    @peeps = return_all_peeps
    return erb(:index)
  end

  post "/" do
    # if session[:user_id].nil?
    #   return erb(:login)
    # end

    PeepRepo.new.create(new_peep)
    @peeps = return_all_peeps
    return erb(:index)
  end

  get "/login" do
    return erb(:login)
  end

  get "/signup" do
    return erb(:signup)
  end
  
  private
  
  def return_all_peeps
    repo = PeepRepo.new
    peeps = repo.all
    return peeps
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
