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
    end
  end
end
