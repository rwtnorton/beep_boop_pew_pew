require 'rails_helper'

describe Manufacturer do

  let!(:game) do
    # TODO: fixture or factory would be better here
    Game.create!(name: 'Pong',
                 publication_year: 1972,
                 is_active: true)
  end

  let(:valid_attrs) do
    {company: "Atari", region: "JP"}
  end

  it "should create a new instance given valid attributes" do
    game.manufacturers.create!(valid_attrs)
  end

  describe "attribute game_id" do

    it "should be required" do
      invalid_attrs = valid_attrs.reject { |k, v| k == :game_id }
      m = Manufacturer.create(invalid_attrs)
      expect(m).to be_invalid
    end
  end

  describe "attribute company" do

    it "should be required" do
      m = game.manufacturers.create(valid_attrs.merge(company: nil))
      expect(m).to be_invalid
      expect(m.errors[:company]).to include(%q[can't be blank])
    end
  end

  describe "attribute region" do

    it "should be optional with '' default" do
      invalid_attrs = valid_attrs.reject { |k, v| k == :region }
      m = game.manufacturers.create(invalid_attrs)
      expect(m).to be_valid
      expect(m.region).to eq('')
    end

    [
      ['', true],
      ['O', false],
      ['US', true],
      ['uk', true],
      ['JP', true],
      ['USA', false],
      [nil, false],
    ].each do |v, ok|
      it 'should %s %p' % [ok ? 'allow' : 'disallow', v] do
        m = game.manufacturers.create(valid_attrs.merge(region: v))
        if ok
          expect(m).to be_valid
        else
          expect(m).to be_invalid
        end
      end
    end
  end

  it "should disallow duplicates" do
    m = game.manufacturers.create!(valid_attrs)
    expect {
      game.manufacturers.create!(valid_attrs)
    }.to raise_error(ActiveRecord::StatementInvalid,
                     /\bUNIQUE constraint failed\b/)
  end

  context "associations" do
    let(:manuf) { game.manufacturers.create(valid_attrs) }

    describe "game" do

      it "should have a game attribute" do
        expect(manuf).to respond_to(:game)
      end

      it "should have the correctly associated game" do
        expect(manuf.game_id).to eq(game.id)
        expect(manuf.game).to eq(game)
      end
    end
  end
end
