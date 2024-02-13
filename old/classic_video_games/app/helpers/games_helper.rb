module GamesHelper

  def format_publisher(game)
    entries = []
    game.manufacturers.each do |m|
      s = m.company
      s += ' (%s)' % m.region if !m.region.blank?
      entries << s
    end
    entries.join(' / ')
  end

  def game_image(game_image_name)
    if game_image_name.nil?
      image_tag('q_block.gif', width: 320, height: 320)
    else
      image_tag(game_image_name, width: 320, height: 480)
    end
  end
end
