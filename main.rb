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
	#Find duplicates in row
	check = @board[0]
	check.delete('0')
	p check
	if check.uniq.length == check.length then p "true" end
end
#Each unit needs valid nums to enter

#Find move in row

#Find move in column

#Find move in box

#Repeat above three until no moves found

#Guess num

#Repeat finding moves again

#If a space has 0 possibilities change last guess

getPuzzle