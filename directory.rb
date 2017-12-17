require 'date'
require 'csv'

@students = []
@width = 65

def interactive_menu
  loop do
    print_menu
    menu_option(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students".center(@width)
  puts "2. Show the students".center(@width)
  puts "3. Save the list to chosen file".center(@width)
  puts "4. Load the list chosen file".center(@width)
  puts "5. Show students sorted by cohort".center(@width)
  puts "9. Exit".center(@width)
end

def menu_option(selection)
  case selection
    when "1" then input_students
    when "2" then show_students
    when "3" then save_students(file_name_input)
    when "4" then load_students(file_name_input)
    when"5" then print_students_by_cohort
    when "9"
      puts "Goodbye!".center(@width)
      exit
    else
      puts "I don't know what you meant, try again".center(@width)
  end
end

def startup_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
  elsif File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist.".center(@width)
    exit
  end
end

def add_students(name,cohort)
  @students << {name: name, cohort: cohort.downcase.to_sym}
end

def file_name_input
  puts "Please enter file name".center(@width)
  filename = STDIN.gets.chomp
  until File.exists?(filename)
    puts "please enter existing file name".center(@width)
    filename = STDIN.gets.chomp
  end
  filename
end

def load_students(filename = "students.csv")
    CSV.foreach(filename) do |line|
      name, cohort =  line
      add_students(name,cohort)
  end
  puts "Loaded #{@students.count} student#{plural_students?}from #{filename}".center(@width)
end

def save_students(filename)
  CSV.open(filename,"w") do |csv_file|
    @students.each do |student|
      csv_file << [student[:name], student[:cohort]]
    end
  end
  puts "Students succesfully saved to #{filename} file".center(@width)
end

def input_students
  input_instruction_text
  name = STDIN.gets.chomp
  while !name.empty? do
    cohort = input_cohort_entry
    add_students(name,cohort)
    puts "Now we have #{@students.count} student#{plural_students?}".center(@width)
    name = STDIN.gets.chomp
  end
end

def input_instruction_text
  puts "Please enter each students details, starting with student name".center(@width)
  puts "To finish, just hit return twice".center(@width)
end

def input_cohort_entry
  puts "please enter student cohort, if blank cohort will default to november".center(@width)
  cohort = STDIN.gets.chomp
  until Date::MONTHNAMES.include?(cohort.capitalize) || cohort == ''
    puts "Please enter a valid cohort".center(@width)
    cohort = STDIN.gets.chomp
  end
  if cohort == '' then cohort = :november end
  return cohort
end

def show_students
  if @students.empty?
    puts "No students enrolled"
  else
    print_header
    print_students_list
    print_footer
  end
end

def print_students_list
  @students.each {|student| puts "#{student[:name]} (#{student[:cohort]} cohort)".center(@width)}
end

def print_students_by_cohort
  cohorts = @students.map {|student| student[:cohort]}.uniq
  cohorts.each do |cohort|
    @students.each do |student|
      if student[:cohort] == cohort
        puts "#{student[:name]} (#{student[:cohort]} cohort)".center(@width)
      end
    end
  end
end

def print_header
  puts "The students of Villains Academy".center(@width)
  puts "-------------".center(@width)
end

def print_footer
puts "Overall, we have #{@students.count} great student#{plural_students?}".center(@width)
end

def plural_students?
  @students.count > 1 ? "s" : ""
end

startup_load_students
interactive_menu
