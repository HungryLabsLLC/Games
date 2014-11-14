class Move < ActiveRecord::Base
  belongs_to :match

  def self.determine_next_move(match, player)
    gather_match_variables(match, player)
    return next_move
  end

  def self.gather_match_variables(match, player)
    @match = match
    @existing_computer_moves = @match.previous_computer_moves
    @existing_player_moves = @match.previous_player_moves
    @remaining_slots = @match.remaining_slots
    @computer_player = Player.new(player, @match) if player == 2
    @current_player = player
    @opposing_player = @current_player == 1 ? 2 : 1
  end

  def self.next_move
    case @computer_player.what_to_do
    when "ha! you're fucked"
      return @computer_player.winning_move.first
    when "we have a winna!"
      return @computer_player.winning_move.first
    when "best offense is a good defense"
      p "defense"
      return @computer_player.losing_move.first
    when "tri corner strategy"
      return @remaining_slots.sample
    end
  end

  def self.next_strategy
  end

  def self.we_have_a_winna
  end

  def self.tri_corner_strategy
  end

  def self.best_offense_is_a_good_defense?
  end


end
