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
    it 'returns the login page when user is not logged in' do
      response = post(
        '/',
        peep: 'Not logged in'
      )

      expect(response.status).to eq 200
      expect(response.body).to include 'Please log in to post a peep!'
      expect(response.body).to include '<h1>Log in to Chitter!</h1>'
      expect(response.body).to include '<form'
      expect(response.body).to include '<input type="text" placeholder="Name" required="required" name="name">'
      expect(response.body).to include '<input type="text" placeholder="Email" required="required" name="email">'
      expect(response.body).to include '<input type="text" placeholder="Password" required="required" name="password">'
      expect(response.body).to include '<input type="submit" value="Log in!">'
    end

    xit 'posts a new chitter to the homepage when logged in' do
      response = post(
        '/',
        peep: 'This is a new peep',
        )

      expect(response.status).to eq 200
      expect(response.body).to include 'This is a new peep'
    end
  end

  context 'GET /login' do
    it 'displays the login page' do
      response = get('/login')

      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Log in to Chitter!</h1>'
      expect(response.body).to include '<form'
      expect(response.body).to include '<input type="text" placeholder="Name" required="required" name="name">'
      expect(response.body).to include '<input type="text" placeholder="Email" required="required" name="email">'
      expect(response.body).to include '<input type="text" placeholder="Password" required="required" name="password">'
      expect(response.body).to include '<input type="submit" value="Log in!">'
    end
  end
  
  context 'GET /signup' do
    it 'displays the signup page' do
      response = get('/signup')
      
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Sign up for Chitter!</h1>'
      expect(response.body).to include '<form'
      expect(response.body).to include '<input type="text" placeholder="Name" required="required" name="name">'
      expect(response.body).to include '<input type="text" placeholder="Email" required="required" name="email">'
      expect(response.body).to include '<input type="text" placeholder="Password" required="required" name="password">'
      expect(response.body).to include '<input type="submit" value="Sign up!">'
    end
  end
end
