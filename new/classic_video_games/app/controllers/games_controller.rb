class GamesController < ApplicationController

  def index
    @games = Game.includes(:manufacturers)
                 .where(is_active: true)
                 .order(%q{publication_year, name})
                 .paginate(page: params[:page], per_page: 10)
  end

end
