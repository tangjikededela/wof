# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'		
set :bind, '0.0.0.0'
# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
require "#{File.dirname(__FILE__)}/wad_wof_gen_01"

# Main program
module WOF_Game
	@input = STDIN
	@output = STDOUT
	g = Game.new(@input, @output)
	playing = true
	input = ""
	menu = ""
	guess = ""
	secret = ""
	filename = "wordfile.txt"
	turn = 0
	win = 0
	game = ""
	words = 0
	@inputword=[]
	@inputturn=0

	@output.puts 'Enter "1" runs game in command-line window or "2" runs it in web browser.'
	game = gets.chomp
	if game == "1"
		puts "Command line game"
	elsif game == "2"
		puts "Web-based game"
	else
		puts "Invalid input! No game selected."
		exit
	end
		
	if game == "1"
		
	# Any code added to command line game should be added below.

		g.start
		g.resetgame
		words = g.readwordfile(filename)
		if  words == 0
			@output.puts 'Error reading file.'
			exit
		end
#		@output.puts g.wordtable.inspect
#		@output.puts "Words: #{words}"
		secret = g.gensecretword
		g.setsecretword(secret)
#		@output.puts "Secret word:" + g.secretword
		g.createtemplate
		#g.displaytemplate
		
		while menu != "9"
#			g.displaymenu
			puts g.menuoptions
			puts g.menuprompt
			menu = gets.chomp
			if menu == "1"
				guess = "_"
				while guess != "" && turn < (GOES) && win != 1
					g.displaytemplate
					@output.puts 'Guess a missing charater from the hidden word/phrase. Enter returns to menu.'
					guess = g.getguess
					@output.puts "You entered: #{guess}"	#need to check value overwritten
					g.storeguess(guess)
					if g.charinword(guess) > 0
						@output.puts "Character #{guess} is in word."
						g.showcharinword(guess)
						win = g.checkifwon
						if win == 1
							g.incrementscore
							g.incrementplayed
#							@output.puts "You win!"	#need to check value overwritten
							@output.puts g.displaywinner (TRUE)
							g.revealword
						end
						
						@inputword[@inputturn]=  "#{guess} is correct. \n"
						@inputturn=@inputturn+1
					else
					@inputword[@inputturn]= "#{guess} is not correct. \n"
					@inputturn=@inputturn+1
					@output.puts "Character #{guess} is not in word."
						if guess != ""
							turn = turn + 1
							g.incrementplayed
							g.incrementturn
						end
					end
					@output.puts "You have #{g.getturnsleft} lives left."
					if turn >= (GOES)
#						@output.puts "You lose!"
						@output.puts g.displaywinner (FALSE)
						g.revealword
					end
				end
			elsif menu == "2"		# Reset game
				turn = 0
				win = 0
				@inputword=[]
				@inputturn=0
				@output.puts "New game...\n"
				@output.puts "Ready, enter 1 to have new game.\n"
				g.resetgame
				words = g.readwordfile(filename)
				if  words == 0
					@output.puts 'Error reading file.'
					exit
				end
				#@output.puts g.wordtable.inspect
				#@output.puts "Words: #{words}"
				secret = g.gensecretword
				g.setsecretword(secret)
				#@output.puts "Secret word:" + g.secretword
				g.createtemplate
				g.displaytemplate
			elsif menu == "3"
				g.displayanalysis
				puts(@inputword)
			elsif menu == "9"
				@output.puts "\n"
			elsif menu == "~"
				g.displaysecretword
			else
				@output.puts "Invalid input entered."
			end
		end
		@output.puts "The secret word was: "
		g.revealword
		g.finish
		
	# Any code added to command line game should be added above.
	
		exit	# Does not allow command-line game to run code below relating to web-based version
	end
end
# End modules

# Sinatra routes
# Sinatra routes to run ruby classes

	# Any code added to web-based game should be added below.
	def storeguess(guess) # Store the enter letter
		if guess != ""
			@resulta = @resulta.to_a.push "#{guess}"
		end
	end
	
	def readwordfile(textfile) #  Read the words from the file
		wordfile = 0
		@wordtable = File.read(textfile).split"\n"
		wordfile = @wordtable.length
		return wordfile						 
	end
	
	def  gensecretword	#Set a secret word randomly and make it upper case
		randomnumber = rand(@wordtable.size)					
		@temword=@wordtable[randomnumber].upcase
		return @temword	
	end		
	
	def checkwordupcase? #Check is the word upper case or not
		word = gensecretword
		if word.upcase then
			return TRUE
		else 
			return FALSE
		end
	end
	
	def setsecretword (word) # Set the secret word
		$secretword = word	
	end		
	
	def createtemplate # Create the template bar 
		$template = '_' * $secretword.length
		return $template
	end
	
	def charinword(inpu) # check is the enter letter in the word or not
		count = 0
		s = 0
		for i in 1..$secretword.length do
			if $secretword[s] == inpu 
				count = count + 1
			end
			s = s + 1
		end
		if count > 0
		$webWord = true
		else $webWord = false
		end
	end 
	
	def showcharinword(inpu)#show the letter if it is in the word
		s = 0
		for i in 1..$secretword.length do
			if $secretword[s] == inpu 
				$template[s] = inpu
			end
			s = s + 1
		end
	end


	
	def checkifwon # check if the player win or not
		if $template == $secretword
			$webFinish = true
			$webWin = true
		end
	end

	def incrementturn # increment turn
		if $webWord == false
			$turn = $turn + 1
		end
	end
	
	def getturnsleft # know how many lives left
		$turnsleft = $GOES - $turn
	end
	
	def checkturn # check if the game finish
		if $turn == $GOES
			$webFinish = true
		end
	end
	
	def webReset # reset the game data and get a new word
		$webPlaying = true
		$webFinish = false
		$webWord = false
		$tem = ""
		$template = ""
		$turn = 0
		$GOES = 5
		$webWin = false
		$turnsleft = $GOES - $turn
		$webInput=[]
		$webTurn=0
		filename = "wordfile.txt"
		words = readwordfile(filename)	
		secret = gensecretword
		setsecretword(secret)
		createtemplate
	end
	
	webReset
	$played=0
	$won=0
	
	get "/" do
	erb :home
	end		
	
	get "/play" do
	erb:play
	end

	get "/new" do
		webReset
		erb:new
	end
	
	post '/form' do
		$tem = params[:formdata].upcase
		showcharinword($tem)
		checkifwon
		charinword($tem)
		incrementturn
		getturnsleft
		checkturn
		redirect '/play'
	end
	
	get "/analysis" do
	erb:analysis
	end
	
	get "/exit" do
	webReset
	$played=0
	$won=0
	#exit #this will exit from the command window but will cause an error on web.
	erb:exit
	#redirect '/'
	end
	
	get '/notfound' do
	erb :notfound
	end

	not_found do # if a user try to load a page that dose not exist
    status 404
    redirect '/notfound'
	end
	
	# Any code added to web-based game should be added above.

# End program