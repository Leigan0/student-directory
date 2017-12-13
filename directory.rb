require 'date'

def input_students
  width = 65
  puts "Please enter each students details, starting with student name".center(width)
  puts "To finish, just hit return twice".center(width)
  students = []
  name = gets.delete("\n")
  while !name.empty? do
    puts "please enter student cohort, if blank cohort will default to november"
    cohort = gets.delete("\n")
     until Date::MONTHNAMES.include?(cohort.capitalize) || cohort == ''
       puts "Please enter a valid cohort".center(width)
       cohort = gets.delete("\n")
     end
     if cohort == ''
       cohort = :november
     end
    puts "Please enter student age".center(width)
    age = gets.delete("\n")
    puts "Please enter student nationality".center(width)
    nationality = gets.delete("\n")
    students << {name: name, cohort: cohort.downcase.to_sym, age: age, nationality: nationality}
    students.count > 1 ? puts("Now we have #{students.count} students".center(width)) : puts("Now we have 1 student".center(width))
    name = gets.delete("\n")
  end
  students
end

def print_header
  width = 65
  puts "The students of Villains Academy".center(width)
  puts "-------------".center(width)
end

def print(students)
  width = 65
  return if  students.count < 1
  cohorts = students.map {|student| student[:cohort]}.uniq
  cohorts.each do |cohort|
    students.each do |student|
      if student[:cohort] == cohort then puts "#{student[:name]}, #{student[:age]}, #{student[:nationality]} (#{student[:cohort]} cohort)" end
    end
  end
end

def print_footer(students)
  return if  students.count < 1
  width = 65
  students.count > 1 ? puts("Overall, we have #{students.count} great students".center(width)) : puts("Overall, we have 1 great student")
end

students = input_students
print_header
print(students)
print_footer(students)
