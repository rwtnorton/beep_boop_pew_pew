require 'rails_helper'
require 'set'

describe Game do
  let(:valid_attrs) do
    {name: 'Pong',
     publication_year: 1972,
     is_active: true}
  end

  it "should create a new instance given valid attributes" do
    Game.create!(valid_attrs)
  end

  describe "attribute name" do

    it "should be required" do
      game = Game.new(valid_attrs.merge(name: ''))
      expect(game).to be_invalid
    end

    it "should be unique" do
      g = Game.create!(valid_attrs)
      dup = Game.create(valid_attrs)
      expect(dup).to be_invalid
    end

    it "should be case-insensitively unique" do
      g = Game.create!(valid_attrs)
      invalid_attrs = valid_attrs.merge(name: g.name.downcase)
      dup = Game.create(invalid_attrs)
      expect(dup).to be_invalid
    end

    # describe "associations" do
    #   let(:game) { Game.create!(valid_attrs) }
    #
    #   describe "manufacturers" do
    #
    #     it "should have a manufacturers attribute" do
    #       expect(game).to respond_to(:manufacturers)
    #     end
    #
    #     it "should have the correctly associated manufacturers" do
    #       m = game.manufacturers.create!(company: "Atari", region: "US")
    #       expect(game.manufacturer_ids.to_set).to eq(Set[m.id])
    #       expect(game.manufacturers.to_set).to eq(Set[m])
    #     end
    #   end
    #
    #   describe "likes" do
    #
    #     it "should have a likes attribute" do
    #       expect(game).to respond_to(:likes)
    #     end
    #
    #     it "should have the correctly associated likes" do
    #       lks = game.likes.create!([{ip_addr: '10.0.1.1'},
    #                                 {ip_addr: '10.0.1.2'}])
    #       expect(game.like_ids.to_set).to eq(lks.map(&:id).to_set)
    #       expect(game.likes.to_set).to eq(lks.to_set)
    #     end
    #
    #     it "should have a likes_count as an optimization" do
    #       expect(game).to respond_to(:likes_count)
    #       expect(game.likes_count).to eq(0)
    #       expect(game.likes.size).to eq(game.likes_count)
    #
    #       game.likes.create!(ip_addr: '10.0.1.1')
    #       game.reload
    #       expect(game.likes_count).to eq(1)
    #       expect(game.likes.size).to eq(game.likes_count)
    #
    #       game.likes.create!(ip_addr: '10.0.1.2')
    #       game.reload
    #       expect(game.likes_count).to eq(2)
    #       expect(game.likes.size).to eq(game.likes_count)
    #     end
    #   end
    # end
  end
end
