require 'rails_helper'

describe Like do

  let!(:some_game) do
    # TODO: fixture or factory would be better here
    Game.create!(name: 'Ping',
                 publication_year: 1971,
                 is_active: true)
  end
  let(:valid_attrs) do
    {game_id: some_game.id,
     ip_addr: '10.0.1.42'}
  end

  it "should create a new instance given valid attributes" do
    Like.create!(valid_attrs)
  end

  describe "attribute ip_addr" do

    it "should be required" do
      like = Like.new(valid_attrs.merge(ip_addr: ''))
      expect(like).to be_invalid
    end
  end

  describe "attribute game_id" do

    it "should be required" do
      like = Like.new(valid_attrs.merge(game_id: nil))
      expect(like).to be_invalid
    end
  end

  describe "#liked_at" do

    it "should be available" do
      like = Like.new(valid_attrs)
      expect(like).to respond_to(:liked_at)
    end

    it "should have the same value as created_at" do
      like = Like.new(valid_attrs)
      expect(like.liked_at).to eq(like.created_at)
    end
  end

  describe "associations" do
    let!(:game) do
      # TODO: fixture or factory would be better here
      Game.create!(name: 'Pong',
                   publication_year: 1972,
                   is_active: true)
    end

    let(:valid_attrs) do
      {game_id: game.id, ip_addr: '10.0.1.42'}
    end

    describe "game" do
      let(:like) { Like.create!(valid_attrs) }

      it "should have a game attribute" do
        expect(like).to respond_to(:game)
      end

      it "should have the correctly associated game" do
        expect(like.game_id).to eq(game.id)
        expect(like.game).to eq(game)
      end
    end
  end

  it "should disallow more than one like for a given game/ip_addr pair" do
    # TODO: fixture or factory would be better here
    game = Game.create!(name: 'Pong',
                        publication_year: 1972,
                        is_active: true)
    attrs = {game_id: game.id, ip_addr: '10.0.1.42'}
    like = Like.create!(attrs)
    expect {
      Like.create!(attrs)
    }.to raise_error(ActiveRecord::StatementInvalid,
                     /\bUNIQUE constraint failed\b/)
  end
end
