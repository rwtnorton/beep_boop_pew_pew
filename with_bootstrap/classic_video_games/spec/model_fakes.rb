module Fake
  # ignore created_at and updated_at
  Manufacturer = Struct.new(*%i[id game_id game company region]) do
  end

  Manufacturers = Struct.new(:game, :elems) do
    include Enumerable

    attr_accessor :game

    def self.new_with_game(game)
      new(game: game, elems: [])
    end

    def each
      @elems.each { |e| yield e }
    end

    def [](i)
      @elems[i]
    end

    def create!(attrs)
      raise ArgumentError, 'attrs not an array' unless attrs.is_a?(Array)
      @elems = []
      attrs.each do |attr|
        norm_attr = attr.merge(game: game, game_id: game && game.id)
        m = Manufacturer.new
        norm_attr.each do |k, v|
          m[k] = v
        end
        @elems << m
      end

      self
    end
  end

  Game = Struct.new(*%i[
    id name publication_year manufacturers notes is_active
  ]) do

    def self.create!(attrs)
      game = new(is_active: false)
      attrs.each do |k, v|
        game[k] = v
      end
      game[:manufacturers] = Manufacturers.new_with_game(game)
      game
    end
  end
end
