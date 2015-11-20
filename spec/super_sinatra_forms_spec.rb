describe App do

  describe 'GET /' do
    before do 
      get '/'
    end

    it 'sends a 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it 'renders super hero form' do 
      expect(last_response.body).to include("Create a Team and Heroes!")
      expect(last_response.body).to include("<form")
    end
  end

  describe 'POST /teams' do
    it 'submits the form' do
      visit '/'
      fill_in("team[name]", :with => "Team Ruby")
      fill_in("team[motto]", :with => "We love Ruby!")
      fill_in("team[members][0][name]", :with => "Amanda")
      fill_in("team[members][0][power]", :with => "Ruby")
      fill_in("team[members][0][bio]", :with => "I love Ruby!")
      fill_in("team[members][1][name]", :with => "Arel")
      fill_in("team[members][1][power]", :with => "JavaScript")
      fill_in("team[members][1][bio]", :with => "I love JavaScript!")
      fill_in("team[members][2][name]", :with => "Katie")
      fill_in("team[members][2][power]", :with => "Sinatra")
      fill_in("team[members][2][bio]", :with => "I love Sinatra!")
      click_button 'submit'

      expect(page).to have_text("Team Ruby")
      expect(page).to have_text("Team Motto: We love Ruby!")
      expect(page).to have_text("Hero Name: Amanda")
      expect(page).to have_text("Hero power: Ruby")
      expect(page).to have_text("Hero biography: I love Ruby!")
      expect(page).to have_text("Hero Name: Arel")
      expect(page).to have_text("Hero power: JavaScript")
      expect(page).to have_text("Hero biography: I love JavaScript!")
      expect(page).to have_text("Hero Name: Katie")
      expect(page).to have_text("Hero power: Sinatra")
      expect(page).to have_text("Hero biography: I love Sinatra!")
    end
  end
  
end