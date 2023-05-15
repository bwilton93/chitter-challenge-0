require 'date'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_repo'
require_relative 'lib/database_connection'
require_relative 'lib/peep_repo'

DatabaseConnection.connect('chitter')

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
    session[:user_id] = UserRepo.new.log_in(params[:login_name], params[:password])

    return erb(:login) if session[:user_id].nil?
    show_peeps
  end

  get "/logout" do
    session[:user_id] = nil
    show_peeps
  end

  get "/signup" do
    return erb(:signup)
  end

  post "/signup" do
    repo = UserRepo.new
    new_user = User.new

    new_user.display_name = params[:name]
    new_user.username = params[:name]
    new_user.email = params[:email]
    new_user.password = params[:password]

    return erb(:signup) if !repo.create(new_user)
    
    user = repo.find_record(new_user.email)
    session[:user_id] = user.id

    @session_id = session[:user_id]
    show_peeps
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
    peep.author_id = session[:user_id]
    return peep
  end

  def show_peeps
    @session_id = session[:user_id]
    @peeps = return_all_peeps
    return erb(:index)
  end
end
