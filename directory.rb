require 'date'

@students = [] #an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
    input_students
    when "2"
      print_students_list
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def input_students
  width = 65
  puts "Please enter each students details, starting with student name".center(width)
  puts "To finish, just hit return twice".center(width)

  name = gets.delete("\n")
  while !name.empty? do
    puts "please enter student cohort, if blank cohort will default to november"
    cohort = gets.delete("\n")
     until Date::MONTHNAMES.include?(cohort.capitalize) || cohort == ''
       puts "Please enter a valid cohort".center(width)
       cohort = gets.delete("\n")
     end
    if cohort == ''then cohort = :november end
    puts "Please enter student age".center(width)
    age = gets.delete("\n")
    puts "Please enter student nationality".center(width)
    nationality = gets.delete("\n")
    @students << {name: name, cohort: cohort.downcase.to_sym, age: age, nationality: nationality}
    @students.count > 1 ? puts("Now we have #{@students.count} students".center(width)) : puts("Now we have 1 student".center(width))
    name = gets.delete("\n")
  end
end

def print_header
  width = 65
  puts "The students of Villains Academy".center(width)
  puts "-------------".center(width)
end

def print_students_list
  width = 65
  return if  @students.count < 1
  cohorts = @students.map {|student| student[:cohort]}.uniq
  cohorts.each do |cohort|
    @students.each do |student|
      if student[:cohort] == cohort
        puts "#{student[:name]}, #{student[:age]}, #{student[:nationality]} (#{student[:cohort]} cohort)"
      end
    end
  end
end

def print_footer
  return if  @students.count < 1
  width = 65
  @students.count > 1 ? puts("Overall, we have #{@students.count} great students".center(width)) : puts("Overall, we have 1 great student")
end

interactive_menu
