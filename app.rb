require_relative 'config/environment'

class App < Sinatra::Base
  get '/' do
    erb :"index.html"
  end

  get '/teams/new' do
    erb :"new_team.html"
  end

  post '/teams' do
    params["super_heros"] = params["super_heros"].map do |hero, attributes|
      SuperHero.create(attributes)
    end
    redirect to "teams/#{Team.create(params).id}"
  end

  get '/teams/:id' do
    @team = Team.find_by(id: params[:id])
    erb :"team.html"
  end
end