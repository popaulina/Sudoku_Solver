#Retrieve puzzle to solve
#Get nums row by row
@board = []
@check = []
@list0 = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def getPuzzle
#Long way of doing the board, will add gui later.
	smilies = [':)', ':D', ':o', 'B)', 'x)', 'xD', ':3']
	for i in 0..8
		p "Enter row #{i+1} of your puzzle #{smilies[rand(0..smilies.length-1)]} Enter a 0 for empty squares."
		row = gets.rstrip().split('')
		while row.length != 9 
			p "Whoops, you should be giving me nine numbers! Try again."
			row = gets.rstrip().split('')
		end
		for k in 0..8
			row[k] = row[k].to_i
		end
		@board[i] = row
		@check[i] = row.dup
	#Assign possibilities:
		for j in 0..8
			if @board[i][j] == 0 
				@board[i][j] = {@board[i][j] => @list0.dup}
			else 
				@board[i][j] = {@board[i][j] => @board[i][j]} 
			end
		end
	end
end

#Check valid puzzle (row, column, box)
def valid

#Find duplicates in row	
 	checks = @check.dup
	for i in 0..8
		checks[i].delete(0)
		if checks.uniq.length != checks.length 
			return false
		end
	end

#Find duplicates in column
	checks = @check.dup
	column = []
	for i in 0..8
		for j in 0..8
			column << checks[j][i]
		end
		column.delete(0)
		if column.uniq.length != column.length 
			return false
		end
		column.clear
	end
#Find duplicates in box (this is quite tedious)
	box1 = []
	box2 = []
	box3 = []
#Populate and check boxes for first three columns
	for i in 0..2
		for j in 0..2
			box1 << checks[i][j]
		end
		for j in 3..5 
			box2 << checks[i][j]
		end
		for j in 6..8
			box3 << checks[i][j]
		end
	end
	box1.delete(0)
	if box1.uniq.length != box1.length 
		return false
	end
	box2.delete(0)
	if box2.uniq.length != box2.length 
		return false
	end
	box3.delete(0)
	if box3.uniq.length != box3.length 
		return false
	end
#Second three columns
	box1.clear
	box2.clear
	box3.clear
	for i in 3..5
		for j in 0..2
			box1 << checks[i][j]
		end
		for j in 3..5 
			box2 << checks[i][j]
		end
		for j in 6..8
			box3 << checks[i][j]
		end
	end
	box1.delete(0)
	if box1.uniq.length != box1.length 
		return false
	end
	box2.delete(0)
	if box2.uniq.length != box2.length 
		return false
	end
	box3.delete(0)
	if box3.uniq.length != box3.length 
		return false
	end
# And last three columns
	box1.clear
	box2.clear
	box3.clear
	for i in 6..8
		for j in 0..2
			box1 << checks[i][j]
		end
		for j in 3..5 
			box2 << checks[i][j]
		end
		for j in 6..8
			box3 << checks[i][j]
		end
	end
	box1.delete(0)
	if box1.uniq.length != box1.length 
		return false
	end
	box2.delete(0)
	if box2.uniq.length != box2.length 
		return false
	end
	box3.delete(0)
	if box3.uniq.length != box3.length 
		return false
	end

	return true #woo
#Less painful than I thought, code is almost completely reusable
end

#Simplify the board
def simplify
  taken = []
#Find move in row
  for i in 0..8
		taken.clear
		for j in 0..8
			#Find what nums have been taken already
			if @check[i][j] > 0
				taken << @check[i][j]
			end
		end
		for k in 0..8
			if @check[i][k] == 0
				for l in 0..taken.length-1
					#Find if taken values still in possibilities
					#Remove if found
					if @board[i][k].values[0].include?(taken[l])
						@board[i][k].values[0].delete(taken[l])
					end
				end
			end
		end
	end
#damn
#Find move in column
column = []
	for i in 0..8
		for j in 0..8
			column << @check[j][i]
		end
		for k in 0..8
			#Find what nums have been taken already
			if column[k].to_i > 0
				taken << column[k]
			end
		end
		for l in 0..8
			
			if column[l] == 0
				for m in 0..taken.length-1
					#Find if taken values still in possibilities
					#Remove if found
					if @board[l][i].values[0].include? taken[m]
						@board[l][i].values[0].delete(taken[m])
					end
				end
			end
		end
		taken.clear
		column.clear
  end
  p @board
#Find move in box (oh boy)
  box1taken = []
  box2taken = []
  box3taken = []
  for i in 0..2
    for j in 0..2
      if @check[i][j] > 0
        box1taken << @check[i][j]
      end
    end
    for j in 3..5
      if @check[i][j] > 0
        box2taken << @check[i][j]
      end
    end
    for j in 6..8
      if @check[i][j] > 0
        box3taken << @check[i][j]
      end
    end
  end
  for i in 0..2
    for j in 0..2
      if @check[i][j] == 0
        for k in 0..box1taken.length-1
          if @board[i][j].values[0].include? box1taken[k]
            @board[i][j].values[0].delete(box1taken[k])
          end
        end
      end
    end
    for j in 3..5
      if @check[i][j] == 0
        for k in 0..box2taken.length-1
          if @board[i][j].values[0].include? box2taken[k]
            @board[i][j].values[0].delete(box2taken[k])
          end
        end
      end
    end
    for j in 6..8
      if @check[i][j] == 0
        for k in 0..box3taken.length-1
          if @board[i][j].values[0].include? box3taken[k]
            @board[i][j].values[0].delete(box3taken[k])
          end
        end
      end
    end
  end
  box1taken.clear
  box2taken.clear
  box3taken.clear
  for i in 3..5
    for j in 0..2
      if @check[i][j] > 0
        box1taken << @check[i][j]
      end
    end
    for j in 3..5
      if @check[i][j] > 0
        box2taken << @check[i][j]
      end
    end
    for j in 6..8
      if @check[i][j] > 0
        box3taken << @check[i][j]
      end
    end
  end
  for i in 3..5
    for j in 0..2
      if @check[i][j] == 0
        for k in 0..box1taken.length-1
          if @board[i][j].values[0].include? box1taken[k]
            @board[i][j].values[0].delete(box1taken[k])
          end
        end
      end
    end
    for j in 3..5
      if @check[i][j] == 0
        for k in 0..box2taken.length-1
          if @board[i][j].values[0].include? box2taken[k]
            @board[i][j].values[0].delete(box2taken[k])
          end
        end
      end
    end
    for j in 6..8
      if @check[i][j] == 0
        for k in 0..box3taken.length-1
          if @board[i][j].values[0].include? box3taken[k]
            @board[i][j].values[0].delete(box3taken[k])
          end
        end
      end
    end
  end
  box1taken.clear
  box2taken.clear
  box3taken.clear
  for i in 6..8
    for j in 0..2
      if @check[i][j] > 0
        box1taken << @check[i][j]
      end
    end
    for j in 3..5
      if @check[i][j] > 0
        box2taken << @check[i][j]
      end
    end
    for j in 6..8
      if @check[i][j] > 0
        box3taken << @check[i][j]
      end
    end
  end
  for i in 6..8
    for j in 0..2
      if @check[i][j] == 0
        for k in 0..box1taken.length-1
          if @board[i][j].values[0].include? box1taken[k]
            @board[i][j].values[0].delete(box1taken[k])
          end
        end
      end
    end
    for j in 3..5
      if @check[i][j] == 0
        for k in 0..box2taken.length-1
          if @board[i][j].values[0].include? box2taken[k]
            @board[i][j].values[0].delete(box2taken[k])
          end
        end
      end
    end
    for j in 6..8
      if @check[i][j] == 0
        for k in 0..box3taken.length-1
          if @board[i][j].values[0].include? box3taken[k]
            @board[i][j].values[0].delete(box3taken[k])
          end
        end
      end
    end
  end
end

#Guess num

#Repeat finding moves again

#If a space has 0 possibilities change last guess

getPuzzle
simplify