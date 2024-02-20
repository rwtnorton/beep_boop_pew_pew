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

  def like
    game = Game.find(params[:id])
    remote_ip = params['remote-ip']
    logger.debug("params: #{params}")
    begin
      if game.likes.exists?(ip_addr: remote_ip)
        logger.debug("already seen remote_ip='#{remote_ip}' for game_id=#{game.id}")
        head :no_content
      elsif game.likes.create(ip_addr: remote_ip)
        logger.debug("created like: remote_ip='#{remote_ip}', game_id=#{game.id}")
        # GameMailer.liked_email(like).deliver!
        logger.info("totally sent an email ;-)")
        head :created
      else
        head :no_content
      end
    rescue ActiveRecord::StatementInvalid
      head :no_content
    end
  end

end
