# Ruby code file - All your code should be located between the comments provided.

# Main class module
module WOF_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	GOES = 5

	class Game
		attr_reader :template, :wordtable, :input, :output, :turn, :turnsleft, :winner, :secretword, :played, :score, :resulta, :resultb, :guess
		attr_writer :template, :wordtable, :input, :output, :turn, :turnsleft, :winner, :secretword, :played, :score, :resulta, :resultb, :guess
		
		def initialize(input, output)
			@input = input
			@output = output
			@played = 0
			@score = 0
		end
		
		def getguess
			guess = @input.gets.chomp.upcase
		end
		
		def storeguess(guess)
			if guess != ""
				@resulta = @resulta.to_a.push "#{guess}"
			end
		end
		
		# Any code/methods aimed at passing the RSpect tests should be added below.
	
		@wordtable
		
		def start()
		output.puts("Welcome to WOF!")
		output.puts("Created by: "+ created_by() + " (" + student_id() + ")")
		end
		
		def created_by()
		myname = "Noura El Khadri,Ruilin Wang,Adam Taylor,Alexander Bremner"
		end
		
		def student_id()
		studentid = "51986044,51986323,51988294,51987069"
		end
		
		def menuoptions()
		moptions = "Menu: (1) Play | (2) New | (3) Analysis | (9) Exit\n"
		end
		
		def menuprompt()
		mprompt = "Select option from menu."
		end
		
		def displaybegingame()
		output.puts("Begin game.")
		end
		
		def displaynewgamecreated()
		output.puts("New game created.")
		end
		#displaygameanalysis
		def displayanalysis()
			output.puts ("Total score:  #{@score}")
			output.puts ("Total played: #{@played}")
			output.puts (@inputword)
		end
		
		def finish()
		output.puts("Game finished.")
		end
		
		def displayinvalidinputerror()
		output.puts("Invalid input.")
		end
		
		def resetgame()
		@wordtable = []
		@secretword = ""
		@turn = 0
		@resulta = []
		@resultb = []
		@winner = 0
		@guess = ""
		@template = "[]"
		@inputword=[]
		@inputturn=0
		end
		
		
		
		def readwordfile(fileToRead)
		@wordtable = File.read(fileToRead).split"\n"
		words = @wordtable.length
		
		#The following is the reqired code to read the file on MacOS ruby version 2.6
		# wordtable = []

		# count = 0
		# file = File.open(fileToRead)

		# file.each_line do |x|
			# count += 1
			# wordtable.append x.strip
		# end

		# file.close

		# @wordtable = wordtable

		# return count
		
		end
		
		
		def gensecretword()
		word = @wordtable.sample.upcase
		end
		
		def checkwordupcase?()
		word = gensecretword()
			if (word == word.upcase)
			isup = true
			else 
			isup = false
			end
		end
		
		def setsecretword(setword)
		@secretword = setword
		end
		
		def getsecretword()
		@secretword
		end
		
		def createtemplate()
		 @template= "_"*@secretword.length
		end
		
		def charinword(inpu)
		count =0
		s=0
			for i in 1..@secretword.length do
				if @secretword[s]==inpu
				count = count +1
				end
				s=s+1
			end
			return count
		end
		
		def showcharinword(inpu)
			s=0
			for i in 1..@secretword.length do
				if @secretword[s]==inpu
				@template[s]=inpu
				end
			s=s+1
			end
		
		end
		
		def revealword
		output.puts (@secretword)
		
		end
		
		def checkifwon
		winf=0
		if @secretword==@template
		winf =1
		end
		return winf
		end
		
		def incrementplayed
		@played = @played + 1
		end
		
		def incrementscore
		@score = @score + 1
		end
		
		def displaytemplate()
		output.puts (template)
		end
		
		def getsecrettemplate()
		return [getsecretword, @template]
		end
		
		def incrementturn()
		@turn = turn + 1
		end
		
		def getturnsleft()
		@turnsleft = GOES - @turn
		end
		
		def displaywinner(value)
		
		if value == true
			won = "Well done. You win."
		elsif value == false
			won = "Sorry, computer wins."
		end
		
		end
		
		def displaycredits(i, names, ids)
		namescan = names.split(/,/)
		idscan = ids.split(/,/)
		namescan[i] + " ("+idscan [i] + ")"
		end 
		

		
		# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end


