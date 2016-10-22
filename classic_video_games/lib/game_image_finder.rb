require 'game_name'

class GameImageFinder

  attr_reader :game_name

  def initialize(game_name, image_dir=default_dir)
    @game_name = game_name
    @image_dir = image_dir
  end

  def default_dir
    File.expand_path('../../app/assets/images', __FILE__)
  end

  def self.from_game(game)
    new(game.name)
  end

  def image_name
    norm_name = GameName.normalize(game_name)
    wild_ext = '%s.*' % norm_name
    found = Dir.glob(File.join(@image_dir, wild_ext)).sort
    return nil if found.empty?
    ## TODO: should we raise an exception if found.size > 1 ?
    return File.basename(found.first)
  end
end
