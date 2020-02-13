# Ruby assignment
# Change the following tests with your own name and student ID.
# NB. Failure to do so will result in marks being deducted.
# IMPORTANT: Ensure you save the file after making the changes. 
# DO notchange the names of the files. Just ensure you backup the files often.

# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
# https://en.wikipedia.org/wiki/Wheel_of_Fortune_(UK_game_show)
require "#{File.dirname(__FILE__)}/wad_wof_gen_01"

# predefined method - NOT to be removed
def check_valid(secret)
	@game.secret = secret
	sarray = []
	i = 0
	secret.split('').each do|c| 
		sarray[i] = c
		i=i+1
	end
end

module WOF_Game
	# RSpec Tests 
	describe Game do
		describe "#WOF game" do
			before(:each) do
				@input = double('input').as_null_object
				@output = double('output').as_null_object
				@game = Game.new(@input, @output)
			end
			it "should create a method called start" do
				@game.start
			end
			it "should display a welcome message when start method called" do
				@output.should_receive(:puts).with('Welcome to WOF!')
				@game.start
			end
			it "should contain a method created_by which returns the student names" do
				myname = @game.created_by
				myname.should == "Noura El Khadri,Ruilin Wang,Adam Taylor,Alexander Bremner"	# -----Change text to your own names-----
			end
			it "should contain a method student_id which returns the student ID numbers" do
				studentid = @game.student_id
				studentid.should == "51986044,51986323,51988294,51987069"		# -----Change ID to your own student ID numbers-----
			end
			it "should display a created by message within method start" do
				@output.should_receive(:puts).with("Created by: #{@game.created_by} (#{@game.student_id})")
				@game.start
			end
			it "should return menu options when method menuoptions called" do
				moptions = @game.menuoptions()
				moptions.should == "Menu: (1) Play | (2) New | (3) Analysis | (9) Exit\n"			
			end
			it "should return menu instructions when method menuprompt called" do
				mprompt = @game.menuprompt()
				mprompt.should == "Select option from menu."
			end
			it "should display begin game message" do
				@output.should_receive(:puts).with('Begin game.')
				@game.displaybegingame			
			end
			it "should display new game created message" do
				@output.should_receive(:puts).with('New game created.')
				@game.displaynewgamecreated			
			end
			it "should display analysis message" do
				@output.should_receive(:puts).with('Analysis of game.')
				@game.displaygameanalysis			
			end
			it "should send a finish message" do
				@output.should_receive(:puts).with('Game finished.')
				@game.finish			
			end
			it "should display a invalid input error message" do
				@output.should_receive(:puts).with('Invalid input.')
				@game.displayinvalidinputerror			
			end
			it "should create a method resetgame" do
				@game.resetgame
			end
			it "should set object variables to correct value" do
				@game.resetgame
				@game.wordtable.should == []
				@game.secretword.should == ""
				@game.turn.should == 0
				@game.resulta.should == []
				@game.resultb.should == []
				@game.winner.should == 0
				@game.guess.should == ""
				@game.template.should == "[]"
			end
			it "should create a method readwordfile which passes name of file to read" do
				@game.readwordfile("wordfile.txt")
			end
			it "should create a method readwordfile which returns number of words/phrases" do
				words = @game.readwordfile("wordfile.txt")
				words.should == 4
			end
			it "should create a method readwordfile which writes words/phrases into wordtable" do
				@game.readwordfile("wordfile.txt")
				@game.wordtable.should == ["duck","eider","mallard","punk duck"]
			end
			it "should create a method gensecretword" do
				@game.resetgame
				@game.readwordfile("wordfile.txt")
				@game.gensecretword
			end
			it "should create a method gensecretword which returns one of the words/phrases from wordtable" do
				@game.resetgame
				@game.readwordfile("wordfile.txt")
				word = @game.gensecretword
				if word == "DUCK"
					word.should == "DUCK"
				elsif word == "EIDER"
					word.should == "EIDER"
				elsif word == "MALLARD"
					word.should == "MALLARD"
				elsif word == "PUNK DUCK"
					word.should == "PUNK DUCK"
				else
					word.should == nil
				end
			end
			it "should return true or false that secretword is upcase when checkwordupcase method called" do
				@game.resetgame
				@game.readwordfile("wordfile.txt")
				word = @game.gensecretword
				if word.upcase then
					wset = TRUE
				else
					wset = FALSE
				end
				isup = @game.checkwordupcase?
				isup.should == wset
			end
			it "should create a method setsecretword which receives a value to set object variable secretword" do
				@game.setsecretword("duck")
			end
			it "should create a method getsecretword which returns the value set within object variable secretword" do
				@game.setsecretword("duck")
				word = @game.getsecretword
				word.should == "duck"
			end
			it "should create a template [_] for a selected word/phrase" do
				@game.readwordfile("wordfile.txt")
				word = @game.gensecretword
				@game.setsecretword(word)
				template = @game.createtemplate
				if word == "duck"
					template.should == "[____]"
				elsif word == "eider"
					template.should == "[_____]"					
				elsif word == "mallard"
					template.should == "[_______]"					
				elsif word == "punk duck"
					template.should == "[_________]"					
				end
			end
			it "should return selected secret word and its template within an array when getsecrettemplate method called" do
				sectemp = []
				@game.readwordfile("wordfile.txt")
				word = @game.gensecretword
				@game.setsecretword(word)
				template = @game.createtemplate
				sectemp[0] = word
				sectemp[1] = template
				mysecret = @game.getsecrettemplate
#				@game.secretword.should == mysecret[0] && @game.template.should == mysecret[1]
				sectemp[0].should == mysecret[0] && sectemp[1].should == mysecret[1]
			end
			it "should create a method incrementturn which increase turn by 1" do
				@game.resetgame
				@game.incrementturn
				@game.turn.should == 1
			end
			it "should create a method getturnsleft which increase turn by 1" do
				@game.resetgame
				@game.incrementturn
				@game.getturnsleft
				@game.turnsleft.should == GOES - 1
			end
			it "should return player wins message when displaywinner method called with TRUE parameter" do
				won = @game.displaywinner(TRUE)
				won.should == "Well done. You win."
			end
			it "should return computer wins message when displaywinner method called with FALSE parameter" do
				won = @game.displaywinner(FALSE)
				won.should == "Sorry, computer wins."				
			end
			it "should return each of your group's student name and id 'Nigel Beacham (123456789)' by index when displaycredits method called" do
				names = @game.created_by
				ids = @game.student_id
				namescan = names.split(/,/)
				idscan = ids.split(/,/)
				i = 0
				buf = ""
				for s in 1..namescan.size do
					@game.displaycredits(i, names, ids).should == "#{namescan[i].strip} (#{idscan[i].strip})"
					buf = buf + @game.displaycredits(i, names, ids)
					i=i+1
				end
			end

		end
	end
end