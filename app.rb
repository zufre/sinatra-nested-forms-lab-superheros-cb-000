require_relative 'config/environment'

class App < Sinatra::Base
  get '/' do
    erb :super_hero
  end

  post '/teams' do
    @team_name = params[:team][:name]
    @team_motto = params[:team][:motto]
    @hero_name = []
    @hero_power = []
    @hero_bio = []
    @team_members = params[:team][:members]
    @team_members.each do |hero, attrib|
      @hero_name << attrib[:name]
      @hero_power << attrib[:power]
      @hero_bio << attrib[:bio]
    end

    erb :team
  end
end