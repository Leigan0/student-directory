require 'date'

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
  puts "9. Exit".center(@width)
end

def menu_option(selection)
  case selection
    when "1"
    input_students
    when "2"
      show_students
    when "3"
      puts "Please enter the name of the file you wish to save to".center(@width)
      save_students(valid_file_name)
    when "4"
      puts "Please enter the name of the file to load".center(@width)
      load_students(valid_file_name)
    when "9"
      puts "Goodbye!".center(@width)
      exit
    else
      puts "I don't know what you meant, try again".center(@width)
  end
end

def try_load_students
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

def valid_file_name
  filename = STDIN.gets.chomp
  until File.exists?(filename) || filename == ''
    puts "please enter valid file name".center(@width)
    filename = STDIN.gets.chomp
  end
  filename
end

def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort =  line.chomp.split(',')
      add_students(name,cohort)
    end
  end
  puts "Loaded #{@students.count} #{plural_students? ? "students" : "student"} from #{filename}".center(@width)
end

def save_students(filename)
  File.open(filename,"w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
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
    puts "Now we have #{@students.count} #{plural_students? ? "students" : "student"}".center(@width)
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
puts "Overall, we have #{@students.count} great #{plural_students? ? "students" : "student"}".center(@width)
end

def plural_students?
  @students.count > 1
end

try_load_students
interactive_menu
