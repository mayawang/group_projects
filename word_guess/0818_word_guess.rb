require 'faker'

class Hangman
  attr_accessor :letter, :word

  def initialize()
    @word_to_guess = "" #this is the word we want the user to guess
    @array_of_words_to_guess = [] # this is where the word is coming from- contains a bank of words
    @letters_of_word = [] # array of letters in the word, in the proper order ROOM => ["R","O","O","M"]
    @chances = 5 #how many chances the user has to be wrong
    @correct_letters = [] #this is the display array for
    @incorrect_letters = [] #bank of letters already guessed and were incorrect
    @letters_included_array = []
    @theme = ""
  end

  def generate_new_word #user can guess based on three themes: musical instruments, pokemons, & constellations
    while true
      puts "Please input a number to select a theme of words:"
      puts "1.music instrument\n2.Pokemon\n3.constellation"
      @theme = gets.chomp
      case @theme
      when "1"
        @word_to_guess = Faker::Music.instrument.upcase
      when "2"
        @word_to_guess = Faker::Pokemon.name.upcase
      when "3"
        @word_to_guess = Faker::Space.constellation.upcase
      else
        puts "Sorry, please enter a valid number of theme."
      end
      # puts @word_to_guess
      return
    end
  end

  def display_word_to_guess
    puts "The words has #{@word_to_guess.length} letters."
    @letters_of_word = @word_to_guess.split("") #splits letters into an array
    @word_to_guess.length.times do # new array with blanks instead of letters for display
      @correct_letters << "_"
    end
    display_duplicate_letters(" ") #displays spaces in words so user doesn't have to guess a space
    puts @correct_letters.join(" ")
  end

  def get_letter_from_user #input from user on what letter they think is in the word
    while true
      print "What letter do you want to guess? "
      letter = gets.chomp.upcase
      if letter.length == 1 && letter.index(/[a-zA-Z ]/) != nil
        self.guess_letter(letter)
        # use self. refers to the object that currently called on(e.g. here is game.)
        # usually use when member method call another member method within the same class
        # self. can be obmit in ruby.
      else
        puts "That's not ONE LETTER!"
      end
    end
  end

  def guess_letter(letter)
    is_correct_guess = @letters_of_word.include?(letter) #checks if letter is included in word
    if is_correct_guess
      self.display_duplicate_letters(letter) # if the letter is included it'll check in the duplicate letter method & display them all
      if @correct_letters == @word_to_guess.split("")
        puts "YOU WIN!!!!\n\n"
        exit
      end
    else
      @incorrect_letters << letter
      @chances -= 1
      puts "Nope; you have #{@chances} chances left."
      self.flower(@chances) #ASCII art based on how many chances are left
      if @chances == 0
        puts "You lost."
        puts "The word was #{@word_to_guess}."
        exit
      end
    end
    sorted_incorrect_letters = @incorrect_letters.sort_by {|incorrect_letter| incorrect_letter.upcase} #gives incorrect letters guessed in alpha order
    puts "Incorrect Letters: #{sorted_incorrect_letters.join(" ")}"
  end

  def display_duplicate_letters(letter)
    while true
      index = @letters_of_word.index(letter)
      if index == nil
        break
      end
      @letters_of_word[index] = "~"
      @correct_letters[index] = letter
    end
    puts "Correct letters: #{@correct_letters.join(" ")}"
  end

  def flower(chances)
    @chances = chances
    case @chances
    when 4
      puts """
      (@)(@)(@)(@)
       ,\\,\\,|,/,/,
          _\\|/_
         |_____|
          |   |
          |___|
   """
    when 3
     puts """
     (@)(@)(@)
      ,\\,\\,|,/,/,
         _\\|/_
        |_____|
         |   |
         |___|
     """
    when 2
      puts """
      (@)(@)
       ,\\,\\,|,/,/,
          _\\|/_
         |_____|
          |   |
          |___|
   """
    when 1
     puts """
     (@)
      ,\\,\\,|,/,/,
         _\\|/_
        |_____|
         |   |
         |___|
  """
    else
      puts """

       ,\\,\\,|,/,/,
          _\\|/_
         |_____|
          |   |
          |___|
    """
    end
  end
end

game = Hangman.new()
game.generate_new_word
game.display_word_to_guess
game.get_letter_from_user #guess_letter is called inside this method.
