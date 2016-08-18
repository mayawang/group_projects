class Dragon
  def initialize (name)
    @food_in_belly = 50
    @food_in_intestine = 0
    @awake = true
    @name = name
    @water_in_belly = 50
    @water_in_bladder = 0
    puts "#{@name} has been born!"
  end

  def feed(food_amount = 10)
    @food_in_belly += food_amount
    if @food_in_belly >= 100
      puts "#{@name} is overstuffed and makes a mess."
      @food_in_belly = 100
    else
      puts "#{@name} eats happily for #{food_amount} food!"
      status
    end
    time_passed
  end

  def drink(drink_amount = 15, drink_type = "water")
    known_drink_types = ["water", "coke", "vodka"]

    unless known_drink_types.include?(drink_type)
      puts "#{@name} looks at #{drink_type} and refuses to touch it"
      status
      time_passed
      return
    end

    @water_in_belly += drink_amount
    if @water_in_belly >= 100
      puts "#{@name} drank too much and spits up."
      @water_in_belly = 100
    else
      case drink_type
      when "water"
        puts "#{@name} drink happily for #{drink_amount} water!"
      when "coke"
        puts "#{@name} loves #{drink_amount} sugary coke stuff."
      when "vodka"
        puts "#{@name} drink #{drink_amount} vodka and is breathing fire with it."
      else
        # we should not reach here
        puts "#{@name} tastes new drink #{drink_type}"
      end
    end
    status
    time_passed
  end

  private # only samething in the same class can change it.
  def time_passed
    @food_in_belly -= 20
    @food_in_intestine += 10
    @water_in_belly -= 7
    @water_in_bladder += 6

    if @food_in_belly < 30 && @food_in_belly > 0
      puts "#{@name} is HUNGRY!"
    end
    if @food_in_intestine > 80
      if @awake == false
        @awake = true
        status
        puts "#{@name} suddenly awakes up because he wants to POO!!!"
      else
        status
        puts "#{@name} is doing the potty dance!"
      end
    end
    if @food_in_belly <= 0
      if @awake != true
        @awake = true
        puts "#{@name} suddenly awakes up because of STARVING!"
        puts "#{@name} is STARVING and EATS you!!!"
        status
      else
        puts "#{@name} is STARVING and EATS you!!!"
        status
      end
      exit
    end
    if @water_in_belly < 20
      if @awake != true
        @awake = true
        puts "#{@name} wakes up and is so thirsty he dreamt he was in Death Valley."
      else
        puts "#{@name} is so thirsty he wants to drink his own tears."
      end
    end
    if @water_in_bladder > 70
      if @awake == true
        puts "#{@name} scratches at door to go out and pee."
      elsif @awake != true
        @awake = true
        puts "#{@name} wakes up because nature is calling."
      end
    end
    if @awake == false
      status
      puts "#{@name} snores loudly!!!"
    end
  end
  public

  def walk
    if @awake == false
      puts "You waked up #{@name}."
      @awake = true
    end
    if @food_in_intestine > 100
      @food_in_intestine = 0
      status
      puts "#{@name} makes use of the facilities"
    else
      status
      puts "#{@name} sniff around but doesn't do business"
    end
    time_passed
  end

  # awake or sleep
  def nap
    @awake = false
    status
    time_passed
  end

  def play
    wake
    status
    puts "You play toss with #{@name}"
    puts "#{@name} purrs singing your eyebrows"
    time_passed
  end

  def wake
    if @awake
      return
    else
      @awake = true
      puts "You gently wake #{@name} up."
    end
  end

  def status
    puts ""
    puts "food in #{@name}'s belly: #{@food_in_belly}"
    puts "food in #{@name}'s intestine: #{@food_in_intestine}"
    puts "#{@name}'s awake status is: #{@awake}"
    puts "water in #{@name}'s belly: #{@water_in_belly}"
    puts "water in #{@name}'s bladder: #{@water_in_bladder}"
    puts "Time passed."
    puts "*************************************"
  end
end

my_dragon = Dragon.new("Derek")
my_dragon.feed(90)
#my_dragon.walk
# my_dragon.nap
#my_dragon.play
my_dragon.drink
my_dragon.drink(9, "coke")
my_dragon.drink(15, "vodka")
my_dragon.drink(5, "coffee")
my.dragon.walk
my_dragon.drink
