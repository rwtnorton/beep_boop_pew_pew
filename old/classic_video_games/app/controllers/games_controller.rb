require 'game_image_finder'

class GamesController < ApplicationController

  def index
    @games = Game.includes(:manufacturers)
               .where(is_active: true)
               .order(%q{publication_year, name})
               .paginate(page: params[:page], per_page: 10)
  end

  def show
    game = Game.includes(:manufacturers).find(params[:id])
    respond_to do |format|
      format.json { render json: game.to_json(include: :manufacturers) }
    end
  end

  def image
    game = Game.find(params[:id])
    image_name = GameImageFinder.from_game(game).image_name
    respond_to do |format|
      format.json {
        render json: {image_tag: view_context.game_image(image_name)}
      }
    end
  end

  def like
    game = Game.find(params[:id])
    remote_ip = params[:remote_ip]
    begin
      if game.likes.exists?(ip_addr: remote_ip)
        head :no_content
      elsif like = game.likes.create(ip_addr: remote_ip)
        GameMailer.liked_email(like).deliver!
        head :created
      else
        head :no_content
      end
    rescue ActiveRecord::StatementInvalid
      head :no_content
    end
  end
end
