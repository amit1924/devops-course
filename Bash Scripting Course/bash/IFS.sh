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