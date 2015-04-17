#Retrieve puzzle to solve
#Get nums row by row
@board = []
@list0 = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def getPuzzle
#Long way of doing the board, will add gui later.
	smilies = [':)', ':D', ':o', 'B)', 'x)', 'xD', ':3']
	for i in 0..8
		p "Enter row #{i+1} of your puzzle #{smilies[rand(0..smilies.length)]} Enter a 0 for empty squares."
		row = gets.rstrip().split('')
		while row.length != 9 
			p "Whoops, you should be giving me nine numbers! Try again."
			row = gets.rstrip().split('')
		end
		@board[i] = row
	#Assign possibilities:
		for j in 0..8
			if @board[i][j] == '0' 
				@board[i][j] = {@board[i][j] => @list0} 
			else 
				@board[i][j] = {@board[i][j] => @board[i][j]} 
			end
		end
	end
end

#Check valid puzzle (row, column, box)
def valid
	check = @board
#Find duplicates in row	
	for i in 0..8
		check[i].delete('0')
		if check.uniq.length != check.length 
			return false
		end
	end
#Find duplicates in column
	column = []
	for i in 0..8
		for j in 0..8
			column.add(check[j][i])
			column.delete('0')
			if column.uniq.length != column.length 
				return false
			end
			column.empty()
		end
	end
#Find duplicates in box (this is quite tedious)
	box1 = []
	box2 = []
	box3 = []
#Populate and check boxes for first three columns
	for i in 0..2
		for j in 0..2
			box1.add(check[i][j])
		end
		for j in 3..5 
			box2.add(check[i][j])
		end
		for j in 6..8
			box3.add(check[i][j])
		end
	end
	box1.delete('0')
	if box1.uniq.length != box1.length 
		return false
	end
	box2.delete('0')
	if box2.uniq.length != box2.length 
		return false
	end
	box3.delete('0')
	if box3.uniq.length != box3.length 
		return false
	end
#Second three columns
	for i in 3..5
		for j in 0..2
			box1.add(check[i][j])
		end
		for j in 3..5 
			box2.add(check[i][j])
		end
		for j in 6..8
			box3.add(check[i][j])
		end
	end
	box1.delete('0')
	if box1.uniq.length != box1.length 
		return false
	end
	box2.delete('0')
	if box2.uniq.length != box2.length 
		return false
	end
	box3.delete('0')
	if box3.uniq.length != box3.length 
		return false
	end
#And last three columns
	for i in 6..8
		for j in 0..2
			box1.add(check[i][j])
		end
		for j in 3..5 
			box2.add(check[i][j])
		end
		for j in 6..8
			box3.add(check[i][j])
		end
	end
	box1.delete('0')
	if box1.uniq.length != box1.length 
		return false
	end
	box2.delete('0')
	if box2.uniq.length != box2.length 
		return false
	end
	box3.delete('0')
	if box3.uniq.length != box3.length 
		return false
	end
#Less painful than I thought, code is almost completely reusable
end

#Find move in row

#Find move in column

#Find move in box

#Repeat above three until no moves found

#Guess num

#Repeat finding moves again

#If a space has 0 possibilities change last guess

getPuzzle