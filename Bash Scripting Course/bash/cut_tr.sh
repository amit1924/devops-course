#!/bin/bash

# =============================================================================
# COMPLETE GUIDE TO CUT AND TR COMMANDS IN BASH
# =============================================================================

echo "========================================================================"
echo "            COMPLETE GUIDE TO cut AND tr COMMANDS"
echo "========================================================================"

# -----------------------------------------------------------------------------
# SECTION 1: cut COMMAND - THEORY & CONCEPTS
# -----------------------------------------------------------------------------
echo ""
echo "1. cut COMMAND - THEORY & CONCEPTS"
echo "=================================="
echo ""
echo "WHAT IS cut?"
echo "------------"
echo "• Extracts sections from each line of input"
echo "• Can extract by: bytes, characters, fields"
echo "• Perfect for structured data (CSV, log files, etc.)"
echo "• Part of GNU coreutils (available everywhere)"
echo ""
echo "BASIC SYNTAX:"
echo "-------------"
echo "cut OPTION... [FILE]..."
echo ""
echo "MAIN OPTIONS:"
echo "------------"
echo "-b, --bytes=LIST        Select by bytes"
echo "-c, --characters=LIST   Select by characters"
echo "-d, --delimiter=DELIM   Use DELIM instead of TAB for field delimiter"
echo "-f, --fields=LIST       Select only these fields"
echo "--complement            Complement the set of selected bytes/fields"
echo "-s, --only-delimited    Do not print lines not containing delimiters"
echo "--output-delimiter=STRING  Use STRING as output delimiter"
echo ""

# -----------------------------------------------------------------------------
# SECTION 2: cut COMMAND - EXAMPLES WITH OUTPUT
# -----------------------------------------------------------------------------

# Create sample data files
echo "Creating sample data files..."
cat > employees.csv << 'EOF'
ID,Name,Department,Salary,Email
101,John Doe,Engineering,75000,john@company.com
102,Jane Smith,Marketing,65000,jane@company.com
103,Bob Johnson,Sales,70000,bob@company.com
104,Alice Brown,Engineering,80000,alice@company.com
105,Charlie Wilson,HR,60000,charlie@company.com
EOF

cat > spaces.txt << 'EOF'
apple    banana  cherry
dog      cat     bird
red      green   blue
EOF

cat > fixed_width.txt << 'EOF'
001John Doe     Engineer 
002Jane Smith   Manager  
003Bob Johnson  Director 
EOF

# -----------------------------------------------------------------------------
# Example 1: cut by Fields (CSV/TSV data)
# -----------------------------------------------------------------------------
echo ""
echo "2. cut BY FIELDS (-f)"
echo "====================="
echo ""

echo "EXAMPLE 1.1: EXTRACT SINGLE FIELD FROM CSV"
echo "------------------------------------------"
echo "Code:"
echo "cut -d',' -f2 employees.csv"
echo ""
echo "Output:"
cut -d',' -f2 employees.csv
echo ""

echo "EXAMPLE 1.2: EXTRACT MULTIPLE FIELDS"
echo "------------------------------------"
echo "Code:"
echo "cut -d',' -f1,3,5 employees.csv"
echo ""
echo "Output:"
cut -d',' -f1,3,5 employees.csv
echo ""

echo "EXAMPLE 1.3: EXTRACT RANGE OF FIELDS"
echo "------------------------------------"
echo "Code:"
echo "cut -d',' -f2-4 employees.csv"
echo ""
echo "Output:"
cut -d',' -f2-4 employees.csv
echo ""

echo "EXAMPLE 1.4: EXTRACT FROM BEGINNING/END"
echo "---------------------------------------"
echo "Code:"
echo "cut -d',' -f-3 employees.csv   # First 3 fields"
echo "cut -d',' -f3- employees.csv   # From field 3 to end"
echo ""
echo "Output:"
echo "First 3 fields:"
cut -d',' -f-3 employees.csv
echo ""
echo "From field 3 to end:"
cut -d',' -f3- employees.csv
echo ""

echo "EXAMPLE 1.5: CHANGE OUTPUT DELIMITER"
echo "------------------------------------"
echo "Code:"
echo "cut -d',' -f1,2,4 --output-delimiter=' | ' employees.csv"
echo ""
echo "Output:"
cut -d',' -f1,2,4 --output-delimiter=' | ' employees.csv
echo ""

echo "EXAMPLE 1.6: SKIP LINES WITHOUT DELIMITER"
echo "-----------------------------------------"
echo "Code:"
echo "echo 'This line has no comma' | cut -d',' -f1 -s"
echo "echo 'This,line has comma' | cut -d',' -f1 -s"
echo ""
echo "Output:"
echo 'This line has no comma' | cut -d',' -f1 -s
echo 'This,line has comma' | cut -d',' -f1 -s
echo ""

# -----------------------------------------------------------------------------
# Example 2: cut by Characters
# -----------------------------------------------------------------------------
echo ""
echo "3. cut BY CHARACTERS (-c)"
echo "========================="
echo ""

echo "EXAMPLE 2.1: EXTRACT FIXED CHARACTER POSITIONS"
echo "----------------------------------------------"
echo "Code:"
echo "cut -c1-3 fixed_width.txt    # First 3 chars (ID)"
echo "cut -c4-15 fixed_width.txt   # Name field"
echo "cut -c16-25 fixed_width.txt  # Title field"
echo ""
echo "Output:"
echo "First 3 chars (ID):"
cut -c1-3 fixed_width.txt
echo ""
echo "Name field (chars 4-15):"
cut -c4-15 fixed_width.txt
echo ""
echo "Title field (chars 16-25):"
cut -c16-25 fixed_width.txt
echo ""

echo "EXAMPLE 2.2: EXTRACT SPECIFIC CHARACTERS"
echo "----------------------------------------"
echo "Code:"
echo "echo 'abcdefghij' | cut -c1,3,5,7,9"
echo "echo '1234567890' | cut -c2-5,8-"
echo ""
echo "Output:"
echo 'abcdefghij' | cut -c1,3,5,7,9
echo '1234567890' | cut -c2-5,8-
echo ""

# -----------------------------------------------------------------------------
# Example 3: cut by Bytes
# -----------------------------------------------------------------------------
echo ""
echo "4. cut BY BYTES (-b)"
echo "===================="
echo "Similar to -c but for multi-byte characters (UTF-8)"
echo ""

echo "EXAMPLE: BYTE VS CHARACTER FOR MULTIBYTE"
echo "----------------------------------------"
echo "Code:"
echo "echo 'café' | cut -c1-3    # Characters"
echo "echo 'café' | cut -b1-4    # Bytes (é is 2 bytes)"
echo ""
echo "Output:"
echo 'café' | cut -c1-3
echo 'café' | cut -b1-4
echo ""

# -----------------------------------------------------------------------------
# Example 4: cut with Complement
# -----------------------------------------------------------------------------
echo ""
echo "5. cut WITH COMPLEMENT"
echo "======================"
echo ""

echo "EXAMPLE: EXCLUDE SPECIFIC FIELDS"
echo "--------------------------------"
echo "Code:"
echo "echo 'Original: all fields'"
echo "cut -d',' -f1,2,3,4,5 employees.csv | head -2"
echo ""
echo "echo 'Exclude field 3:'"
echo "cut -d',' -f3 --complement employees.csv | head -2"
echo ""
echo "Output:"
echo "Original: all fields"
cut -d',' -f1,2,3,4,5 employees.csv | head -2
echo ""
echo "Exclude field 3:"
cut -d',' -f3 --complement employees.csv | head -2
echo ""

# -----------------------------------------------------------------------------
# SECTION 3: tr COMMAND - THEORY & CONCEPTS
# -----------------------------------------------------------------------------
echo ""
echo "6. tr COMMAND - THEORY & CONCEPTS"
echo "================================="
echo ""
echo "WHAT IS tr (translate)?"
echo "-----------------------"
echo "• Translates, squeezes, or deletes characters"
echo "• Works on STDIN, writes to STDOUT"
echo "• Simple but powerful for character manipulation"
echo "• Part of GNU coreutils"
echo ""
echo "BASIC SYNTAX:"
echo "-------------"
echo "tr [OPTION]... SET1 [SET2]"
echo ""
echo "MAIN OPERATIONS:"
echo "---------------"
echo "1. Translation:    tr 'abc' 'ABC'   # a→A, b→B, c→C"
echo "2. Deletion:       tr -d 'abc'      # Delete a,b,c"
echo "3. Squeeze:        tr -s ' '        # Squeeze spaces"
echo "4. Complement:     tr -c 'a-z' ' '  # Replace non-lowercase with space"
echo "5. Delete/Complement: tr -cd 'a-z'  # Delete non-lowercase"
echo ""
echo "COMMON OPTIONS:"
echo "--------------"
echo "-d, --delete         Delete characters in SET1"
echo "-s, --squeeze-repeats  Replace sequence with single occurrence"
echo "-c, -C, --complement  Use complement of SET1"
echo "-t, --truncate-set1  Truncate SET1 to length of SET2"
echo ""

# -----------------------------------------------------------------------------
# SECTION 4: tr COMMAND - EXAMPLES WITH OUTPUT
# -----------------------------------------------------------------------------

# Create more sample data
cat > sample.txt << 'EOF'
Hello World!
This is a TEST file.
It has 123 numbers AND some SYMBOLS: !@#$%
Multiple    spaces    here.
UPPERCASE lowercase MiXeD CaSe
EOF

cat > dna.txt << 'EOF'
ATCG
GCTA
TTAA
CCGG
EOF

# -----------------------------------------------------------------------------
# Example 5: Basic Translation
# -----------------------------------------------------------------------------
echo ""
echo "7. tr - BASIC TRANSLATION"
echo "========================="
echo ""

echo "EXAMPLE 5.1: CASE CONVERSION"
echo "----------------------------"
echo "Code:"
echo "echo 'Hello World' | tr 'a-z' 'A-Z'"
echo "echo 'HELLO WORLD' | tr 'A-Z' 'a-z'"
echo ""
echo "Output:"
echo 'Hello World' | tr 'a-z' 'A-Z'
echo 'HELLO WORLD' | tr 'A-Z' 'a-z'
echo ""

echo "EXAMPLE 5.2: ROT13 CIPHER"
echo "-------------------------"
echo "Code:"
echo "echo 'Secret Message' | tr 'A-Za-z' 'N-ZA-Mn-za-m'"
echo "echo 'Frperg Zrffntr' | tr 'A-Za-z' 'N-ZA-Mn-za-m'"
echo ""
echo "Output:"
echo 'Secret Message' | tr 'A-Za-z' 'N-ZA-Mn-za-m'
echo 'Frperg Zrffntr' | tr 'A-Za-z' 'N-ZA-Mn-za-m'
echo ""

echo "EXAMPLE 5.3: DNA COMPLEMENT"
echo "---------------------------"
echo "Code:"
echo "cat dna.txt"
echo "echo 'Complement:'"
echo "cat dna.txt | tr 'ATCG' 'TAGC'"
echo ""
echo "Output:"
cat dna.txt
echo "Complement:"
cat dna.txt | tr 'ATCG' 'TAGC'
echo ""

echo "EXAMPLE 5.4: BRACKET CONVERSION"
echo "-------------------------------"
echo "Code:"
echo "echo '{apple} [banana] (cherry)' | tr '{}[]()' '(){}[]'"
echo ""
echo "Output:"
echo '{apple} [banana] (cherry)' | tr '{}[]()' '(){}[]'
echo ""

# -----------------------------------------------------------------------------
# Example 6: Character Deletion
# -----------------------------------------------------------------------------
echo ""
echo "8. tr - CHARACTER DELETION (-d)"
echo "==============================="
echo ""

echo "EXAMPLE 6.1: DELETE SPECIFIC CHARACTERS"
echo "---------------------------------------"
echo "Code:"
echo "echo 'Hello, World! 123' | tr -d ',! '"
echo "echo 'Phone: (123) 456-7890' | tr -d '() -'"
echo ""
echo "Output:"
echo 'Hello, World! 123' | tr -d ',! '
echo 'Phone: (123) 456-7890' | tr -d '() -'
echo ""

echo "EXAMPLE 6.2: DELETE NON-DIGITS"
echo "------------------------------"
echo "Code:"
echo "echo 'Price: $19.99 + tax' | tr -cd '0-9.'"
echo ""
echo "Output:"
echo 'Price: $19.99 + tax' | tr -cd '0-9.'
echo ""

echo "EXAMPLE 6.3: DELETE NON-PRINTABLE CHARACTERS"
echo "--------------------------------------------"
echo "Code:"
echo "echo -e 'Hello\\tWorld\\nTest' | tr -d '\\t\\n'"
echo ""
echo "Output:"
echo -e 'Hello\tWorld\nTest' | tr -d '\t\n'
echo ""

# -----------------------------------------------------------------------------
# Example 7: Squeeze Repeats
# -----------------------------------------------------------------------------
echo ""
echo "9. tr - SQUEEZE REPEATS (-s)"
echo "============================"
echo ""

echo "EXAMPLE 7.1: SQUEEZE SPACES"
echo "---------------------------"
echo "Code:"
echo "echo 'Hello      World     with   many   spaces' | tr -s ' '"
echo ""
echo "Output:"
echo 'Hello      World     with   many   spaces' | tr -s ' '
echo ""

echo "EXAMPLE 7.2: SQUEEZE AND TRANSLATE"
echo "----------------------------------"
echo "Code:"
echo "echo 'aaabbbccc' | tr -s 'abc'"
echo "echo 'Mississippi' | tr -s 'is'"
echo ""
echo "Output:"
echo 'aaabbbccc' | tr -s 'abc'
echo 'Mississippi' | tr -s 'is'
echo ""

# -----------------------------------------------------------------------------
# Example 8: Complement Operations
# -----------------------------------------------------------------------------
echo ""
echo "10. tr - COMPLEMENT OPERATIONS (-c)"
echo "==================================="
echo ""

echo "EXAMPLE 8.1: KEEP ONLY ALPHANUMERIC"
echo "-----------------------------------"
echo "Code:"
echo "echo 'Hello@World#123!' | tr -cd '[:alnum:]'"
echo ""
echo "Output:"
echo 'Hello@World#123!' | tr -cd '[:alnum:]'
echo ""

echo "EXAMPLE 8.2: REPLACE NON-LETTERS WITH SPACE"
echo "-------------------------------------------"
echo "Code:"
echo "echo 'Hello, World! 2024' | tr -c '[:alpha:]' ' '"
echo ""
echo "Output:"
echo 'Hello, World! 2024' | tr -c '[:alpha:]' ' '
echo ""

# -----------------------------------------------------------------------------
# Example 9: Character Classes
# -----------------------------------------------------------------------------
echo ""
echo "11. tr - CHARACTER CLASSES"
echo "=========================="
echo ""
echo "COMMON CHARACTER CLASSES:"
echo "------------------------"
echo "[:alnum:]  Alphanumeric characters"
echo "[:alpha:]  Alphabetic characters"
echo "[:digit:]  Digits"
echo "[:lower:]  Lowercase letters"
echo "[:upper:]  Uppercase letters"
echo "[:space:]  Whitespace characters"
echo "[:punct:]  Punctuation characters"
echo "[:print:]  Printable characters"
echo "[:graph:]  Graphical characters"
echo "[:cntrl:]  Control characters"
echo "[:xdigit:] Hexadecimal digits"
echo ""

echo "EXAMPLE 9.1: USING CHARACTER CLASSES"
echo "------------------------------------"
echo "Code:"
echo "echo 'Hello World 123!' | tr '[:lower:]' '[:upper:]'"
echo "echo 'Remove digits: Hello123' | tr -d '[:digit:]'"
echo "echo 'Keep only letters: Test@123#' | tr -cd '[:alpha:]'"
echo ""
echo "Output:"
echo 'Hello World 123!' | tr '[:lower:]' '[:upper:]'
echo 'Remove digits: Hello123' | tr -d '[:digit:]'
echo 'Keep only letters: Test@123#' | tr -cd '[:alpha:]'
echo ""

# -----------------------------------------------------------------------------
# SECTION 5: COMBINING cut AND tr
# -----------------------------------------------------------------------------
echo ""
echo "12. COMBINING cut AND tr"
echo "========================"
echo ""

echo "EXAMPLE 1: CLEAN CSV PROCESSING"
echo "-------------------------------"
echo "Code:"
echo "# Extract email domain from CSV"
echo "cut -d',' -f5 employees.csv | cut -d'@' -f2"
echo ""
echo "Output:"
cut -d',' -f5 employees.csv | cut -d'@' -f2
echo ""

echo "EXAMPLE 2: PROCESS /etc/passwd"
echo "------------------------------"
echo "Code:"
echo "# Get usernames and shells in clean format"
echo "cut -d: -f1,7 /etc/passwd | head -5 | tr ':' '\\t'"
echo ""
echo "Output:"
cut -d: -f1,7 /etc/passwd | head -5 | tr ':' '\t'
echo ""

echo "EXAMPLE 3: EXTRACT AND CLEAN DATA"
echo "---------------------------------"
echo "Code:"
echo "# Get names, convert to lowercase, remove spaces"
echo "cut -d',' -f2 employees.csv | tail -n +2 | tr '[:upper:] ' '[:lower:]_'"
echo ""
echo "Output:"
cut -d',' -f2 employees.csv | tail -n +2 | tr '[:upper:] ' '[:lower:]_'
echo ""

# -----------------------------------------------------------------------------
# SECTION 6: REAL-WORLD USE CASES
# -----------------------------------------------------------------------------
echo ""
echo "13. REAL-WORLD USE CASES"
echo "========================"
echo ""

echo "USE CASE 1: LOG FILE ANALYSIS"
echo "-----------------------------"
cat << 'EOF'
# Extract IP addresses from web logs
cut -d' ' -f1 /var/log/nginx/access.log | sort | uniq -c | sort -rn

# Extract HTTP status codes
cut -d' ' -f9 /var/log/apache2/access.log | sort | uniq -c

# Clean log entries (remove timestamps)
cut -d' ' -f4- /var/log/syslog | head -10
EOF
echo ""

echo "USE CASE 2: SYSTEM ADMINISTRATION"
echo "---------------------------------"
cat << 'EOF'
# Get disk usage percentage only
df -h | tr -s ' ' | cut -d' ' -f5 | tail -n +2 | tr -d '%'

# Get process IDs of Java processes
ps aux | grep java | tr -s ' ' | cut -d' ' -f2

# Extract usernames from last command
last | cut -d' ' -f1 | sort | uniq
EOF
echo ""

echo "USE CASE 3: DATA CLEANING"
echo "-------------------------"
cat << 'EOF'
# Convert CSV to TSV
cat data.csv | tr ',' '\t' > data.tsv

# Remove BOM from UTF-8 files
cat file.csv | tr -d '\357\273\277' > clean.csv

# Normalize line endings
cat file.txt | tr -d '\r' > unix_file.txt
EOF
echo ""

echo "USE CASE 4: TEXT PROCESSING"
echo "---------------------------"
cat << 'EOF'
# Count words in a file
cat file.txt | tr -s ' ' '\n' | wc -l

# Create word frequency list
cat file.txt | tr -s ' ' '\n' | tr '[:upper:]' '[:lower:]' | sort | uniq -c

# Remove punctuation from text
cat document.txt | tr -d '[:punct:]' > clean_text.txt
EOF
echo ""

# -----------------------------------------------------------------------------
# SECTION 7: PERFORMANCE TIPS
# -----------------------------------------------------------------------------
echo ""
echo "14. PERFORMANCE TIPS"
echo "===================="
echo ""
echo "1. USE SIMPLE PATTERNS:"
echo "   • tr 'A-Z' 'a-z' is faster than sed 's/[A-Z]/\\L&/g'"
echo "   • cut is faster than awk for simple field extraction"
echo ""
echo "2. COMBINE OPERATIONS:"
echo "   • Pipe multiple tr operations: tr -d 'x' | tr 'a' 'b'"
echo "   • But for multiple different operations, consider awk"
echo ""
echo "3. AVOID REGULAR EXPRESSIONS:"
echo "   • tr doesn't support regex, but that makes it faster"
echo "   • Use grep/sed/awk for regex needs"
echo ""
echo "4. BUFFER LARGE FILES:"
echo "   • Both cut and tr process line by line"
echo "   • Handle large files efficiently"
echo ""

# -----------------------------------------------------------------------------
# SECTION 8: LIMITATIONS & ALTERNATIVES
# -----------------------------------------------------------------------------
echo ""
echo "15. LIMITATIONS & ALTERNATIVES"
echo "=============================="
echo ""
echo "CUT LIMITATIONS:"
echo "---------------"
echo "1. Fixed delimiter (single character)"
echo "   • Can't use multi-character delimiters"
echo "   • Alternative: awk -F 'multichar'"
echo ""
echo "2. No regex support"
echo "   • Alternative: grep, sed, awk"
echo ""
echo "3. Can't reorder fields arbitrarily"
echo "   • Alternative: awk '{print \$3,\$1,\$2}'"
echo ""
echo "TR LIMITATIONS:"
echo "--------------"
echo "1. Single character operations only"
echo "   • Can't translate 'apple' to 'orange'"
echo "   • Alternative: sed 's/apple/orange/g'"
echo ""
echo "2. No regex support"
echo "   • Alternative: sed, awk"
echo ""
echo "3. Sets must be same length for translation"
echo "   • Use -t to truncate or extend sets"
echo ""
echo "WHEN TO USE AWK INSTEAD:"
echo "-----------------------"
echo "• Complex field manipulations"
echo "• Multiple different delimiters"
echo "• Conditional field extraction"
echo "• Calculations on fields"
echo ""

# -----------------------------------------------------------------------------
# SECTION 9: QUICK REFERENCE CHEAT SHEET
# -----------------------------------------------------------------------------
echo ""
echo "16. QUICK REFERENCE CHEAT SHEET"
echo "==============================="
echo ""
echo "CUT COMMAND:"
echo "-----------"
echo "Extract field 2 from CSV:          cut -d',' -f2 file.csv"
echo "Extract fields 1,3,5:              cut -d',' -f1,3,5 file.csv"
echo "Extract fields 2 to end:           cut -d',' -f2- file.csv"
echo "Extract first 3 fields:            cut -d',' -f-3 file.csv"
echo "Change output delimiter:           cut -d',' -f1,2 --output-delimiter='|'"
echo "Extract characters 1-10:           cut -c1-10 file.txt"
echo "Extract bytes 5-20:                cut -b5-20 file.txt"
echo "Exclude field 3:                   cut -d',' -f3 --complement file.csv"
echo "Skip lines without delimiter:      cut -d',' -f1 -s file.csv"
echo ""
echo "TR COMMAND:"
echo "----------"
echo "Convert to uppercase:              tr 'a-z' 'A-Z'"
echo "Convert to lowercase:              tr 'A-Z' 'a-z'"
echo "Delete characters:                 tr -d 'abc'"
echo "Delete digits:                     tr -d '[:digit:]'"
echo "Squeeze spaces:                    tr -s ' '"
echo "Replace spaces with newlines:      tr ' ' '\\n'"
echo "Keep only alphanumeric:            tr -cd '[:alnum:]'"
echo "Delete non-printable:              tr -cd '[:print:]'"
echo "ROT13 encryption:                  tr 'A-Za-z' 'N-ZA-Mn-za-m'"
echo "Convert tabs to spaces:            tr '\\t' ' '"
echo ""
echo "COMMON COMBINATIONS:"
echo "-------------------"
echo "# Get clean username list"
echo "cut -d: -f1 /etc/passwd | sort"
echo ""
echo "# Extract and count unique values"
echo "cut -d',' -f3 data.csv | sort | uniq -c"
echo ""
echo "# Clean and normalize text"
echo "cat file.txt | tr '[:upper:]' '[:lower:]' | tr -s ' ' | tr -d '[:punct:]'"
echo ""
echo "# Parse log files"
echo "cut -d' ' -f1,7,9 access.log | head -20"
echo ""
echo "CHARACTER CLASSES:"
echo "-----------------"
echo "[:alnum:]  [:alpha:]  [:digit:]  [:lower:]  [:upper:]"
echo "[:space:]  [:blank:]  [:punct:]  [:print:]  [:graph:]"
echo "[:cntrl:]  [:xdigit:]"
echo ""

# -----------------------------------------------------------------------------
# SECTION 10: PRACTICAL EXERCISES
# -----------------------------------------------------------------------------
echo ""
echo "17. PRACTICAL EXERCISES"
echo "======================="
echo ""

echo "EXERCISE 1: PROCESS APACHE LOGS"
echo "-------------------------------"
cat << 'EOF'
# Sample log format: 127.0.0.1 - - [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326

# 1. Extract IP addresses
cut -d' ' -f1 access.log

# 2. Extract HTTP methods (GET/POST/etc.)
cut -d' ' -f6 access.log | tr -d '"'

# 3. Extract status codes and count
cut -d' ' -f9 access.log | sort | uniq -c

# 4. Extract URLs
cut -d' ' -f7 access.log
EOF
echo ""

echo "EXERCISE 2: CLEAN DATA FOR IMPORT"
echo "---------------------------------"
cat << 'EOF'
# Given dirty CSV: "John,Doe","CEO","New, York","100,000"
# 1. Remove quotes
tr -d '"' < file.csv

# 2. Handle embedded commas (convert to semicolon)
sed 's/","/";"/g' file.csv | tr ',' ';' | tr ';' ','

# 3. Extract specific columns
cut -d',' -f1,4 file.csv

# 4. Convert to uppercase
tr 'a-z' 'A-Z' < file.csv
EOF
echo ""

echo "EXERCISE 3: SYSTEM INFORMATION"
echo "------------------------------"
cat << 'EOF'
# 1. Get user home directories
cut -d: -f1,6 /etc/passwd | tr ':' '\t'

# 2. Extract package versions
dpkg -l | tr -s ' ' | cut -d' ' -f2,3

# 3. Get interface IP addresses
ip addr show | grep 'inet ' | tr -s ' ' | cut -d' ' -f3

# 4. Clean memory output
free -h | tr -s ' ' | cut -d' ' -f2,3,4
EOF
echo ""

echo "EXERCISE 4: TEXT ANALYSIS"
echo "-------------------------"
cat << 'EOF'
# 1. Count unique words
cat file.txt | tr '[:upper:]' '[:lower:]' | tr -s ' ' '\n' | sort | uniq -c | sort -rn

# 2. Extract sentences (period followed by space)
cat file.txt | tr '.' '\n' | tr -s ' ' | sed 's/^ //'

# 3. Remove HTML tags (simple)
cat file.html | tr -d '<>' | tr -s ' '

# 4. Create character frequency
cat file.txt | tr -cd '[:alpha:]' | fold -w1 | sort | uniq -c | sort -rn
EOF
echo ""

# Clean up temporary files
rm -f employees.csv spaces.txt fixed_width.txt sample.txt dna.txt

echo "========================================================================"
echo "                     END OF cut AND tr GUIDE"
echo "========================================================================"