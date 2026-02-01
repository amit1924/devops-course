#!/bin/bash

echo "hello world"

name="Alice"
echo "Hello, $name!"

# for loop example
for i in {1..5}; do
  echo "Number: $i"
done

max=10
for  ((j=1;j<=max;j++)); do
   echo "Number: $j"
done   


# seq = sequence
# basic syntax seq START END
max=4
for j in $(seq 1 "$max"); do
   echo "Number: $j"
done

# 📐 Step value (increment)
# seq START STEP END
for k in $(seq 1 2 10);do
   echo "The Number is: $k"
done   


# taking user input
read -p "Enter your favorite color: " color
echo "Your favorite color is $color"
# echo red | ./script.sh
# to run the script and provide input via pipe
echo "Thank you for sharing your favorite color!"

# Take name from ARGUMENT (non-interactive)
name=$1
echo "Welcome, $name!"
# to run the script with argument: ./script.sh Bob

# conditional statement example
if [ "$color" == "blue" ]; then
  echo "Blue is a cool color!"
else
  echo "$color is a nice color too!"
fi


# safer modern syntax
if [[ "$color" == "green" ]]; then
  echo "Green is the color of nature!"
else
  echo "$color is a beautiful color!"
fi

for thing in "$@"; do
  echo "You passed: $thing"
done
# to run the script with multiple arguments: ./script.sh red blue green

# functions
greet() {
    local person_name=$1
    echo "Greetings, $person_name!"
}
greet "Charlie"
greet "$name"

# without local
name="Amish"
hello(){
   name="Amit"
}
hello
echo "Hello ! $name"
# it will print Amit



# global variable
name="Rahul"
hi(){
    local name="Rashmi"
}
hi
echo "$name"
# it will print Rahul

# adding
sum(){
   local a=$1
   local b=$2
   local result=$((a+b))
    
    echo "The sum of a and b is : "
    echo "$result"
   
 
}
sum 3 5

# multiply
Mul(){
   local a=5
   local b=8
   local result=$((a*b))

    echo "The multiplication of a and b is : "
    echo "$result"
   
 
}
Mul 
 

# check if  file is exist or not
if [[ -e file.txt ]];then
    echo "file1.txt is exist"
else
    echo "file.txt doesn't exist"    

fi    


# while loop
while [[ -e file1.txt ]];do
    echo "file1.txt is exist"
    sleep 1 
done

echo "file1.txt is deleted"


# 🧩 Newline (\n) in Bash
echo -e "hello\nworld"

# 🔹Variables with newlines
greeting="Hello"
name="Alice"
echo -e "$greeting\n$name"

# 🔹Multiple lines (HEREDOC style)
cat <<EOF
This is a multi-line string.
It can span multiple lines.
EOF


# Prefer printf when we care about correctness
printf "Name: %s\nAge: %d\n" "Amit" 38


# 🔹 Best way to use \t in Bash
printf "Name\tAge\tCity\n"
printf "Amit\t38\tPatna\n"
# output:
# Name    Age     City
# Amit    38      Patna


# case statements
read -p "Enter a fruit: " fruit
case $fruit in
    "apple")
        echo "You selected apple."
        ;;
    "banana")
        echo "You selected banana."
        ;;
    "orange")
        echo "You selected orange."
        ;;
    *)
        echo "Unknown fruit."
        ;;
esac    


# indexed arrays
fruits=("apple" "banana" "cherry")
echo "First fruit: ${fruits[0]}"
echo "All fruits: ${fruits[@]}"

# loop through array
for fruit in "${fruits[@]}";do
     echo "Fruit: $fruit"
done

# change value
fruits[0]="blueberry"
echo "Updated first fruit: ${fruits[0]}"

# copy array
new_fruits=("${fruits[@]}")
echo "Copied fruits: ${new_fruits[@]}"

# associative arrays
# -A stands for Associative
declare -A colors
colors=( ["apple"]="red" ["banana"]="yellow" ["grape"]="purple" )
echo "Color of apple: ${colors["apple"]}"

# loop through associative array
for fruit in "${!colors[@]}";do
    echo "$fruit is ${colors[$fruit]}"
    # Count Elements
    echo "Total colors: "
    echo ${#colors[@]}  # prints 3
    # Delete key
    unset colors["banana"]
    echo "After deletion:"
    for fruit in "${!colors[@]}";do
        echo "$fruit is ${colors[$fruit]}"
    done
done



# 🗂️ Normal bash arrays use numbers as keys
# 👉 arr[0]="Apple"

# 🧾 Associative arrays use text/string as keys
# 👉 student["name"]="Amit"
# ${!colors[@]} gives all keys of the associative array
# ${colors[$key]} gives all values of the associative array


# IFS (Internal Field Separator)
echo "$IFS"

text="apple,banana,cherry"

for item in $text; do
    echo "Item: $item"
done
# output:
# Item: apple
# Item: banana
# Item: cherry
# 👉 Split happened because space is in IFS

# 🧵 🧠 Example 2 — Change IFS (Comma separated)
data="apple,banana,cherry"
IFS=','

for item in $data; do
    echo "Item: $item"
done
# output:
# Item: apple
# Item: banana
# Item: cherry
# 👉 Split happened because IFS is now comma

# 📝 📥 Example 3 — Using with read
touch data.txt
echo "Amit Patna 38" > data.txt
while IFS=' ' read name city age;do
    echo "Name: $name, City: $city, Age: $age"
done < data.txt
# output:

# COMMAND SUBSTITUTION
name=$(whoami)
echo "Current user: $name"
# Current user: amit

# count files in current directory
file_count=$(ls | wc -l)
echo "Number of files: $file_count"

# 🔁 Nested Command Substitution
result=$(echo "Today is $(date +%A)")
echo "$result"
# Today is Friday

# Airthematic Operations
# ✅ Method 1 — $(()) (Most Common & Best)
result=$((10+5))
echo "Result: $result"
# Result: 15

# ✅ Method 2 — expr (Old School)
res=$(expr 20 + 5)
echo "Result of old school expressions: $res"
# Result: 15
# ⚠ Spaces are COMPULSORY
# Wrong ❌ expr 10+5

# ✅ Method 3 — let
a=50
b=50
let c=a+b
echo $c


# 🔁 3️⃣ Increment / Decrement
a=5
echo $((a++))   # prints 5 then becomes 6
echo $((++a))   # becomes 7 then prints 7

# ⚠️ Common Mistakes

# ❌ Spaces in assignment
# num = 10   # wrong


# PROCESS SUBSTITUTION
# 🧰 📌 Syntax

# There are two forms:

# ✅ 1️⃣ Output as File
# <(command)
echo "uname is:"
echo $(uname)
# Linux
echo <(uname)
# /dev/fd/63

# ✅ 2️⃣ Input as File
# >(command)
# 👉 Sends data into the command

diff <(sort file.txt) <(sort data.txt)

cat <(ls)

# 📥 Compare Two Directory Listings
diff <(ls dir1) <(ls dir2)

# 🧪 Input Redirection Form >( )
echo "Hello Amit" > >(tee output.txt)

# <(cmd) become as /dev/fd/63

# with paste
paste <(ls) <(date)

# cut
echo "Hello World" | cut -c1-5
# ouptut : Hello
# -c1-5 → characters from 1 to 5

echo "123456789" | cut -c3-7
# output:34567




# cut works on files or input text, not directly on a variable .
name="Amit,Patna,25"
echo "$name" | cut -d',' -f1
# -d',' → delimiter is comma
# -f1 → field 1 (Amit)

echo "$name" | cut -d',' -f2
# output:Patna

echo "$name" | cut -d',' -f1,3 
# output:Amit,25

# cut system files
echo "$name" | cut -d ':' -f1
# output :Amit,Patna,25

# ////////////tr/////////////

# 🔤 tr — translate, delete, squeeze characters

# 🔹 1️⃣ Convert Lowercase → Uppercase
echo "The Uppercase :"
echo "amit" | tr a-z A-Z
# output:AMIT

echo "linux" | tr '[:lower:]' '[:upper:]'
# output:LINUX

# 🔹 2️⃣ Delete Characters
# Remove Spaces
echo "H e l l o" | tr -d ' '
# output:Hello

# Remove digits
echo "A1m2i3t4" | tr -d '0-9'
# output:Amit

# 🔹 3️⃣ Replace Characters

# Replace spaces with underscores:
echo "hello world bash" | tr ' ' '_'
# hello_world_bash

# 🔹 4️⃣ Squeeze Repeated Characters

# Useful for extra spaces!
# -s = squeeze repeating characters to single
echo "hello     world" | tr -s ' '
# hello world


# sed=stream editor
# Replace
# sed 's/old/new/' file

echo "Linux is cool" | sed 's/cool/awesome/'
# output :Linux is awesome


# 🔥 Replace ALL occurrences in a line

# Add g (global)
echo "apple apple apple" | sed 's/apple/mango/g'
# output:mango mango mango


# ❌ 2️⃣ Delete Lines
# Delete line 3
# sed '3d' file

# Delete line range
# sed '2,5d' file

# Delete empty lines
# sed '/^$/d' file

# ➕ 3️⃣ Insert & Append
# Insert BEFORE line
# sed '3i\Hello Amit' file

# Append AFTER line
# sed '3a\Hello Amit' file