class Match < ActiveRecord::Base
  has_many :moves

  def check_player_score
    victory = nil
    if check_vertical_moves(1).present?
      victory = "col:#{check_vertical_moves(1)}"
    elsif check_horizontal_moves(1).present?
      victory = "row:#{check_horizontal_moves(1)}"
    elsif check_diagonal_moves(1).present?
      victory = "diag:#{check_diagonal_moves(1)}"
    end
    return victory
  end

  def check_computer_score
    victory = nil
    if check_vertical_moves(2).present?
      victory = "col:#{check_vertical_moves(2)}"
    elsif check_horizontal_moves(2).present?
      victory = "row:#{check_horizontal_moves(2)}"
    elsif check_diagonal_moves(2).present?
      victory = "diag:#{check_diagonal_moves(2)}"
    end
    return victory
  end

  def board_slots
    return ["1-1","1-2","1-3","2-1","2-2","2-3","3-1","3-2","3-3"]
  end

  def horizontal_slots(row)
    return ["#{row}-1", "#{row}-2", "#{row}-3"]
  end

  def vertical_slots(col)
    return ["1-#{col}", "2-#{col}", "3-#{col}"]
  end

  def diagonal_slots
    return [["1-1","2-2","3-3"], ["3-1","2-2","1-3"]]
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
    self.moves.create(:player => 2, :value => remaining_slots.sample)
  end

  def check_horizontal_moves(player)
    move_values = player == 1? previous_player_moves.map(&:value) : previous_computer_moves.map(&:value)
    row_victory = nil
    [1,2,3].each do |row|
      progress = horizontal_slots(row) - move_values
      if progress.empty?
        row_victory = row
      end
    end
    return row_victory
  end

  def check_vertical_moves(player)
    move_values = player == 1? previous_player_moves.map(&:value) : previous_computer_moves.map(&:value)
    col_victory = nil
    [1,2,3].each do |col|
      progress = vertical_slots(col) - move_values
      if progress.empty?
        col_victory = col
      end
    end
    return col_victory
  end

  def check_diagonal_moves(player)
    move_values = player == 1? previous_player_moves.map(&:value) : previous_computer_moves.map(&:value)
    diag_victory = nil
    diagonal_slots.each_with_index do |direction,i|
      progress = direction - move_values
      if progress.empty? && i == 0
        diag_victory = "forward"
      elsif progress.empty? && i == 1
        diag_victory = "backward"
      end
    end
    return diag_victory
  end

end
