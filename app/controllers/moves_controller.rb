class MovesController < ApplicationController

  def player_move
    @match = Match.find(params[:id])
    move = @match.moves.create(:player => 1, :value => params[:box])
    new_computer_move = @match.new_computer_move

    respond_to do |format|
      format.json {render json: @match.moves.where(:player => 2).last}
    end
  end

  def computer_move
  end

end
