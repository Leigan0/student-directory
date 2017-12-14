require 'date'

@students = [] #an empty array accessible to all methods
@width = 65

def print_menu
  puts "1. Input the students".center(@width)
  puts "2. Show the students".center(@width)
  puts "3. Save the list to students.csv".center(@width)
  puts "9. Exit".center(@width)
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
      show_students
    when "3"
      save_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again".center(@width)
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def input_students
  input_instruction_text
  name = gets.delete("\n")
  while !name.empty? do
    cohort = cohort_entry
    @students << {name: name, cohort: cohort.downcase.to_sym}
    @students.count > 1 ? puts("Now we have #{@students.count} students".center(@width)) : puts("Now we have 1 student".center(@width))
    name = gets.delete("\n")
  end
end

def input_instruction_text
  puts "Please enter each students details, starting with student name".center(@width)
  puts "To finish, just hit return twice".center(@width)
end

def cohort_entry
  puts "please enter student cohort, if blank cohort will default to november".center(@width)
  cohort = gets.delete("\n")
  until Date::MONTHNAMES.include?(cohort.capitalize) || cohort == ''
    puts "Please enter a valid cohort".center(@width)
    cohort = gets.delete("\n")
  end
  if cohort == ''then cohort = :november end
  return cohort
end

def print_header
  width = 65
  puts "The students of Villains Academy".center(@width)
  puts "-------------".center(@width)
end

def save_students
  #open the file for writing
  file = File.open("students.csv","w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def print_students_list
  return if  @students.count < 1
  cohorts = @students.map {|student| student[:cohort]}.uniq
  cohorts.each do |cohort|
    @students.each do |student|
      if student[:cohort] == cohort
        puts "#{student[:name]} (#{student[:cohort]} cohort)".center(@width)
      end
    end
  end
end

def print_footer
  return if  @students.count == 0
  @students.count > 1 ? puts("Overall, we have #{@students.count} great students".center(@width)) : puts("Overall, we have 1 great student".center(@width))
end

interactive_menu
