class GameMailer < ActionMailer::Base
  include GamesHelper
  helper :games

  default from: 'from@example.com'

  def liked_email(like)
    recipient = Rails.application.config.liked_email_recipient
    game = like.game
    @ip_addr = like.ip_addr
    @game_name = game.name
    @game_year = game.publication_year
    @game_publishers = format_publisher(game)
    @num_likes = game.likes.size
    mail(to: recipient, subject: 'Game %p was liked!' % @game_name)
  end
end
