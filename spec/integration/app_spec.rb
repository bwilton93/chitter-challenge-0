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
      expect(response.body).to include '<h1>Log in to Chitter!</h1>'
      expect(response.body).to include '<form'
      expect(response.body).to include '<input type="text" placeholder="Enter username or email" required="required" name="login_name">'
      expect(response.body).to include '<input type="password" placeholder="Password" required="required" name="password">'
      expect(response.body).to include '<input type="submit" value="Log in!">'
    end

    it 'posts a new chitter to the homepage when logged in' do
      response = post(
        '/login',
        login_name: 'user1',
        password: 'fake_password'
      )
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
      expect(response.body).to include '<input type="text" placeholder="Enter username or email" required="required" name="login_name">'
      expect(response.body).to include '<input type="password" placeholder="Password" required="required" name="password">'
      expect(response.body).to include '<input type="submit" value="Log in!">'
    end
  end

  context 'POST /login' do
    context 'logs in' do
      it 'with correct username' do
        response = post(
          '/login',
          login_name: 'user1',
          password: 'fake_password'
        )

        expect(response.status).to eq 200
        expect(response.body).to include '<h1>Chitter</h1>'
      end

      it 'with correct email' do
        response = post(
          '/login',
          login_name: 'fake_email@email.com',
          password: 'fake_password'
        )

        expect(response.status).to eq 200
        expect(response.body).to include '<h1>Chitter</h1>'
      end
    end

    context 'fails to log in' do
      it 'with incorrect username' do
        response = post(
          '/login',
          login_name: 'user3',
          password: 'fake_password'
        )

        expect(response.status).to eq 200
        expect(response.body).to include '<h1>Log in to Chitter!</h1>'
      end

      it 'with incorrect email' do
        response = post(
          '/login',
          login_name: 'fake_email3@email.com',
          password: 'fake_password'
        )

        expect(response.status).to eq 200
        expect(response.body).to include '<h1>Log in to Chitter!</h1>'
      end

      it 'with incorrect password' do
        response = post(
          '/login',
          login_name: 'fake_email@email.com',
          password: 'fake_password2'
        )

        expect(response.status).to eq 200
        expect(response.body).to include '<h1>Log in to Chitter!</h1>'
      end
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
      expect(response.body).to include '<input type="password" placeholder="Password" required="required" name="password">'
      expect(response.body).to include '<input type="submit" value="Sign up!">'
    end
  end
end
