class Match < ActiveRecord::Base
  has_many :moves

  def board_slots
    return ["1-1","1-2","1-3","2-1","2-2","2-3","3-1","3-2","3-3"]
  end

  def remaining_slots
    return (board_slots - self.moves.map(&:value))
  end

  def previous_player_moves
    return self.moves.where(:player => 1)
  end

  def previous_computer_moves
    return self.moves.where(:player => 2)
  end

  def new_computer_move
    self.moves.create(:player => 2, :value => remaining_slots.first)
  end

end
