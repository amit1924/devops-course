#!/bin/bash

# =============================================================================
# COMPLETE GUIDE TO grep, sed, AND awk - THE TEXT PROCESSING TRIO
# =============================================================================

echo "========================================================================"
echo "           COMPLETE GUIDE TO grep, sed, AND awk"
echo "========================================================================"

# Create sample files for examples
echo "Creating sample files..."
cat > employees.txt << 'EOF'
101 John Doe Engineering 75000 john@company.com
102 Jane Smith Marketing 65000 jane@company.com
103 Bob Johnson Sales 70000 bob@company.com
104 Alice Brown Engineering 80000 alice@company.com
105 Charlie Wilson HR 60000 charlie@company.com
106 David Lee Engineering 85000 david@company.com
107 Eve Davis Marketing 72000 eve@company.com
EOF

cat > logfile.txt << 'EOF'
2024-01-15 10:30:45 INFO User login successful user=johndoe
2024-01-15 10:31:22 ERROR Database connection failed code=500
2024-01-15 10:32:10 WARN High memory usage 85%
2024-01-15 10:33:05 INFO File uploaded size=5MB
2024-01-15 10:34:18 ERROR Payment processing failed user=janedoe
2024-01-15 10:35:00 INFO User logout user=johndoe
2024-01-15 10:36:45 DEBUG Cache cleared
EOF

cat > data.csv << 'EOF'
ID,Name,Department,Salary,JoinDate
101,John Doe,Engineering,75000,2020-01-15
102,Jane Smith,Marketing,65000,2019-05-20
103,Bob Johnson,Sales,70000,2021-03-10
104,Alice Brown,Engineering,80000,2018-11-05
105,Charlie Wilson,HR,60000,2022-07-30
EOF

cat > config.txt << 'EOF'
# Server Configuration
PORT=8080
HOST=localhost
DEBUG=true
MAX_USERS=100
TIMEOUT=30
# Database settings
DB_HOST=127.0.0.1
DB_PORT=5432
DB_NAME=app_db
EOF

# -----------------------------------------------------------------------------
# SECTION 1: grep - GLOBAL REGULAR EXPRESSION PRINT
# -----------------------------------------------------------------------------
echo ""
echo "1. grep - PATTERN SEARCHING"
echo "============================"
echo ""
echo "THEORY:"
echo "-------"
echo "• Searches for patterns in text"
echo "• Uses regular expressions (extended with -E)"
echo "• Outputs matching lines"
echo "• Fast and efficient for large files"
echo ""
echo "BASIC SYNTAX: grep [OPTIONS] PATTERN [FILE...]"
echo ""

# -----------------------------------------------------------------------------
# grep Examples
# -----------------------------------------------------------------------------
echo "2. grep EXAMPLES"
echo "================"
echo ""

echo "EXAMPLE 1.1: BASIC SEARCH"
echo "-------------------------"
echo "Code: grep 'Engineering' employees.txt"
echo "Output:"
grep 'Engineering' employees.txt
echo ""

echo "EXAMPLE 1.2: CASE INSENSITIVE (-i)"
echo "----------------------------------"
echo "Code: grep -i 'engineering' employees.txt"
echo "Output:"
grep -i 'engineering' employees.txt
echo ""

echo "EXAMPLE 1.3: INVERT MATCH (-v)"
echo "------------------------------"
echo "Code: grep -v 'Engineering' employees.txt"
echo "Output:"
grep -v 'Engineering' employees.txt
echo ""

echo "EXAMPLE 1.4: COUNT MATCHES (-c)"
echo "-------------------------------"
echo "Code: grep -c 'Engineering' employees.txt"
echo "Output: $(grep -c 'Engineering' employees.txt)"
echo ""

echo "EXAMPLE 1.5: SHOW LINE NUMBERS (-n)"
echo "-----------------------------------"
echo "Code: grep -n 'Error' logfile.txt"
echo "Output:"
grep -n 'ERROR' logfile.txt
echo ""

echo "EXAMPLE 1.6: REGULAR EXPRESSIONS (-E)"
echo "-------------------------------------"
echo "Code: grep -E 'ERROR|WARN' logfile.txt"
echo "Output:"
grep -E 'ERROR|WARN' logfile.txt
echo ""

echo "EXAMPLE 1.7: MATCH WHOLE WORD (-w)"
echo "----------------------------------"
echo "Code: grep -w 'Engineering' employees.txt"
echo "Output:"
grep -w 'Engineering' employees.txt
echo ""

echo "EXAMPLE 1.8: SHOW CONTEXT (-A, -B, -C)"
echo "--------------------------------------"
echo "Code: grep -A1 -B1 'ERROR' logfile.txt"
echo "Output:"
grep -A1 -B1 'ERROR' logfile.txt
echo ""

echo "EXAMPLE 1.9: RECURSIVE SEARCH (-r)"
echo "----------------------------------"
echo "Code: grep -r 'TODO' . --include='*.py'"
echo "Output (simulated):"
echo "  ./app.py:# TODO: Add error handling"
echo "  ./utils.py:# TODO: Optimize function"
echo ""

echo "EXAMPLE 1.10: SEARCH MULTIPLE FILES"
echo "-----------------------------------"
echo "Code: grep 'user' logfile.txt employees.txt"
echo "Output:"
grep 'user' logfile.txt employees.txt
echo ""

# -----------------------------------------------------------------------------
# SECTION 2: sed - STREAM EDITOR
# -----------------------------------------------------------------------------
echo ""
echo "3. sed - STREAM EDITING"
echo "======================="
echo ""
echo "THEORY:"
echo "-------"
echo "• Processes text stream line by line"
echo "• Non-interactive text transformation"
echo "• Uses addresses and commands"
echo "• Can edit files in-place (-i)"
echo ""
echo "BASIC SYNTAX: sed [OPTIONS] 'COMMAND' [FILE...]"
echo ""
echo "COMMON COMMANDS:"
echo "---------------"
echo "s/old/new/    - Substitute"
echo "p            - Print"
echo "d            - Delete"
echo "a\\           - Append"
echo "i\\           - Insert"
echo "q            - Quit"
echo ""

# -----------------------------------------------------------------------------
# sed Examples
# -----------------------------------------------------------------------------
echo "4. sed EXAMPLES"
echo "==============="
echo ""

echo "EXAMPLE 2.1: SIMPLE SUBSTITUTION"
echo "--------------------------------"
echo "Code: sed 's/Engineering/ENG/' employees.txt"
echo "Output:"
sed 's/Engineering/ENG/' employees.txt
echo ""

echo "EXAMPLE 2.2: GLOBAL SUBSTITUTION (g flag)"
echo "-----------------------------------------"
echo "Code: echo 'apple apple apple' | sed 's/apple/orange/g'"
echo "Output:"
echo 'apple apple apple' | sed 's/apple/orange/g'
echo ""

echo "EXAMPLE 2.3: DELETE LINES"
echo "-------------------------"
echo "Code: sed '/Engineering/d' employees.txt"
echo "Output:"
sed '/Engineering/d' employees.txt
echo ""

echo "EXAMPLE 2.4: PRINT SPECIFIC LINES"
echo "---------------------------------"
echo "Code: sed -n '2,4p' employees.txt"
echo "Output:"
sed -n '2,4p' employees.txt
echo ""

echo "EXAMPLE 2.5: IN-PLACE EDITING (-i)"
echo "----------------------------------"
echo "Code: sed -i.bak 's/Engineering/ENG/g' employees.txt"
echo "Output: File modified (backup created as employees.txt.bak)"
echo "Restoring original..."
cp employees.txt.bak employees.txt 2>/dev/null || echo "Backup not found"
echo ""

echo "EXAMPLE 2.6: MULTIPLE COMMANDS (-e)"
echo "-----------------------------------"
echo "Code: sed -e 's/Engineering/ENG/' -e 's/Marketing/MKT/' employees.txt"
echo "Output:"
sed -e 's/Engineering/ENG/' -e 's/Marketing/MKT/' employees.txt
echo ""

echo "EXAMPLE 2.7: BACKREFERENCE"
echo "--------------------------"
echo "Code: echo 'John Doe' | sed 's/\\(John\\) \\(Doe\\)/\\2, \\1/'"
echo "Output:"
echo 'John Doe' | sed 's/\(John\) \(Doe\)/\2, \1/'
echo ""

echo "EXAMPLE 2.8: CONDITIONAL SUBSTITUTION"
echo "-------------------------------------"
echo "Code: sed '/Engineering/s/75000/80000/' employees.txt"
echo "Output:"
sed '/Engineering/s/75000/80000/' employees.txt
echo ""

echo "EXAMPLE 2.9: APPEND/INSERT TEXT"
echo "-------------------------------"
echo "Code: sed '3a\\--- New Employee ---' employees.txt"
echo "Output:"
sed '3a\--- New Employee ---' employees.txt | head -5
echo ""

echo "EXAMPLE 2.10: ADVANCED PATTERN WITH REGEX"
echo "-----------------------------------------"
echo "Code: sed -E 's/[0-9]{5,}/SALARY/g' employees.txt"
echo "Output:"
sed -E 's/[0-9]{5,}/SALARY/g' employees.txt
echo ""

# -----------------------------------------------------------------------------
# SECTION 3: awk - PATTERN SCANNING AND PROCESSING
# -----------------------------------------------------------------------------
echo ""
echo "5. awk - PATTERN PROCESSING LANGUAGE"
echo "===================================="
echo ""
echo "THEORY:"
echo "-------"
echo "• Programming language for text processing"
echo "• Processes records (lines) and fields"
echo "• Built-in variables: NR, NF, FS, OFS"
echo "• Supports arithmetic and string operations"
echo ""
echo "BASIC SYNTAX: awk 'PATTERN { ACTION }' [FILE...]"
echo ""
echo "IMPORTANT VARIABLES:"
echo "-------------------"
echo "NR    - Current record number (line)"
echo "NF    - Number of fields in current record"
echo "FS    - Field separator (default: space)"
echo "OFS   - Output field separator"
echo "$0    - Entire line"
echo "$1-$n - Individual fields"
echo ""

# -----------------------------------------------------------------------------
# awk Examples
# -----------------------------------------------------------------------------
echo "6. awk EXAMPLES"
echo "==============="
echo ""

echo "EXAMPLE 3.1: PRINT SPECIFIC FIELD"
echo "---------------------------------"
echo "Code: awk '{print \$2}' employees.txt"
echo "Output:"
awk '{print $2}' employees.txt
echo ""

echo "EXAMPLE 3.2: PRINT MULTIPLE FIELDS"
echo "----------------------------------"
echo "Code: awk '{print \$1, \$2, \$4}' employees.txt"
echo "Output:"
awk '{print $1, $2, $4}' employees.txt
echo ""

echo "EXAMPLE 3.3: CONDITIONAL PRINTING"
echo "---------------------------------"
echo "Code: awk '\$4 > 70000 {print \$2, \$4}' employees.txt"
echo "Output:"
awk '$4 > 70000 {print $2, $4}' employees.txt
echo ""

echo "EXAMPLE 3.4: SUMMATION"
echo "----------------------"
echo "Code: awk '{sum += \$4} END {print \"Total Salary:\", sum}' employees.txt"
echo "Output:"
awk '{sum += $4} END {print "Total Salary:", sum}' employees.txt
echo ""

echo "EXAMPLE 3.5: FIELD SEPARATOR CONTROL"
echo "------------------------------------"
echo "Code: awk -F',' '{print \$2, \$3}' data.csv"
echo "Output:"
awk -F',' '{print $2, $3}' data.csv
echo ""

echo "EXAMPLE 3.6: BEGIN AND END BLOCKS"
echo "---------------------------------"
echo "Code: awk 'BEGIN {FS=\",\"; print \"Starting...\"} {print \$2} END {print \"Done\"}' data.csv"
echo "Output:"
awk 'BEGIN {FS=","; print "Starting..."} {print $2} END {print "Done"}' data.csv
echo ""

echo "EXAMPLE 3.7: PATTERN MATCHING"
echo "-----------------------------"
echo "Code: awk '/Engineering/ {print \$0}' employees.txt"
echo "Output:"
awk '/Engineering/ {print $0}' employees.txt
echo ""

echo "EXAMPLE 3.8: BUILT-IN FUNCTIONS"
echo "-------------------------------"
echo "Code: awk '{print toupper(\$2), length(\$2)}' employees.txt"
echo "Output:"
awk '{print toupper($2), length($2)}' employees.txt
echo ""

echo "EXAMPLE 3.9: ASSOCIATIVE ARRAYS"
echo "-------------------------------"
echo "Code: awk '{dept[\$3]++} END {for (d in dept) print d, dept[d]}' employees.txt"
echo "Output:"
awk '{dept[$3]++} END {for (d in dept) print d, dept[d]}' employees.txt
echo ""

echo "EXAMPLE 3.10: COMPLEX FIELD MANIPULATION"
echo "----------------------------------------"
echo "Code: awk -F'@' '{print \$1}' employees.txt | awk '{print \$NF}'"
echo "Output:"
awk -F'@' '{print $1}' employees.txt | awk '{print $NF}'
echo ""

# -----------------------------------------------------------------------------
# SECTION 4: COMPARISON & WHEN TO USE EACH
# -----------------------------------------------------------------------------
echo ""
echo "7. COMPARISON: grep vs sed vs awk"
echo "================================="
echo ""
echo "USE grep WHEN:"
echo "-------------"
echo "• Searching for patterns"
echo "• Filtering lines"
echo "• Counting occurrences"
echo "• Finding files with content"
echo ""
echo "USE sed WHEN:"
echo "------------"
echo "• Simple text substitutions"
echo "• Deleting/adding lines"
echo "• Basic text transformations"
echo "• Stream editing without programming"
echo ""
echo "USE awk WHEN:"
echo "------------"
echo "• Field-based processing"
echo "• Calculations on fields"
echo "• Complex text transformations"
echo "• Generating reports"
echo "• Working with structured data"
echo ""

echo "COMPARISON TABLE:"
echo "----------------"
echo "| Task                | grep | sed | awk | Best Choice |"
echo "|---------------------|------|-----|-----|-------------|"
echo "| Search for pattern  | ✓✓✓  | ✓   | ✓   | grep        |"
echo "| Count occurrences   | ✓✓✓  |     | ✓   | grep -c     |"
echo "| Simple substitution |      | ✓✓✓ | ✓   | sed         |"
echo "| Delete lines        |      | ✓✓✓ | ✓   | sed         |"
echo "| Field extraction    |      |     | ✓✓✓ | awk         |"
echo "| Calculations        |      |     | ✓✓✓ | awk         |"
echo "| Complex transforms  |      | ✓   | ✓✓✓ | awk         |"
echo "| Multi-file search   | ✓✓✓  | ✓   | ✓   | grep        |"
echo ""

# -----------------------------------------------------------------------------
# SECTION 5: COMBINING THE TOOLS
# -----------------------------------------------------------------------------
echo ""
echo "8. POWER OF COMBINATION"
echo "======================="
echo ""

echo "EXAMPLE 5.1: EXTRACT AND FORMAT LOG DATA"
echo "----------------------------------------"
echo "Code: grep 'ERROR' logfile.txt | awk '{print \$3, \$NF}'"
echo "Output:"
grep 'ERROR' logfile.txt | awk '{print $3, $NF}'
echo ""

echo "EXAMPLE 5.2: CLEAN AND PROCESS CSV"
echo "----------------------------------"
echo "Code: sed '1d' data.csv | awk -F',' '\$4 > 70000 {print \$2, \"earns\", \$4}'"
echo "Output:"
sed '1d' data.csv | awk -F',' '$4 > 70000 {print $2, "earns", $4}'
echo ""

echo "EXAMPLE 5.3: CONFIG FILE PROCESSING"
echo "-----------------------------------"
echo "Code: grep -v '^#' config.txt | sed 's/=/: /' | awk '{print \"Config:\", \$1, \"=\", \$2}'"
echo "Output:"
grep -v '^#' config.txt | sed 's/=/: /' | awk '{print "Config:", $1, "=", $2}'
echo ""

echo "EXAMPLE 5.4: MULTI-STEP DATA PIPELINE"
echo "-------------------------------------"
echo "Code: awk '\$3 == \"Engineering\" {print \$0}' employees.txt | \\"
echo "      sed 's/Engineering/ENG/g' | \\"
echo "      awk '{print \$2, \"(\$\" \$4 \")\"}'"
echo "Output:"
awk '$3 == "Engineering" {print $0}' employees.txt | \
  sed 's/Engineering/ENG/g' | \
  awk '{print $2, "($" $4 ")"}'
echo ""

# -----------------------------------------------------------------------------
# SECTION 6: REAL-WORLD USE CASES
# -----------------------------------------------------------------------------
echo ""
echo "9. REAL-WORLD USE CASES"
echo "======================="
echo ""

echo "USE CASE 1: LOG ANALYSIS"
echo "------------------------"
cat << 'EOF'
# Find all errors in last hour
grep "$(date -d '1 hour ago' '+%Y-%m-%d %H')" /var/log/syslog | grep -i error

# Count error types
awk '/ERROR/ {count[$5]++} END {for (type in count) print type, count[type]}' app.log

# Extract error details
sed -n '/ERROR/,/^$/p' /var/log/application.log
EOF
echo ""

echo "USE CASE 2: SYSTEM MONITORING"
echo "-----------------------------"
cat << 'EOF'
# Find large files
find /home -type f -size +100M | awk -F/ '{print $NF}'

# Monitor process count
ps aux | awk '{print $1}' | sort | uniq -c | sort -rn

# Check disk usage for mount points > 80%
df -h | awk 'NR>1 && $5+0 > 80 {print $1, $5}'
EOF
echo ""

echo "USE CASE 3: DATA CLEANING"
echo "-------------------------"
cat << 'EOF'
# Remove empty lines and trailing spaces
sed '/^$/d' file.txt | sed 's/[[:space:]]*$//'

# Convert CSV to JSON
awk -F',' 'NR>1 {printf "{\"id\":%s,\"name\":\"%s\"},\n", $1, $2}' data.csv

# Extract emails from text
grep -E -o '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b' file.txt
EOF
echo ""

echo "USE CASE 4: WEB SERVER LOGS"
echo "---------------------------"
cat << 'EOF'
# Top 10 IP addresses
awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -10

# Most requested URLs
awk '{print $7}' access.log | sort | uniq -c | sort -rn | head -10

# Requests per hour
awk '{print $4}' access.log | cut -d: -f2 | sort | uniq -c

# 404 errors
awk '$9 == 404 {print $7}' access.log | sort | uniq -c | sort -rn
EOF
echo ""

echo "USE CASE 5: CONFIGURATION MANAGEMENT"
echo "------------------------------------"
cat << 'EOF'
# Extract all environment variables from shell scripts
grep -h '^export' *.sh | sed 's/export //' | awk -F= '{print $1}'

# Update version in all files
find . -name "*.py" -exec sed -i 's/version = "1.0"/version = "2.0"/g' {} \;

# List all Python imports
grep -h '^import' *.py | sed 's/import //' | sort | uniq
EOF
echo ""

# -----------------------------------------------------------------------------
# SECTION 7: PERFORMANCE TIPS
# -----------------------------------------------------------------------------
echo ""
echo "10. PERFORMANCE TIPS"
echo "===================="
echo ""
echo "1. grep IS FASTEST FOR SEARCH:"
echo "   • Use grep for simple pattern matching"
echo "   • Add -F for fixed strings (even faster)"
echo ""
echo "2. USE LEAST POWERFUL TOOL NEEDED:"
echo "   • grep < sed < awk (in terms of overhead)"
echo "   • Don't use awk if sed can do it"
echo "   • Don't use sed if grep can do it"
echo ""
echo "3. COMBINE OPERATIONS:"
echo "   • Pipe output rather than multiple passes"
echo "   • Use awk for multiple operations in one pass"
echo ""
echo "4. AVOID READING LARGE FILES MULTIPLE TIMES:"
echo "   • Process once with complex awk script"
echo "   • Use tee for multiple outputs"
echo ""
echo "5. USE APPROPRIATE OPTIONS:"
echo "   • grep -l (just list files)"
echo "   • grep -q (quiet, for scripts)"
echo "   • sed -n (suppress automatic printing)"
echo ""

# -----------------------------------------------------------------------------
# SECTION 8: COMMON PATTERNS CHEAT SHEET
# -----------------------------------------------------------------------------
echo ""
echo "11. QUICK REFERENCE CHEAT SHEET"
echo "================================"
echo ""

echo "grep PATTERNS:"
echo "-------------"
echo "Basic search:          grep 'pattern' file"
echo "Case insensitive:      grep -i 'pattern' file"
echo "Invert match:          grep -v 'pattern' file"
echo "Count matches:         grep -c 'pattern' file"
echo "Line numbers:          grep -n 'pattern' file"
echo "Whole word:            grep -w 'word' file"
echo "Regex:                 grep -E '[0-9]+' file"
echo "After context:         grep -A 3 'pattern' file"
echo "Before context:        grep -B 2 'pattern' file"
echo "Both context:          grep -C 2 'pattern' file"
echo "Recursive:             grep -r 'pattern' dir/"
echo "Multiple patterns:     grep -e 'pat1' -e 'pat2' file"
echo ""

echo "sed COMMANDS:"
echo "------------"
echo "Substitute:            sed 's/old/new/' file"
echo "Global substitute:     sed 's/old/new/g' file"
echo "Delete lines:          sed '/pattern/d' file"
echo "Print lines:           sed -n '10,20p' file"
echo "In-place edit:         sed -i 's/old/new/' file"
echo "With backup:           sed -i.bak 's/old/new/' file"
echo "Multiple commands:     sed -e 'cmd1' -e 'cmd2' file"
echo "Append text:           sed '3a\\new line' file"
echo "Insert text:           sed '3i\\new line' file"
echo "Change line:           sed '3c\\new line' file"
echo "Transform case:        sed 's/.*/\U&/' file"
echo ""

echo "awk PATTERNS:"
echo "------------"
echo "Print field:           awk '{print $1}' file"
echo "Print last field:      awk '{print $NF}' file"
echo "Set separator:         awk -F: '{print $1}' /etc/passwd"
echo "Condition:             awk '$3 > 100 {print $1}' file"
echo "BEGIN/END:             awk 'BEGIN{sum=0} {sum+=$1} END{print sum}'"
echo "Pattern match:         awk '/error/ {print $0}' file"
echo "Built-in functions:    awk '{print toupper($1), length($1)}'"
echo "Field calculations:    awk '{print $1, $2, $1+$2}' file"
echo "Array counting:        awk '{count[$1]++} END{for(i in count) print i, count[i]}'"
echo "Range pattern:         awk 'NR>=10 && NR<=20' file"
echo "Output separator:      awk 'BEGIN{OFS=":"} {print $1, $2}'"
echo ""

echo "COMMON COMBINATIONS:"
echo "-------------------"
echo "# Find and count"
echo "grep 'error' log.txt | wc -l"
echo ""
echo "# Extract and format"
echo "awk -F: '{print $1}' /etc/passwd | sort"
echo ""
echo "# Multiple transformations"
echo "sed 's/old/new/g' file | awk '{print $2}' | sort -u"
echo ""
echo "# Process and filter"
echo "awk '$3 > 50000' data.txt | sort -k3 -rn"
echo ""
echo "# Clean and analyze"
echo "grep -v '^#' config.txt | sed 's/#.*//' | awk 'NF>0'"
echo ""

# -----------------------------------------------------------------------------
# SECTION 9: ADVANCED EXAMPLES
# -----------------------------------------------------------------------------
echo ""
echo "12. ADVANCED EXAMPLES"
echo "====================="
echo ""

echo "EXAMPLE 1: APACHE LOG ANALYSIS SCRIPT"
echo "-------------------------------------"
cat << 'EOF'
#!/bin/bash
LOG_FILE="$1"

echo "=== Apache Log Analysis ==="
echo ""

echo "1. Total requests:"
wc -l < "$LOG_FILE"

echo "2. Requests by status code:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn

echo "3. Top 10 IP addresses:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10

echo "4. Top 10 requested pages:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10

echo "5. Busiest hours:"
awk '{print $4}' "$LOG_FILE" | cut -d: -f2 | sort | uniq -c | sort -rn | head -5

echo "6. 404 errors:"
awk '$9 == 404 {print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn
EOF
echo ""

echo "EXAMPLE 2: SYSTEM RESOURCE MONITOR"
echo "----------------------------------"
cat << 'EOF'
#!/bin/bash
echo "=== System Resource Monitor ==="
echo ""

echo "1. Top 5 processes by CPU:"
ps aux --sort=-%cpu | awk 'NR<=6 {printf "%-10s %-10s %-10s\n", $1, $2, $3}'

echo "2. Top 5 processes by MEMORY:"
ps aux --sort=-%mem | awk 'NR<=6 {printf "%-10s %-10s %-10s\n", $1, $2, $4}'

echo "3. Disk usage (>80%):"
df -h | awk 'NR>1 && $5+0 > 80 {print $1 " is " $5 " full"}'

echo "4. Memory usage:"
free -h | awk '/^Mem:/ {print "Used: " $3 "/" $2 " (" $3/$2*100 "%)"}'

echo "5. Load average:"
uptime | awk -F'load average:' '{print $2}'
EOF
echo ""

echo "EXAMPLE 3: CSV TO JSON CONVERTER"
echo "--------------------------------"
cat << 'EOF'
#!/bin/bash
INPUT="$1"
OUTPUT="${INPUT%.csv}.json"

awk -F',' '
BEGIN {
    print "["
    first=1
}
NR==1 {
    for(i=1;i<=NF;i++) headers[i]=$i
    next
}
{
    if (!first) printf ",\n"
    first=0
    printf "  {"
    for(i=1;i<=NF;i++) {
        if (i>1) printf ", "
        printf "\"%s\": \"%s\"", headers[i], $i
    }
    printf "}"
}
END {
    print "\n]"
}' "$INPUT" > "$OUTPUT"

echo "Converted $INPUT to $OUTPUT"
EOF
echo ""

echo "EXAMPLE 4: CONFIG FILE PARSER"
echo "-----------------------------"
cat << 'EOF'
#!/bin/bash
CONFIG_FILE="$1"

echo "=== Configuration Analysis ==="
echo ""

# Extract all variables
echo "1. All variables:"
grep -v '^#' "$CONFIG_FILE" | grep '=' | sed 's/#.*//' | awk -F'=' '{print $1 " = " $2}'

# Count by type
echo ""
echo "2. Variable types:"
awk -F'=' '/^[^#]/ {
    key=$1
    value=$2
    if (value ~ /^[0-9]+$/) type="number"
    else if (value ~ /^true|false$/) type="boolean"
    else if (value ~ /^[0-9]+\.[0-9]+$/) type="float"
    else type="string"
    count[type]++
} END {
    for (t in count) print t ": " count[t]
}' "$CONFIG_FILE"

# Find unset variables
echo ""
echo "3. Variables needing attention:"
grep -v '^#' "$CONFIG_FILE" | awk -F'=' '$2 == "" {print "WARNING: " $1 " is empty"}'
EOF
echo ""

# Clean up temporary files
rm -f employees.txt logfile.txt data.csv config.txt employees.txt.bak

echo "========================================================================"
echo "                     END OF grep, sed, awk GUIDE"
echo "========================================================================"