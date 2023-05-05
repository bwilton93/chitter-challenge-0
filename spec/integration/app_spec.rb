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
end
