class MatchesController < ApplicationController

  def new
    @match = Match.new
  end

  def show
    @match = Match.find(params[:id])
  end

  def create
    @match = Match.create(:players => params[:players], :game => params[:game])
    if @match.save
      redirect_to match_path(@match)
    else
      redirect_to new_match_patch(:name => "tic-tac-toe")
    end
  end

end