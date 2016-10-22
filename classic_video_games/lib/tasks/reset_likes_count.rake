namespace :games do
  namespace :likes_count do
    desc "Resets games.likes_count for all games"
    task reset: :environment do
      Game.find_each do |game|
        Game.reset_counters(game.id, :likes)
      end
    end
  end
end
