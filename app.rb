require 'date'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_repo'
require_relative 'lib/database_connection'
require_relative 'lib/peep_repo'

DatabaseConnection.connect('chitter_test')

class Application < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end
  
  get "/" do
    show_peeps
  end

  post "/" do
    if session[:user_id].nil?
      @login_message = "Please log in to post a peep!"
      return erb(:login)
    end

    PeepRepo.new.create(new_peep)
    show_peeps
  end

  get "/login" do
    return erb(:login)
  end

  post "/login" do
    login_name = params[:login_name]
    password = params[:password]

    user = UserRepo.new.find_record(login_name)

    if UserRepo.new.check(login_name, login_name) && user.password == password
      session[:user_id] = user.id
      show_peeps
    else
      return erb(:login)
    end
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

  def show_peeps
    @peeps = return_all_peeps
    return erb(:index)
  end
end
