#!/bin/bash

# =============================================================================
# COMPLETE GUIDE TO ARRAYS & ASSOCIATIVE ARRAYS IN BASH
# =============================================================================

echo "========================================================================"
echo "            COMPLETE GUIDE TO ARRAYS IN BASH"
echo "========================================================================"

# -----------------------------------------------------------------------------
# SECTION 1: THEORY & CONCEPTS
# -----------------------------------------------------------------------------
echo ""
echo "1. THEORY & CONCEPTS"
echo "===================="
echo ""
echo "TYPES OF ARRAYS IN BASH:"
echo "------------------------"
echo "1. INDEXED ARRAYS (Regular Arrays)"
echo "   • Keys are integers (0, 1, 2, ...)"
echo "   • Syntax: declare -a array_name"
echo "   • Default type if not declared"
echo ""
echo "2. ASSOCIATIVE ARRAYS (Hash/Dictionary)"
echo "   • Keys are strings"
echo "   • Syntax: declare -A array_name"
echo "   • Available in Bash 4.0+"
echo ""
echo "KEY DIFFERENCES:"
echo "----------------"
echo "| FEATURE          | INDEXED ARRAY      | ASSOCIATIVE ARRAY   |"
echo "|------------------|--------------------|---------------------|"
echo "| Declaration      | declare -a         | declare -A          |"
echo "| Keys             | Integers (0-based) | Strings             |"
echo "| Order            | Maintained         | Not guaranteed      |"
echo "| Default          | Yes                | No (Bash 4.0+)      |"
echo "| Access           | \${arr[0]}         | \${arr[\"key\"]}    |"
echo "| All Keys         | \${!arr[@]}        | \${!arr[@]}         |"
echo "| All Values       | \${arr[@]}         | \${arr[@]}          |"
echo ""

# -----------------------------------------------------------------------------
# SECTION 2: INDEXED ARRAYS - SYNTAX & EXAMPLES
# -----------------------------------------------------------------------------
echo ""
echo "2. INDEXED ARRAYS - SYNTAX & EXAMPLES"
echo "======================================"

# -----------------------------------------------------------------------------
# Example 1: Declaration and Initialization
# -----------------------------------------------------------------------------
echo ""
echo "EXAMPLE 1: DECLARATION METHODS"
echo "------------------------------"
echo "Code:"

cat << 'EOF'
# Method 1: Direct assignment (auto-indexed)
fruits=("apple" "banana" "cherry")

# Method 2: Explicit declare
declare -a colors
colors=("red" "green" "blue")

# Method 3: Individual element assignment
declare -a days
days[0]="Monday"
days[1]="Tuesday"
days[2]="Wednesday"

# Method 4: With values containing spaces
names=("John Doe" "Jane Smith" "Bob Johnson")

# Method 5: From command output
files=(*.txt)  # All .txt files in current directory
EOF

echo "Output:"
# Execute the code
fruits=("apple" "banana" "cherry")
declare -a colors
colors=("red" "green" "blue")
declare -a days
days[0]="Monday"
days[1]="Tuesday"
days[2]="Wednesday"
names=("John Doe" "Jane Smith" "Bob Johnson")
files=(*.txt)

echo "fruits array: ${fruits[@]}"
echo "colors array: ${colors[@]}"
echo "days array: ${days[@]}"
echo "names array: ${names[@]}"
echo "Number of .txt files: ${#files[@]}"
echo ""

# -----------------------------------------------------------------------------
# Example 2: Accessing Array Elements
# -----------------------------------------------------------------------------
echo "EXAMPLE 2: ACCESSING ELEMENTS"
echo "-----------------------------"
echo "Code:"
echo "fruits=(\"apple\" \"banana\" \"cherry\" \"date\" \"elderberry\")"
echo "echo \"First fruit: \${fruits[0]}\"          # apple"
echo "echo \"Second fruit: \${fruits[1]}\"         # banana"
echo "echo \"Last fruit: \${fruits[-1]}\"          # elderberry"
echo "echo \"Second last: \${fruits[-2]}\"         # date"
echo "echo \"All fruits: \${fruits[@]}\""
echo "echo \"All indices: \${!fruits[@]}\""
echo "echo \"Array length: \${#fruits[@]}\""
echo "echo \"Length of first fruit: \${#fruits[0]}\""

fruits=("apple" "banana" "cherry" "date" "elderberry")
echo "Output:"
echo "First fruit: ${fruits[0]}"
echo "Second fruit: ${fruits[1]}"
echo "Last fruit: ${fruits[-1]}"
echo "Second last: ${fruits[-2]}"
echo "All fruits: ${fruits[@]}"
echo "All indices: ${!fruits[@]}"
echo "Array length: ${#fruits[@]}"
echo "Length of first fruit: ${#fruits[0]}"
echo ""

# -----------------------------------------------------------------------------
# Example 3: Array Slicing and Subarrays
# -----------------------------------------------------------------------------
echo "EXAMPLE 3: ARRAY SLICING"
echo "------------------------"
echo "Code:"
echo "numbers=({0..9})  # Creates array 0 1 2 3 4 5 6 7 8 9"
echo "echo \"Original: \${numbers[@]}\""
echo "echo \"Slice 2-5: \${numbers[@]:2:4}\"      # elements 2,3,4,5"
echo "echo \"Last 3: \${numbers[@]: -3}\"         # last 3 elements"
echo "echo \"From index 5: \${numbers[@]:5}\"     # from index 5 to end"

numbers=({0..9})
echo "Output:"
echo "Original: ${numbers[@]}"
echo "Slice 2-5: ${numbers[@]:2:4}"
echo "Last 3: ${numbers[@]: -3}"
echo "From index 5: ${numbers[@]:5}"
echo ""

# -----------------------------------------------------------------------------
# Example 4: Modifying Arrays
# -----------------------------------------------------------------------------
echo "EXAMPLE 4: MODIFYING ARRAYS"
echo "---------------------------"
echo "Code:"
echo "fruits=(\"apple\" \"banana\" \"cherry\")"
echo "echo \"Original: \${fruits[@]}\""
echo ""
echo "# Add element at the end"
echo "fruits+=(\"date\")"
echo "echo \"After adding date: \${fruits[@]}\""
echo ""
echo "# Insert at specific index"
echo "fruits[1]=\"blueberry\""
echo "echo \"After changing index 1: \${fruits[@]}\""
echo ""
echo "# Remove element (set to empty)"
echo "unset fruits[2]"
echo "echo \"After unset index 2: \${fruits[@]}\""
echo "echo \"Indices now: \${!fruits[@]}\""
echo ""
echo "# Remove and reindex"
echo "fruits=(\"\${fruits[@]}\")"
echo "echo \"After reindexing: \${fruits[@]}\""
echo "echo \"Indices now: \${!fruits[@]}\""

fruits=("apple" "banana" "cherry")
echo "Output:"
echo "Original: ${fruits[@]}"

fruits+=("date")
echo "After adding date: ${fruits[@]}"

fruits[1]="blueberry"
echo "After changing index 1: ${fruits[@]}"

unset fruits[2]
echo "After unset index 2: ${fruits[@]}"
echo "Indices now: ${!fruits[@]}"

fruits=("${fruits[@]}")
echo "After reindexing: ${fruits[@]}"
echo "Indices now: ${!fruits[@]}"
echo ""

# -----------------------------------------------------------------------------
# Example 5: Looping Through Indexed Arrays
# -----------------------------------------------------------------------------
echo "EXAMPLE 5: LOOPING METHODS"
echo "--------------------------"
echo "Code:"

cat << 'EOF'
fruits=("apple" "banana" "cherry" "date")

echo "Method 1: Simple for loop (values only)"
for fruit in "${fruits[@]}"; do
    echo "  Fruit: $fruit"
done

echo -e "\nMethod 2: Loop with index"
for i in "${!fruits[@]}"; do
    echo "  Index $i: ${fruits[i]}"
done

echo -e "\nMethod 3: C-style for loop"
for ((i=0; i<${#fruits[@]}; i++)); do
    echo "  Element $i: ${fruits[i]}"
done

echo -e "\nMethod 4: While loop"
i=0
while [ $i -lt ${#fruits[@]} ]; do
    echo "  While loop: ${fruits[i]}"
    ((i++))
done
EOF

fruits=("apple" "banana" "cherry" "date")
echo "Output:"

echo "Method 1: Simple for loop (values only)"
for fruit in "${fruits[@]}"; do
    echo "  Fruit: $fruit"
done

echo -e "\nMethod 2: Loop with index"
for i in "${!fruits[@]}"; do
    echo "  Index $i: ${fruits[i]}"
done

echo -e "\nMethod 3: C-style for loop"
for ((i=0; i<${#fruits[@]}; i++)); do
    echo "  Element $i: ${fruits[i]}"
done

echo -e "\nMethod 4: While loop"
i=0
while [ $i -lt ${#fruits[@]} ]; do
    echo "  While loop: ${fruits[i]}"
    ((i++))
done
echo ""

# -----------------------------------------------------------------------------
# Example 6: Array Operations
# -----------------------------------------------------------------------------
echo "EXAMPLE 6: ARRAY OPERATIONS"
echo "---------------------------"
echo "Code:"

cat << 'EOF'
# Copy an array
original=("a" "b" "c")
copy=("${original[@]}")
echo "Copy: ${copy[@]}"

# Concatenate arrays
array1=("x" "y" "z")
array2=("1" "2" "3")
combined=("${array1[@]}" "${array2[@]}")
echo "Combined: ${combined[@]}"

# Check if array is empty
empty_array=()
if [ ${#empty_array[@]} -eq 0 ]; then
    echo "Array is empty"
fi

# Check if element exists in array
fruits=("apple" "banana" "cherry")
search="banana"
if [[ " ${fruits[@]} " =~ " ${search} " ]]; then
    echo "'$search' found in array"
fi
EOF

echo "Output:"
original=("a" "b" "c")
copy=("${original[@]}")
echo "Copy: ${copy[@]}"

array1=("x" "y" "z")
array2=("1" "2" "3")
combined=("${array1[@]}" "${array2[@]}")
echo "Combined: ${combined[@]}"

empty_array=()
if [ ${#empty_array[@]} -eq 0 ]; then
    echo "Array is empty"
fi

fruits=("apple" "banana" "cherry")
search="banana"
if [[ " ${fruits[@]} " =~ " ${search} " ]]; then
    echo "'$search' found in array"
fi
echo ""

# -----------------------------------------------------------------------------
# SECTION 3: ASSOCIATIVE ARRAYS - SYNTAX & EXAMPLES
# -----------------------------------------------------------------------------
echo ""
echo "3. ASSOCIATIVE ARRAYS - SYNTAX & EXAMPLES"
echo "=========================================="

# Check Bash version for associative array support
echo "Note: Associative arrays require Bash 4.0+"
echo "Your Bash version: $BASH_VERSION"
echo ""

# -----------------------------------------------------------------------------
# Example 1: Declaration and Initialization
# -----------------------------------------------------------------------------
echo "EXAMPLE 1: DECLARATION METHODS"
echo "------------------------------"
echo "Code:"

cat << 'EOF'
# Method 1: Declare and initialize separately
declare -A student
student["name"]="Alice"
student["age"]="25"
student["grade"]="A"

# Method 2: Declare and initialize together
declare -A colors=(
    ["red"]="#FF0000"
    ["green"]="#00FF00"
    ["blue"]="#0000FF"
)

# Method 3: From variables
name="John"
city="New York"
declare -A person=(
    ["full_name"]="$name"
    ["location"]="$city"
    ["job"]="Engineer"
)
EOF

echo "Output:"
declare -A student
student["name"]="Alice"
student["age"]="25"
student["grade"]="A"
echo "Student: name=${student["name"]}, age=${student["age"]}, grade=${student["grade"]}"

declare -A colors=(
    ["red"]="#FF0000"
    ["green"]="#00FF00"
    ["blue"]="#0000FF"
)
echo "Colors: red=${colors["red"]}, green=${colors["green"]}, blue=${colors["blue"]}"

name="John"
city="New York"
declare -A person=(
    ["full_name"]="$name"
    ["location"]="$city"
    ["job"]="Engineer"
)
echo "Person: name=${person["full_name"]}, location=${person["location"]}, job=${person["job"]}"
echo ""

# -----------------------------------------------------------------------------
# Example 2: Accessing and Modifying
# -----------------------------------------------------------------------------
echo "EXAMPLE 2: ACCESSING AND MODIFYING"
echo "----------------------------------"
echo "Code:"

cat << 'EOF'
declare -A inventory=(
    ["apples"]=50
    ["bananas"]=30
    ["oranges"]=75
)

echo "Current inventory:"
echo "  Apples: ${inventory["apples"]}"
echo "  Bananas: ${inventory["bananas"]}"
echo "  Oranges: ${inventory["oranges"]}"

# Add new item
inventory["grapes"]=40
echo "After adding grapes: ${inventory["grapes"]}"

# Update existing item
inventory["apples"]=$((inventory["apples"] + 10))
echo "Updated apples: ${inventory["apples"]}"

# Remove item
unset inventory["bananas"]
echo "After removing bananas, keys: ${!inventory[@]}"

# Check if key exists
if [[ -v inventory["apples"] ]]; then
    echo "Apples exist in inventory"
fi
EOF

echo "Output:"
declare -A inventory=(
    ["apples"]=50
    ["bananas"]=30
    ["oranges"]=75
)

echo "Current inventory:"
echo "  Apples: ${inventory["apples"]}"
echo "  Bananas: ${inventory["bananas"]}"
echo "  Oranges: ${inventory["oranges"]}"

inventory["grapes"]=40
echo "After adding grapes: ${inventory["grapes"]}"

inventory["apples"]=$((inventory["apples"] + 10))
echo "Updated apples: ${inventory["apples"]}"

unset inventory["bananas"]
echo "After removing bananas, keys: ${!inventory[@]}"

if [[ -v inventory["apples"] ]]; then
    echo "Apples exist in inventory"
fi
echo ""

# -----------------------------------------------------------------------------
# Example 3: Looping Through Associative Arrays
# -----------------------------------------------------------------------------
echo "EXAMPLE 3: LOOPING METHODS"
echo "--------------------------"
echo "Code:"

cat << 'EOF'
declare -A capitals=(
    ["France"]="Paris"
    ["Germany"]="Berlin"
    ["Japan"]="Tokyo"
    ["India"]="New Delhi"
)

echo "Method 1: Loop through keys"
for country in "${!capitals[@]}"; do
    echo "  $country -> ${capitals[$country]}"
done

echo -e "\nMethod 2: Loop through values only"
for capital in "${capitals[@]}"; do
    echo "  Capital: $capital"
done

echo -e "\nMethod 3: Sorted by keys"
for country in $(echo "${!capitals[@]}" | tr ' ' '\n' | sort); do
    echo "  $country: ${capitals[$country]}"
done

echo -e "\nMethod 4: With counter"
counter=1
for country in "${!capitals[@]}"; do
    echo "  $counter. $country - ${capitals[$country]}"
    ((counter++))
done
EOF

echo "Output:"
declare -A capitals=(
    ["France"]="Paris"
    ["Germany"]="Berlin"
    ["Japan"]="Tokyo"
    ["India"]="New Delhi"
)

echo "Method 1: Loop through keys"
for country in "${!capitals[@]}"; do
    echo "  $country -> ${capitals[$country]}"
done

echo -e "\nMethod 2: Loop through values only"
for capital in "${capitals[@]}"; do
    echo "  Capital: $capital"
done

echo -e "\nMethod 3: Sorted by keys"
for country in $(echo "${!capitals[@]}" | tr ' ' '\n' | sort); do
    echo "  $country: ${capitals[$country]}"
done

echo -e "\nMethod 4: With counter"
counter=1
for country in "${!capitals[@]}"; do
    echo "  $counter. $country - ${capitals[$country]}"
    ((counter++))
done
echo ""

# -----------------------------------------------------------------------------
# Example 4: Complex Operations
# -----------------------------------------------------------------------------
echo "EXAMPLE 4: COMPLEX OPERATIONS"
echo "-----------------------------"
echo "Code:"

cat << 'EOF'
# Nested data structure simulation
declare -A employee1=(
    ["name"]="Alice"
    ["department"]="Engineering"
    ["salary"]="80000"
)

declare -A employee2=(
    ["name"]="Bob"
    ["department"]="Sales"
    ["salary"]="75000"
)

declare -A company
company["emp_001"]="${employee1[@]}"
company["emp_002"]="${employee2[@]}"

echo "Company employees:"
for emp_id in "${!company[@]}"; do
    echo "  Employee ID: $emp_id"
    echo "  Details: ${company[$emp_id]}"
done

# Counting occurrences
text="apple banana apple cherry banana apple"
declare -A count
for word in $text; do
    ((count[$word]++))
done

echo -e "\nWord counts:"
for word in "${!count[@]}"; do
    echo "  $word: ${count[$word]}"
done
EOF

echo "Output:"
declare -A employee1=(
    ["name"]="Alice"
    ["department"]="Engineering"
    ["salary"]="80000"
)

declare -A employee2=(
    ["name"]="Bob"
    ["department"]="Sales"
    ["salary"]="75000"
)

declare -A company
company["emp_001"]="${employee1[@]}"
company["emp_002"]="${employee2[@]}"

echo "Company employees:"
for emp_id in "${!company[@]}"; do
    echo "  Employee ID: $emp_id"
    echo "  Details: ${company[$emp_id]}"
done

text="apple banana apple cherry banana apple"
declare -A count
for word in $text; do
    ((count[$word]++))
done

echo -e "\nWord counts:"
for word in "${!count[@]}"; do
    echo "  $word: ${count[$word]}"
done
echo ""

# -----------------------------------------------------------------------------
# SECTION 4: COMPARISON & CONVERSION
# -----------------------------------------------------------------------------
echo ""
echo "4. COMPARISON & CONVERSION"
echo "==========================="
echo ""

echo "CONVERTING INDEXED TO ASSOCIATIVE:"
echo "----------------------------------"
echo "Code:"
echo "indexed=(\"apple\" \"banana\" \"cherry\")"
echo "declare -A associative"
echo "for i in \"\${!indexed[@]}\"; do"
echo "    associative[\"fruit_\$i\"]=\"\${indexed[i]}\""
echo "done"
echo "echo \"Associative array: \${!associative[@]}\""

indexed=("apple" "banana" "cherry")
declare -A associative
for i in "${!indexed[@]}"; do
    associative["fruit_$i"]="${indexed[i]}"
done
echo "Output:"
echo "Associative array keys: ${!associative[@]}"
for key in "${!associative[@]}"; do
    echo "  $key: ${associative[$key]}"
done
echo ""

echo "CONVERTING ASSOCIATIVE TO INDEXED:"
echo "----------------------------------"
echo "Code:"
echo "declare -A assoc=([\"a\"]=\"apple\" [\"b\"]=\"banana\" [\"c\"]=\"cherry\")"
echo "indexed_from_assoc=(\"\${assoc[@]}\")"
echo "echo \"Indexed array: \${indexed_from_assoc[@]}\""

declare -A assoc=(["a"]="apple" ["b"]="banana" ["c"]="cherry")
indexed_from_assoc=("${assoc[@]}")
echo "Output:"
echo "Indexed array: ${indexed_from_assoc[@]}"
echo ""

# -----------------------------------------------------------------------------
# SECTION 5: BEST PRACTICES & COMMON PITFALLS
# -----------------------------------------------------------------------------
echo ""
echo "5. BEST PRACTICES & COMMON PITFALLS"
echo "==================================="
echo ""
echo "BEST PRACTICES:"
echo "---------------"
echo "1. Always quote array expansions: \"\${array[@]}\""
echo "2. Use declare for associative arrays: declare -A"
echo "3. Check Bash version for associative array support"
echo "4. Use \${!array[@]} to get all keys"
echo "5. Use \${#array[@]} to get array length"
echo "6. Save and restore IFS when creating arrays from strings"
echo ""
echo "COMMON PITFALLS:"
echo "----------------"
echo "1. array=\$string - Creates string, not array"
echo "   Correct: array=(\$string)"
echo ""
echo "2. array[@] vs array[*]"
echo "   \"\${array[@]}\" - Each element quoted separately"
echo "   \"\${array[*]}\" - All elements as single string"
echo ""
echo "3. Spaces in array elements"
echo "   Use: array=(\"item 1\" \"item 2\")"
echo "   Not: array=(item 1 item 2) # Creates 4 elements"
echo ""
echo "4. Associative array order is not guaranteed"
echo "   Sort keys if order matters"
echo ""
echo "5. Unset vs setting to empty"
echo "   unset array[0]   # Removes element"
echo "   array[0]=\"\"     # Sets to empty string"
echo ""

# -----------------------------------------------------------------------------
# SECTION 6: REAL-WORLD USE CASES
# -----------------------------------------------------------------------------
echo ""
echo "6. REAL-WORLD USE CASES"
echo "======================="
echo ""
echo "USE CASE 1: Configuration Manager"
echo "----------------------------------"
cat << 'EOF'
declare -A config
config["hostname"]="server01"
config["port"]="8080"
config["timeout"]="30"
config["debug"]="false"

# Access configuration
echo "Server: ${config["hostname"]}:${config["port"]}"
echo "Timeout: ${config["timeout"]} seconds"
EOF
echo ""
echo "USE CASE 2: Student Grade Book"
echo "------------------------------"
cat << 'EOF'
declare -A grades
grades["Alice"]="A"
grades["Bob"]="B"
grades["Charlie"]="C"
grades["Diana"]="A"

# Calculate average, find top student, etc.
echo "Total students: ${#grades[@]}"
echo "Alice's grade: ${grades["Alice"]}"
EOF
echo ""
echo "USE CASE 3: Word Frequency Counter"
echo "----------------------------------"
cat << 'EOF'
text="the quick brown fox jumps over the lazy dog"
declare -A frequency
for word in $text; do
    ((frequency[$word]++))
done

echo "Word frequencies:"
for word in "${!frequency[@]}"; do
    echo "  $word: ${frequency[$word]}"
done
EOF
echo ""
echo "USE CASE 4: Command-line Option Parser"
echo "--------------------------------------"
cat << 'EOF'
declare -A options
while [[ $# -gt 0 ]]; do
    case $1 in
        -u|--user)
            options["user"]="$2"
            shift 2
            ;;
        -p|--port)
            options["port"]="$2"
            shift 2
            ;;
        *)
            options["arguments"]+="$1 "
            shift
            ;;
    esac
done

echo "User: ${options["user"]}"
echo "Port: ${options["port"]}"
EOF

# -----------------------------------------------------------------------------
# SECTION 7: QUICK REFERENCE CHEAT SHEET
# -----------------------------------------------------------------------------
echo ""
echo "7. QUICK REFERENCE CHEAT SHEET"
echo "==============================="
echo ""
echo "INDEXED ARRAYS:"
echo "--------------"
echo "Declaration:      array=()  or  declare -a array"
echo "Initialize:       array=(val1 val2 val3)"
echo "Add element:      array+=(new_value)"
echo "Get element:      \${array[index]}"
echo "All elements:     \${array[@]}  or  \${array[*]}"
echo "All indices:      \${!array[@]}"
echo "Array length:     \${#array[@]}"
echo "Slice:            \${array[@]:start:length}"
echo "Last element:     \${array[-1]}"
echo "Remove:           unset array[index]"
echo ""
echo "ASSOCIATIVE ARRAYS:"
echo "------------------"
echo "Declaration:      declare -A array"
echo "Initialize:       array=([key1]=val1 [key2]=val2)"
echo "Add/Update:       array[key]=value"
echo "Get element:      \${array[key]}"
echo "All keys:         \${!array[@]}"
echo "All values:       \${array[@]}"
echo "Array length:     \${#array[@]}"
echo "Check key exists: [[ -v array[key] ]]"
echo "Remove:           unset array[key]"
echo ""
echo "LOOPING PATTERNS:"
echo "----------------"
echo "# Indexed array"
echo "for item in \"\${array[@]}\"; do"
echo "    echo \"\$item\""
echo "done"
echo ""
echo "# Indexed with index"
echo "for i in \"\${!array[@]}\"; do"
echo "    echo \"\$i: \${array[i]}\""
echo "done"
echo ""
echo "# Associative array"
echo "for key in \"\${!array[@]}\"; do"
echo "    echo \"\$key: \${array[\$key]}\""
echo "done"
echo ""
echo "========================================================================"
echo "                     END OF ARRAYS GUIDE"
echo "========================================================================"