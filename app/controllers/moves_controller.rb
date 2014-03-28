class MovesController < ApplicationController

  def player_move
    @match = Match.find(params[:id])
    move = @match.moves.create(:player => 1, :value => params[:box])
    if @match.check_player_score.present?
      @match.status = "finished"
      @match.outcome = "Player 1"
      @match.save
      respond_to do |format|
        format.json {render json: @match}
      end
    else
      computer_move = @match.new_computer_move
      if @match.check_computer_score.present?
        @match.status = "finished"
        @match.outcome = "Player 2"
        @match.save
        comp_winning_data = {"outcome" => "Player 2", "last_move" => @match.moves.last.value}
        respond_to do |format|
          format.json {render json: comp_winning_data}
        end
      else
        respond_to do |format|
          format.json {render json: @match.moves.where(:player => 2).last}
        end
      end
    end
  end

  def computer_move
  end

end
