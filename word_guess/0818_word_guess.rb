#http://www.chris.com/ascii/joan/www.geocities.com/SoHo/7373/flowers.html#manrose
# require 'io/console'
# STDIN.getch

class Hangman
  attr_accessor :letter, :word

  def initialize()
    @word_to_guess #this is the word we want the user to guess
    @array_of_words_to_guess # this is where the word is coming from- contains a bank of words
    @letter #this is the user's current guess
    @letters_of_word # array of letters in the word, in the proper order ROOM => ["R","O","O","M"]
    @correct_guess #boolean; returns true if a guessed @letter is included in @letters_of_word
    @chances = 5 #how many chances the user has to be wrong
    @correct_letters = [] #this is the display array for
    @incorrect_letters = [] #bank of letters already guessed and were incorrect
    @letters_included_array = []
  end

  def select_word
    @array_of_words_to_guess = ["boot","tool","room","boom","buzz"]
    @word_to_guess = @array_of_words_to_guess[Random.rand(@array_of_words_to_guess.length - 1)].upcase!
    puts @word_to_guess
    puts "The words has #{@word_to_guess.length} letters."
    @letters_of_word = @word_to_guess.split("")
    @word_to_guess.length.times do
      @correct_letters << "_"
    end
    puts @correct_letters.join(" ")
  end

  def letter_guess(letter)
    @letter = letter
    # @letter.check_through_word
    @correct_guess = @letters_of_word.include?(letter)
    if @correct_guess
      puts "correct!"
      checking_word_for_letters
      if @correct_letters == @word_to_guess.split("")
        puts "YOU WIN!!!!\n\n"
        exit
      end
    else
      @incorrect_letters << @letter
      @chances -= 1
      puts "Nope; you have #{@chances} chances left."
      flower(@chances)
      if @chances == 0
        puts "You lost."
        exit
      end
    end
    puts "Correct letters: #{@correct_letters}"
    sorted_incorrect_letters = @incorrect_letters.sort_by { |letter| letter.upcase}
    puts "Incorrect Letters: #{sorted_incorrect_letters}"

  end

  def checking_word_for_letters
    while true
      index = @letters_of_word.index(@letter)
      if index == nil
        break
      end
      @letters_of_word[index] = "~"
      @correct_letters[index] = @letter
    end
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
          |   |
          |___|    
   """
    when 3
     puts """
     (@)(@)(@)
      ,\\,\\,|,/,/,
         _\\|/_
        |_____|
         |   |
         |___|    
     """
    when 2
      puts """
      (@)(@)
       ,\\,\\,|,/,/,
          _\\|/_
         |_____|
          |   |
          |___|    
   """
    when 1
     puts """
     (@)
      ,\\,\\,|,/,/,
         _\\|/_
        |_____|
         |   |
         |___|    
  """
    else
      puts """

       ,\\,\\,|,/,/,
          _\\|/_
         |_____|
          |   |
          |___|    
    """
    end
  end
end


play = Hangman.new()
play.select_word
while true
  puts "What letter do you want to guess? "
  letter = gets.chomp.upcase
  if letter.length == 1 || letter.index(/[1234567890!?&$%#*+-_=^`~'{()}]/) == nil
    play.letter_guess(letter)
  else
    puts "That's not ONE LETTER!"
  end
end
