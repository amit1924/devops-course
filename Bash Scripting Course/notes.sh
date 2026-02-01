#!/bin/bash
# =============================================================================
# BASH SCRIPTING EXAMPLES WITH DETAILED COMMENTS AND SAMPLE OUTPUTS
# This script demonstrates various Bash programming concepts with inline comments
# showing what each section produces
# =============================================================================

# -----------------------------------------------------------------------------
# SECTION 1: BASIC OUTPUT AND VARIABLES
# -----------------------------------------------------------------------------

echo "hello world"
# Output: hello world

name="Alice"
echo "Hello, $name!"
# Output: Hello, Alice!

# -----------------------------------------------------------------------------
# SECTION 2: FOR LOOPS - DIFFERENT SYNTAXES
# -----------------------------------------------------------------------------

# Example 1: Brace expansion for loop
echo "Loop using brace expansion {1..5}:"
for i in {1..5}; do
    echo "Number: $i"
done
# Output:
# Loop using brace expansion {1..5}:
# Number: 1
# Number: 2
# Number: 3
# Number: 4
# Number: 5

echo ""

# Example 2: C-style for loop
echo "Loop using C-style syntax ((j=1;j<=max;j++)):"
max=10
for ((j=1; j<=max; j++)); do
    echo "Number: $j"
done
# Output:
# Loop using C-style syntax ((j=1;j<=max;j++)):
# Number: 1
# Number: 2
# ...
# Number: 10

echo ""

# Example 3: Using seq command (more flexible)
echo "Loop using seq command:"
max=4
for j in $(seq 1 "$max"); do
    echo "Number: $j"
done
# Output:
# Loop using seq command:
# Number: 1
# Number: 2
# Number: 3
# Number: 4

echo ""

# Example 4: Seq with step/increment value
echo "Loop with step value (increment by 2):"
for k in $(seq 1 2 10); do
    echo "The Number is: $k"
done
# Output:
# Loop with step value (increment by 2):
# The Number is: 1
# The Number is: 3
# The Number is: 5
# The Number is: 7
# The Number is: 9

echo ""

# -----------------------------------------------------------------------------
# SECTION 3: USER INPUT AND ARGUMENTS
# -----------------------------------------------------------------------------

# Taking interactive user input
read -p "Enter your favorite color: " color
# User enters: blue
echo "Your favorite color is $color"
# Output: Your favorite color is blue
echo "Thank you for sharing your favorite color!"
# Output: Thank you for sharing your favorite color!

echo ""

# Note: To run with piped input: echo "red" | ./script.sh
# Output would be:
# Enter your favorite color: Your favorite color is red
# Thank you for sharing your favorite color!

# Taking input from command-line arguments (non-interactive)
# Usage: ./script.sh Bob
name=$1  # Assuming argument is "Bob"
echo "Welcome, $name!"
# Output: Welcome, Bob!

echo ""

# -----------------------------------------------------------------------------
# SECTION 4: CONDITIONAL STATEMENTS
# -----------------------------------------------------------------------------

# Traditional test syntax (compatible with older shells)
if [ "$color" == "blue" ]; then
    echo "Blue is a cool color!"
else
    echo "$color is a nice color too!"
fi
# Output (if color is "blue"): Blue is a cool color!
# Output (if color is "red"): red is a nice color too!

echo ""

# Modern bash syntax (safer, more features)
if [[ "$color" == "green" ]]; then
    echo "Green is the color of nature!"
else
    echo "$color is a beautiful color!"
fi
# Output (if color is "blue"): blue is a beautiful color!
# Output (if color is "green"): Green is the color of nature!

echo ""

# -----------------------------------------------------------------------------
# SECTION 5: HANDLING MULTIPLE ARGUMENTS
# -----------------------------------------------------------------------------

# "$@" expands to all positional parameters as separate words
echo "Processing all command-line arguments:"
# Assuming script called as: ./script.sh red blue green
for thing in "$@"; do
    echo "You passed: $thing"
done
# Output:
# Processing all command-line arguments:
# You passed: red
# You passed: blue
# You passed: green

echo ""

# -----------------------------------------------------------------------------
# SECTION 6: FUNCTIONS AND VARIABLE SCOPE
# -----------------------------------------------------------------------------

# Function definition with parameter
greet() {
    local person_name=$1  # 'local' makes variable function-scoped
    echo "Greetings, $person_name!"
}

# Function calls
greet "Charlie"
# Output: Greetings, Charlie!
greet "$name"  # Assuming name is still "Bob" from earlier
# Output: Greetings, Bob!

echo ""

# Example showing global variable modification (without 'local')
echo "Demonstrating variable scope (without 'local'):"
name="Amish"
hello() {
    name="Amit"  # This modifies the global variable
}
hello
echo "Hello! $name"
# Output:
# Demonstrating variable scope (without 'local'):
# Hello! Amit  # Global variable was changed

echo ""

# Example showing local variable (with 'local')
echo "Demonstrating variable scope (with 'local'):"
name="Rahul"
hi() {
    local name="Rashmi"  # This variable is local to the function
    echo "Inside function: $name"  # Prints: Rashmi
}
hi
echo "Outside function: $name"
# Output:
# Demonstrating variable scope (with 'local'):
# Inside function: Rashmi
# Outside function: Rahul  # Global variable unchanged

echo ""

# -----------------------------------------------------------------------------
# SECTION 7: FUNCTIONS WITH RETURN VALUES
# -----------------------------------------------------------------------------

# Function that calculates and returns sum
sum() {
    local a=$1
    local b=$2
    local result=$((a + b))
    
    echo "The sum of $a and $b is: "
    echo "$result"
}
sum 3 5
# Output:
# The sum of 3 and 5 is: 
# 8

echo ""

# Function with hardcoded values
mul() {
    local a=5
    local b=8
    local result=$((a * b))
    
    echo "The multiplication of $a and $b is: "
    echo "$result"
}
mul
# Output:
# The multiplication of 5 and 8 is: 
# 40

echo ""

# -----------------------------------------------------------------------------
# SECTION 8: FILE OPERATIONS
# -----------------------------------------------------------------------------

# Check if file exists
if [[ -e file.txt ]]; then
    echo "file.txt exists"
else
    echo "file.txt doesn't exist"
fi
# Output (if file.txt doesn't exist): file.txt doesn't exist
# Output (if file.txt exists): file.txt exists

echo ""

# While loop that runs while file exists
# Note: This will run indefinitely if file1.txt exists
echo "Checking for file1.txt existence (Ctrl+C to stop if running):"
while [[ -e file1.txt ]]; do
    echo "file1.txt exists"
    sleep 1
done
echo "file1.txt is deleted"
# Output (if file1.txt exists initially):
# Checking for file1.txt existence (Ctrl+C to stop if running):
# file1.txt exists
# file1.txt exists
# ... (repeats every second until file is deleted)
# file1.txt is deleted
# Output (if file1.txt doesn't exist):
# Checking for file1.txt existence (Ctrl+C to stop if running):
# file1.txt is deleted

echo ""

# -----------------------------------------------------------------------------
# SECTION 9: FORMATTED OUTPUT
# -----------------------------------------------------------------------------

# Using echo with -e flag for escape sequences
echo "Using echo -e for newlines:"
echo -e "hello\nworld"
# Output:
# Using echo -e for newlines:
# hello
# world

echo ""

# Variables with newlines in output
greeting="Hello"
name="Alice"
echo -e "$greeting\n$name"
# Output:
# Hello
# Alice

echo ""

# Heredoc for multi-line strings
echo "Using heredoc for multi-line output:"
cat <<EOF
This is a multi-line string.
It can span multiple lines.
No escape sequences needed.
EOF
# Output:
# Using heredoc for multi-line output:
# This is a multi-line string.
# It can span multiple lines.
# No escape sequences needed.

echo ""

# printf for precise formatting (recommended)
echo "Using printf for formatted output:"
printf "Name: %s\nAge: %d\n" "Amit" 38
# Output:
# Using printf for formatted output:
# Name: Amit
# Age: 38

echo ""

# Tab-separated values with printf
echo "Tab-separated output using printf:"
printf "Name\tAge\tCity\n"
printf "Amit\t38\tPatna\n"
printf "Rahul\t25\tDelhi\n"
# Output:
# Tab-separated output using printf:
# Name    Age     City
# Amit    38      Patna
# Rahul   25      Delhi

echo ""

# -----------------------------------------------------------------------------
# SECTION 10: CASE STATEMENTS (SWITCH-CASE)
# -----------------------------------------------------------------------------

read -p "Enter a fruit: " fruit
# User enters: apple
case $fruit in
    "apple")
        echo "You selected apple. Apples are crunchy!"
        ;;
    "banana")
        echo "You selected banana. Bananas are rich in potassium!"
        ;;
    "orange")
        echo "You selected orange. Oranges are full of vitamin C!"
        ;;
    *)
        echo "Unknown fruit. Please try apple, banana, or orange."
        ;;
esac
# Output (if user enters "apple"):
# Enter a fruit: apple
# You selected apple. Apples are crunchy!
# Output (if user enters "mango"):
# Enter a fruit: mango
# Unknown fruit. Please try apple, banana, or orange.

echo ""

# -----------------------------------------------------------------------------
# SECTION 11: INDEXED ARRAYS
# -----------------------------------------------------------------------------

echo "Working with Indexed Arrays:"

# Array declaration and initialization
fruits=("apple" "banana" "cherry")

# Accessing array elements
echo "First fruit: ${fruits[0]}"
# Output: First fruit: apple
echo "All fruits: ${fruits[@]}"
# Output: All fruits: apple banana cherry

echo ""

# Looping through array
echo "Looping through fruits array:"
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done
# Output:
# Looping through fruits array:
# Fruit: apple
# Fruit: banana
# Fruit: cherry

echo ""

# Modifying array elements
fruits[0]="blueberry"
echo "Updated first fruit: ${fruits[0]}"
# Output: Updated first fruit: blueberry
echo "All fruits after update: ${fruits[@]}"
# Output: All fruits after update: blueberry banana cherry

echo ""

# Copying an array
new_fruits=("${fruits[@]}")
echo "Copied fruits array: ${new_fruits[@]}"
# Output: Copied fruits array: blueberry banana cherry

echo ""

# -----------------------------------------------------------------------------
# SECTION 12: ASSOCIATIVE ARRAYS (HASH MAPS / DICTIONARIES)
# -----------------------------------------------------------------------------

echo "Working with Associative Arrays:"

# Declare associative array (requires Bash 4.0+)
declare -A colors

# Initialize associative array
colors=(
    ["apple"]="red"
    ["banana"]="yellow"
    ["grape"]="purple"
)

# Accessing values
echo "Color of apple: ${colors["apple"]}"
# Output: Color of apple: red

echo ""

# Looping through associative array
echo "All fruits and their colors:"
for fruit in "${!colors[@]}"; do
    echo "$fruit is ${colors[$fruit]}"
done
# Output (order may vary):
# All fruits and their colors:
# apple is red
# banana is yellow
# grape is purple

echo ""

# Counting elements in associative array
echo "Total colors in array: ${#colors[@]}"
# Output: Total colors in array: 3

echo ""

# Deleting a key-value pair
unset colors["banana"]
echo "After deleting 'banana':"
echo "Remaining fruits and colors:"
for fruit in "${!colors[@]}"; do
    echo "$fruit is ${colors[$fruit]}"
done
# Output (order may vary):
# After deleting 'banana':
# Remaining fruits and colors:
# apple is red
# grape is purple
echo "Total colors after deletion: ${#colors[@]}"
# Output: Total colors after deletion: 2

echo ""

for key in "${!colors[@]}";do
    echo "The key is :"
    echo "$key is ${colors[$key]}"
done

# -----------------------------------------------------------------------------
# SECTION 13: ARRAY TYPE COMPARISON
# -----------------------------------------------------------------------------
echo "Array Type Summary:"
echo "🗂️  Normal arrays use numbers as indices: arr[0]='Apple'"
echo "🧾 Associative arrays use strings as keys: student['name']='Amit'"
echo "🔑 \${!colors[@]} gives all keys"
echo "🔢 \${colors[@]} gives all values"
# Output:
# Array Type Summary:
# 🗂️  Normal arrays use numbers as indices: arr[0]='Apple'
# 🧾 Associative arrays use strings as keys: student['name']='Amit'
# 🔑 ${!colors[@]} gives all keys
# 🔢 ${colors[@]} gives all values

echo ""

#!/bin/bash

# =============================================================================
# IFS (INTERNAL FIELD SEPARATOR) - COMPLETE GUIDE
# =============================================================================

echo "========================================================================"
echo "            COMPLETE GUIDE TO IFS (INTERNAL FIELD SEPARATOR)"
echo "========================================================================"

# -----------------------------------------------------------------------------
# SECTION 1: THEORY & CONCEPT
# -----------------------------------------------------------------------------
echo ""
echo "1. THEORY & CONCEPT"
echo "==================="
echo "IFS = Internal Field Separator"
echo ""
echo "WHAT IT IS:"
echo "-----------"
echo "• IFS is a special shell variable"
echo "• It determines how Bash recognizes word boundaries"
echo "• Used by: read, for loops, parameter expansion, command substitution"
echo ""
echo "DEFAULT VALUE:"
echo "--------------"
echo "• Default IFS = space, tab, newline"
echo "• Represented as: $' \t\n' (space, tab, newline)"
echo ""
echo "IMPORTANCE:"
echo "-----------"
echo "• Controls how strings are split into fields/words"
echo "• Critical for parsing input correctly"
echo "• Often needs adjustment for CSV, colon-delimited files, etc."
echo ""

# -----------------------------------------------------------------------------
# SECTION 2: SYNTAX & USAGE
# -----------------------------------------------------------------------------
echo ""
echo "2. SYNTAX & USAGE"
echo "================="
echo ""
echo "BASIC SYNTAX:"
echo "-------------"
echo "• Set IFS:    IFS='delimiter'"
echo "• Reset IFS:  IFS=\$' \t\n'  or  unset IFS"
echo "• Save/Restore: OLD_IFS=\"\$IFS\"; IFS=':'; ...; IFS=\"\$OLD_IFS\""
echo ""
echo "COMMON DELIMITERS:"
echo "------------------"
echo "• Space only:        IFS=' '"
echo "• Colon:             IFS=':'"
echo "• Comma:             IFS=','"
echo "• Newline only:      IFS=\$'\\n'"
echo "• Tab only:          IFS=\$'\\t'"
echo "• Multiple:          IFS=' :,'  (space, colon, comma)"
echo "• Custom:            IFS='|'    (pipe)"
echo ""

# -----------------------------------------------------------------------------
# SECTION 3: PRACTICAL EXAMPLES WITH OUTPUT
# -----------------------------------------------------------------------------
echo ""
echo "3. PRACTICAL EXAMPLES WITH OUTPUT"
echo "=================================="

# -----------------------------------------------------------------------------
# Example 1: DEFAULT IFS BEHAVIOR (space, tab, newline)
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 1: DEFAULT IFS BEHAVIOR"
echo "--------------------------------"
echo "Code:"
echo "data=\"apple banana cherry\""
echo "for fruit in \$data; do"
echo "    echo \"Fruit: \$fruit\""
echo "done"

data="apple banana cherry"
echo "Output:"
for fruit in $data; do
    echo "Fruit: $fruit"
done
# Output:
# Fruit: apple
# Fruit: banana
# Fruit: cherry

# -----------------------------------------------------------------------------
# Example 2: CUSTOM IFS WITH COLON
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 2: CUSTOM IFS WITH COLON (:)"
echo "-------------------------------------"
echo "Code:"
echo "PATH_STRING=\"/usr/bin:/bin:/usr/local/bin\""
echo "OLD_IFS=\"\$IFS\""
echo "IFS=':'"
echo "for dir in \$PATH_STRING; do"
echo "    echo \"Directory: \$dir\""
echo "done"
echo "IFS=\"\$OLD_IFS\""

PATH_STRING="/usr/bin:/bin:/usr/local/bin"
OLD_IFS="$IFS"
IFS=':'
echo "Output:"
for dir in $PATH_STRING; do
    echo "Directory: $dir"
done
IFS="$OLD_IFS"
# Output:
# Directory: /usr/bin
# Directory: /bin
# Directory: /usr/local/bin

# -----------------------------------------------------------------------------
# Example 3: IFS WITH read COMMAND
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 3: IFS WITH read COMMAND"
echo "---------------------------------"
echo "Code:"
echo "line=\"John:Doe:30:Engineer\""
echo "OLD_IFS=\"\$IFS\""
echo "IFS=':'"
echo "read first_name last_name age profession <<< \"\$line\""
echo "IFS=\"\$OLD_IFS\""
echo "echo \"First: \$first_name\""
echo "echo \"Last: \$last_name\""
echo "echo \"Age: \$age\""
echo "echo \"Profession: \$profession\""

line="John:Doe:30:Engineer"
OLD_IFS="$IFS"
IFS=':'
read first_name last_name age profession <<< "$line"
IFS="$OLD_IFS"
echo "Output:"
echo "First: $first_name"
echo "Last: $last_name"
echo "Age: $age"
echo "Profession: $profession"
# Output:
# First: John
# Last: Doe
# Age: 30
# Profession: Engineer

# -----------------------------------------------------------------------------
# Example 4: IFS WITH NEWLINE ONLY
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 4: IFS WITH NEWLINE ONLY (preserving spaces)"
echo "-----------------------------------------------------"
echo "Code:"
echo "text=\"Hello World\\nThis is a test\\nMultiple   spaces\""
echo "OLD_IFS=\"\$IFS\""
echo "IFS=\$'\\n'"
echo "for line in \$text; do"
echo "    echo \"Line: '\$line'\""
echo "done"
echo "IFS=\"\$OLD_IFS\""

text=$'Hello World\nThis is a test\nMultiple   spaces'
OLD_IFS="$IFS"
IFS=$'\n'
echo "Output:"
for line in $text; do
    echo "Line: '$line'"
done
IFS="$OLD_IFS"
# Output:
# Line: 'Hello World'
# Line: 'This is a test'
# Line: 'Multiple   spaces'  # Spaces preserved!

# -----------------------------------------------------------------------------
# Example 5: IFS WITH COMMA (CSV parsing)
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 5: IFS WITH COMMA (CSV parsing)"
echo "----------------------------------------"
echo "Code:"
echo "csv_data=\"apple,banana,cherry,dragon fruit\""
echo "OLD_IFS=\"\$IFS\""
echo "IFS=','"
echo "declare -a fruits"
echo "fruits=(\$csv_data)"
echo "IFS=\"\$OLD_IFS\""
echo "echo \"Total fruits: \${#fruits[@]}\""
echo "for ((i=0; i<\${#fruits[@]}; i++)); do"
echo "    echo \"Fruit \$((i+1)): \${fruits[i]}\""
echo "done"

csv_data="apple,banana,cherry,dragon fruit"
OLD_IFS="$IFS"
IFS=','
declare -a fruits
fruits=($csv_data)
IFS="$OLD_IFS"
echo "Output:"
echo "Total fruits: ${#fruits[@]}"
for ((i=0; i<${#fruits[@]}; i++)); do
    echo "Fruit $((i+1)): ${fruits[i]}"
done
# Output:
# Total fruits: 4
# Fruit 1: apple
# Fruit 2: banana
# Fruit 3: cherry
# Fruit 4: dragon fruit

# -----------------------------------------------------------------------------
# Example 6: IFS WITH MULTIPLE DELIMITERS
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 6: IFS WITH MULTIPLE DELIMITERS"
echo "----------------------------------------"
echo "Code:"
echo "data=\"apple:banana,cherry;date fruit\""
echo "OLD_IFS=\"\$IFS\""
echo "IFS=':;,'"
echo "for item in \$data; do"
echo "    echo \"Item: \$item\""
echo "done"
echo "IFS=\"\$OLD_IFS\""

data="apple:banana,cherry;date fruit"
OLD_IFS="$IFS"
IFS=':;,'
echo "Output:"
for item in $data; do
    echo "Item: $item"
done
IFS="$OLD_IFS"
# Output:
# Item: apple
# Item: banana
# Item: cherry
# Item: date fruit

# -----------------------------------------------------------------------------
# Example 7: IFS FOR SPLITTING COMMAND OUTPUT
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 7: IFS FOR SPLITTING COMMAND OUTPUT"
echo "--------------------------------------------"
echo "Code:"
echo "OLD_IFS=\"\$IFS\""
echo "IFS=\$'\\n'"
echo "files=\$(ls -1 | head -5)"
echo "echo \"First 5 files in directory:\""
echo "counter=1"
echo "for file in \$files; do"
echo "    echo \"  \$counter. \$file\""
echo "    ((counter++))"
echo "done"
echo "IFS=\"\$OLD_IFS\""

OLD_IFS="$IFS"
IFS=$'\n'
files=$(ls -1 | head -5)
echo "Output:"
echo "First 5 files in directory:"
counter=1
for file in $files; do
    echo "  $counter. $file"
    ((counter++))
done
IFS="$OLD_IFS"
# Output (example):
# First 5 files in directory:
#   1. file1.txt
#   2. file2.sh
#   3. data.csv
#   4. output.log
#   5. backup.tar.gz

# -----------------------------------------------------------------------------
# Example 8: IFS AND QUOTING (IMPORTANT!)
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 8: IFS AND QUOTING (CRITICAL DIFFERENCE)"
echo "-------------------------------------------------"
echo "Code:"
echo "data=\"one two three\""
echo "echo \"1. Without quotes (uses IFS):\""
echo "for word in \$data; do"
echo "    echo \"   Word: \$word\""
echo "done"
echo ""
echo "echo \"2. With quotes (ignores IFS):\""
echo "for word in \"\$data\"; do"
echo "    echo \"   Word: \$word\""
echo "done"

data="one two three"
echo "Output:"
echo "1. Without quotes (uses IFS):"
for word in $data; do
    echo "   Word: $word"
done

echo ""
echo "2. With quotes (ignores IFS):"
for word in "$data"; do
    echo "   Word: $word"
done
# Output:
# 1. Without quotes (uses IFS):
#    Word: one
#    Word: two
#    Word: three
# 
# 2. With quotes (ignores IFS):
#    Word: one two three

# -----------------------------------------------------------------------------
# SECTION 4: COMMON PATTERNS & BEST PRACTICES
# -----------------------------------------------------------------------------
echo ""
echo "4. COMMON PATTERNS & BEST PRACTICES"
echo "===================================="
echo ""
echo "PATTERN 1: Save and Restore IFS"
echo "--------------------------------"
cat << 'EOF'
# Always save original IFS
OLD_IFS="$IFS"
IFS=':'
# ... your code ...
IFS="$OLD_IFS"
EOF
echo ""
echo "PATTERN 2: Temporary IFS in Subshell"
echo "-------------------------------------"
cat << 'EOF'
# Changes to IFS stay in subshell
(IFS=':'; for item in $PATH; do echo "$item"; done)
# Original IFS unchanged here
EOF
echo ""
echo "PATTERN 3: IFS for Array Creation"
echo "----------------------------------"
cat << 'EOF'
# Create array from delimited string
csv="a,b,c,d"
OLD_IFS="$IFS"
IFS=','
array=($csv)
IFS="$OLD_IFS"
echo "Array has ${#array[@]} elements"
EOF
echo ""
echo "PATTERN 4: IFS with while read loop"
echo "------------------------------------"
cat << 'EOF'
# Process file line by line
while IFS= read -r line; do
    echo "Processing: $line"
done < "file.txt"
# IFS= prevents trimming leading/trailing whitespace
EOF

# -----------------------------------------------------------------------------
# SECTION 5: GOTCHAS & PITFALLS
# -----------------------------------------------------------------------------
echo ""
echo "5. GOTCHAS & PITFALLS"
echo "====================="
echo ""
echo "1. IFS AFFECTS ALL SUBSEQUENT COMMANDS"
echo "   -----------------------------------"
echo "   • Setting IFS affects ALL following commands in scope"
echo "   • Always restore IFS after use"
echo ""
echo "2. IFS AND WHITESPACE"
echo "   ------------------"
echo "   • Default IFS includes space, tab, newline"
echo "   • IFS='' (empty) = no field splitting at all"
echo "   • IFS=$'\\n' = split only on newlines"
echo ""
echo "3. QUOTING VS NON-QUOTING"
echo "   ----------------------"
echo "   • \$variable    → Splits according to IFS"
echo "   • \"\$variable\" → Preserves as single string"
echo ""
echo "4. IFS IN FUNCTIONS"
echo "   ----------------"
echo "   • IFS changes are local to function unless exported"
echo "   • Best practice: Set IFS locally in function"

# -----------------------------------------------------------------------------
# SECTION 6: REAL-WORLD USE CASES
# -----------------------------------------------------------------------------
echo ""
echo "6. REAL-WORLD USE CASES"
echo "======================="
echo ""
echo "USE CASE 1: Parse /etc/passwd"
echo "------------------------------"
cat << 'EOF'
while IFS=':' read -r username pass uid gid desc home shell; do
    echo "User: $username, UID: $uid, Home: $home"
done < /etc/passwd
EOF
echo ""
echo "USE CASE 2: Process CSV file"
echo "-----------------------------"
cat << 'EOF'
while IFS=',' read -r col1 col2 col3; do
    echo "Column1: $col1, Column2: $col2"
done < data.csv
EOF
echo ""
echo "USE CASE 3: Split path variables"
echo "---------------------------------"
cat << 'EOF'
IFS=':' read -ra paths <<< "$PATH"
for path in "${paths[@]}"; do
    if [[ -d "$path" ]]; then
        echo "Valid path: $path"
    fi
done
EOF
echo ""
echo "USE CASE 4: Parse command output"
echo "---------------------------------"
cat << 'EOF'
# Get disk usage, split into components
output=$(df -h / | tail -1)
IFS=' ' read -ra disk_info <<< "$output"
echo "Filesystem: ${disk_info[0]}"
echo "Used: ${disk_info[2]}"
echo "Available: ${disk_info[3]}"
EOF

# -----------------------------------------------------------------------------
# SECTION 7: SUMMARY CHEAT SHEET
# -----------------------------------------------------------------------------
echo ""
echo "7. SUMMARY CHEAT SHEET"
echo "======================"
echo ""
echo "COMMAND                  | EFFECT"
echo "-------------------------|--------------------------------------------"
echo "IFS=':'                 | Split on colon"
echo "IFS=\$'\\n'              | Split only on newlines (preserve spaces)"
echo "IFS=''                  | No splitting at all"
echo "IFS=\$' \\t\\n'          | Reset to default (space, tab, newline)"
echo "unset IFS               | Reset to default"
echo "IFS=':,'                | Split on colon OR comma"
echo ""
echo "read -ra array <<< \"str\" | Read string into array using IFS"
echo "for x in \$string        | Split string using IFS"
echo "for x in \"\$string\"      | No splitting (single item)"
echo ""
echo "BEST PRACTICES:"
echo "• Always save original IFS: OLD_IFS=\"\$IFS\""
echo "• Always restore IFS: IFS=\"\$OLD_IFS\""
echo "• Use subshells for temporary IFS changes"
echo "• Use quotes \"\$var\" when you DON'T want splitting"
echo "• Use IFS= read -r to preserve whitespace in lines"

echo ""
echo "========================================================================"
echo "                     END OF IFS GUIDE"
echo "========================================================================"

# =============================================================================
# END OF SCRIPT
# =============================================================================
echo "Script execution completed successfully!"
# Output: Script execution completed successfully!