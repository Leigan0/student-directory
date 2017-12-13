

def input_students
  width = 65
  puts "Please enter students details".center(width)
  puts "To finish, just hit return twice".center(width)
  #create an empty array
  students = []
  #get first name
  name = gets.chomp
  #while the name is not empty - repeat this code
  while !name.empty? do
    puts "Please enter student age".center(width)
    age = gets.chomp
    puts "Please enter student nationality".center(width)
    nationality = gets.chomp
    students << {name: name, cohort: :november, age: age, nationality: nationality}
    puts "Now we have #{students.count} students".center(width)
    name = gets.chomp
  end
  #return array of students
  students
end

def print_header
  width = 65
  puts "The students of Villains Academy".center(width)
  puts "-------------".center(width)
end

def print(students)
  width = 65
  counter = 0
  while counter < students.count
        puts " #{counter+1}. #{students[counter][:name]}, #{students[counter][:age]}, #{students[counter][:nationality]} (#{students[counter][:cohort]} cohort)".center(width)
      counter += 1
    end
end

def print_footer(students)
  width = 65
  puts "Overall, we have #{students.count} great students".center(width)
end
#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
