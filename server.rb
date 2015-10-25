require 'rubygems'
require 'sinatra'
require 'json'
require 'linkedin_scraper'
require 'pry'
require 'rack/cors'

set :server, 'webrick'

use Rack::Cors do |config|
  config.allow do |allow|
    allow.origins '*'
    allow.resource '/linkedin/*', :headers => :any, :methods => [:get, :post]
  end
end

get "/" do
  File.read(File.join('public', 'index.html'))
end

post '/linkedin/:username' do
  @username = params[:username]
  @resume = ::Linkedin::Profile.get_profile("https://www.linkedin.com/in/#{@username}")
  content_type :json

  if @resume
    status 200
    @resume.to_json
  else
    status 400
    { result: 'error', message: "Please enter a valid LinkedIn username" }.to_json
  end
end

get '/linkedin/:username' do
  @username = params[:username]
  @resume = ::Linkedin::Profile.get_profile("https://www.linkedin.com/in/#{@username}")
  content_type :json

  if @resume
    status 200
    @resume.to_json
  else
    status 400
    { result: 'error', message: "Please enter a valid LinkedIn username" }.to_json
  end
end
