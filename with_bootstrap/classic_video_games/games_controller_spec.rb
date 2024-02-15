require 'rails_helper'
require 'json'

RSpec.describe GamesController, :type => :controller do
  render_views

  describe "GET #index" do
    # it "returns http success" do
    #   get "/"
    #   expect(response).to have_http_status(:success)
    # end

    it "should have a #games table" do
      get "/"
      expect(response.body).to have_css('table#games')
    end

    # it "should have appropriate table headers" do
    #   get :index
    #   expect(
    #     response.body
    #   ).to have_xpath('//*[@id="games"]//th[1]', text: /^\s*\bName\b\s*$/i)
    #   expect(
    #     response.body
    #   ).to have_xpath('//*[@id="games"]//th[2]', text: /^\s*\bYear\b\s*$/i)
    #   expect(
    #     response.body
    #   ).to have_xpath('//*[@id="games"]//th[3]', text: /^\s*\bPublisher\b\s*$/i)
    # end
    #
    # it "should page results" do
    #   get :index
    #   expect(
    #     response.body
    #   ).to have_xpath('//*[@id="games"]//tr/td', maximum: 10)
    # end
  end

  # describe "GET #show json" do
  #   let(:game) do
  #     g = Game.create!(name: 'Quux',
  #                      publication_year: 1972,
  #                      is_active: true)
  #     g.manufacturers.create!([{company: 'Win', region: 'JP'},
  #                              {company: 'AYB', region: 'US'}])
  #     g
  #   end
  #
  #   it "returns http success" do
  #     get :show, id: game, format: :json
  #     expect(response).to have_http_status(:success)
  #   end
  #
  #   it "returns the correct game as json" do
  #     get :show, id: game, format: :json
  #     v = JSON.parse(response.body)
  #     expect(v['id']).to be > (0)
  #     expect(v['name']).to eq(game.name)
  #     expect(v['publication_year']).to eq(game.publication_year)
  #     expect(v['is_active']).to eq(game.is_active)
  #     expect(
  #       v['manufacturers'][0]['company']
  #     ).to eq(game.manufacturers[0].company)
  #     expect(
  #       v['manufacturers'][0]['region']
  #     ).to eq(game.manufacturers[0].region)
  #     expect(
  #       v['manufacturers'][0]['game_id']
  #     ).to eq(game.id)
  #     expect(
  #       v['manufacturers'][1]['company']
  #     ).to eq(game.manufacturers[1].company)
  #     expect(
  #       v['manufacturers'][1]['region']
  #     ).to eq(game.manufacturers[1].region)
  #     expect(
  #       v['manufacturers'][1]['game_id']
  #     ).to eq(game.id)
  #   end
  # end
  #
  # describe "GET #image json" do
  #   let(:game) do
  #     g = Game.create!(name: 'Quux',
  #                      publication_year: 1972,
  #                      is_active: true)
  #     g.manufacturers.create!([{company: 'Win', region: 'JP'},
  #                              {company: 'AYB', region: 'US'}])
  #     g
  #   end
  #
  #   it "returns http success" do
  #     get :image, id: game, format: :json
  #     expect(response).to have_http_status(:success)
  #   end
  #
  #   it "returns img tag with path to game image as json" do
  #     get :image, id: game, format: :json
  #     v = JSON.parse(response.body)
  #     expect(v.keys).to include('image_tag')
  #     expect(v['image_tag']).to match(%r{<img\s+.*src="/assets/\w+\.\w+".*>}i)
  #     expect(v['image_tag']).to match(/<img\s+.*width="\d+".*>/i)
  #     expect(v['image_tag']).to match(/<img\s+.*height="\d+".*>/i)
  #   end
  # end
  #
  # describe "POST #like json" do
  #   let(:game) do
  #     g = Game.create!(name: 'Quux',
  #                      publication_year: 1972,
  #                      is_active: true)
  #     g.manufacturers.create!([{company: 'Win', region: 'JP'},
  #                              {company: 'AYB', region: 'US'}])
  #     g
  #   end
  #
  #   it "returns http success for unique remote_ip" do
  #     post :like, id: game, remote_ip: '10.0.1.1', format: :json
  #     expect(response).to have_http_status(:created)
  #   end
  #
  #   it "returns http :no_content for non-unique remote_ip" do
  #     post :like, id: game, remote_ip: '10.0.1.1', format: :json
  #     expect(response).to have_http_status(:created)
  #     post :like, id: game, remote_ip: '10.0.1.1', format: :json
  #     expect(response).to have_http_status(:no_content)
  #   end
  #
  #   it "adds a like to the given game" do
  #     post :like, id: game, remote_ip: '10.0.1.1', format: :json
  #     game.reload
  #     expect(game.likes.map(&:ip_addr)).to eq(['10.0.1.1'])
  #   end
  # end
end
