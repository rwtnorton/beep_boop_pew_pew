require 'rails_helper'

RSpec.describe "Games", type: :request do

  describe "GET #index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end

    it "should have a #games table" do
      get "/"
      expect(response.body).to have_css('table#games')
    end

  end

end
