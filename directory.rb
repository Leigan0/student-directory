def input_students
  puts "Please enter students details".center(65)
  puts "To finish, just hit return twice".center(65)
  #create an empty array
  students = []
  #get first name
  name = gets.chomp
  #while the name is not empty - repeat this code
  while !name.empty? do
    puts "Please enter student age".center(65)
    age = gets.chomp
    puts "Please enter student nationality".center(65)
    nationality = gets.chomp
    students << {name: name, cohort: :november, age: age, nationality: nationality}
    puts "Now we have #{students.count} students".center(65)
    name = gets.chomp
  end
  #return array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(65)
  puts "-------------".center(65)
end

def print(students)
  counter = 0
  while counter < students.count
        puts " #{counter+1}. #{students[counter][:name]}, #{students[counter][:age]}, #{students[counter][:nationality]} (#{students[counter][:cohort]} cohort)".center(65)
      counter += 1
    end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(65)
end
#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
