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

end
