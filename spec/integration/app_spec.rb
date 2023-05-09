require 'spec_helper'
require 'rack/test'
require_relative '../../app'

RSpec.describe Application do
  before(:each) do
    reset_test_tables
  end

  include Rack::Test::Methods
  let(:app) { Application.new }

  context "GET /" do
    it "displays a reverse chronological list of all peeps" do
      response = get('/')

      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Chitter</h1>"
      expect(response.body).to include '<form action="/" method="POST">'
      expect(response.body).to include "This is yet another peep"
      expect(response.body).to include "This is another peep"
      expect(response.body).to include "This is a peep"
    end
  end

  context 'POST /' do
    it 'posts a new chitter to the homepage' do
      response = post(
        '/',
        peep: 'This is a new peep'
        )

      expect(response.status).to eq 200
      expect(response.body).to include 'This is a new peep'
    end
  end

  context 'GET /login' do
    it 'displays the login page' do
      response = get('/login')

      expect(response.status).to eq 200
      expect(response.body).to include '<form>'
      expect(response.body).to include '<input type="text"> name="name">'
      expect(response.body).to include '<input type="text"> name="email">'
      expect(response.body).to include '<input type="text"> name="password">'
      expect(response.body).to include '<input type="submit" value="Log in!">'
    end
  end
  
  context 'GET /signup' do
    it 'displays the login page' do
      response = get('/login')
      
      expect(response.status).to eq 200
      expect(response.body).to include '<form>'
      expect(response.body).to include '<input type="text"> name="name">'
      expect(response.body).to include '<input type="text"> name="email">'
      expect(response.body).to include '<input type="text"> name="password">'
      expect(response.body).to include '<input type="submit" value="Sign up!">'
    end
  end
end
