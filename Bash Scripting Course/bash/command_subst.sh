#!/bin/bash

# =============================================================================
# COMPLETE GUIDE TO COMMAND SUBSTITUTION IN BASH
# =============================================================================

echo "========================================================================"
echo "            COMPLETE GUIDE TO COMMAND SUBSTITUTION"
echo "========================================================================"

# -----------------------------------------------------------------------------
# SECTION 1: THEORY & CONCEPTS
# -----------------------------------------------------------------------------
echo ""
echo "1. THEORY & CONCEPTS"
echo "===================="
echo ""
echo "WHAT IS COMMAND SUBSTITUTION?"
echo "------------------------------"
echo "• Executes a command and substitutes its output in place"
echo "• Allows capturing command output into variables"
echo "• Enables using command output as arguments to other commands"
echo ""
echo "WHY USE COMMAND SUBSTITUTION?"
echo "------------------------------"
echo "• Capture and store command output"
echo "• Use output of one command as input to another"
echo "• Dynamic variable assignment"
echo "• Command output in strings/echo statements"
echo "• Generate dynamic filenames, paths, configurations"
echo ""
echo "HISTORICAL NOTE:"
echo "----------------"
echo "• Backticks \`command\` : Old syntax (deprecated but still works)"
echo "• \$() : Modern syntax (preferred)"
echo "• \$() supports nesting: \$(command1 \$(command2))"
echo "• Backticks require escaping for nesting: \`command1 \\\`command2\\\`\`"
echo ""

# -----------------------------------------------------------------------------
# SECTION 2: SYNTAX & EXAMPLES WITH OUTPUT
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Example 1: Basic Syntax Comparison
# -----------------------------------------------------------------------------
echo ""
echo "2. BASIC SYNTAX COMPARISON"
echo "=========================="
echo ""
echo "OLD SYNTAX (Backticks):"
echo "----------------------"
echo "Code: echo \"Today is \`date +%A\`\""
echo "Output: Today is $(date +%A)"
echo ""
echo "NEW SYNTAX (\$()):"
echo "----------------"
echo "Code: echo \"Today is \$(date +%A)\""
echo "Output: Today is $(date +%A)"
echo ""
echo "DIFFERENCE:"
echo "----------"
echo "Backticks: \`command\`"
echo "Dollar-parentheses: \$(command)"
echo "Note: \$() is preferred for readability and nesting"
echo ""

# -----------------------------------------------------------------------------
# Example 2: Storing Command Output in Variables
# -----------------------------------------------------------------------------
echo "EXAMPLE 2: STORING OUTPUT IN VARIABLES"
echo "======================================"
echo "Code:"
echo "current_dir=\$(pwd)"
echo "echo \"Current directory: \$current_dir\""
echo ""
echo "file_count=\$(ls -1 | wc -l)"
echo "echo \"Number of files: \$file_count\""
echo ""
echo "system_info=\$(uname -a)"
echo "echo \"System Info: \$system_info\""

current_dir=$(pwd)
echo "Output:"
echo "Current directory: $current_dir"
echo ""

file_count=$(ls -1 | wc -l)
echo "Number of files: $file_count"
echo ""

system_info=$(uname -a)
echo "System Info: $system_info"
echo ""

# -----------------------------------------------------------------------------
# Example 3: Using in Strings and Echo Statements
# -----------------------------------------------------------------------------
echo "EXAMPLE 3: USING IN STRINGS AND ECHO"
echo "===================================="
echo "Code:"
echo "echo \"Welcome, \$(whoami)!\""
echo "echo \"You are in: \$(pwd)\""
echo "echo \"Today's date: \$(date '+%Y-%m-%d %H:%M:%S')\""
echo "echo \"System has been up for: \$(uptime -p)\""

echo "Output:"
echo "Welcome, $(whoami)!"
echo "You are in: $(pwd)"
echo "Today's date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "System has been up for: $(uptime -p)"
echo ""

# -----------------------------------------------------------------------------
# Example 4: Using as Command Arguments
# -----------------------------------------------------------------------------
echo "EXAMPLE 4: AS COMMAND ARGUMENTS"
echo "================================"
echo "Code:"
echo "echo \"Largest files in current directory:\""
echo "ls -lh \$(find . -maxdepth 1 -type f -exec ls -S {} + | head -5)"
echo ""
echo "echo \"Files modified today:\""
echo "ls -l \$(find . -maxdepth 1 -type f -mtime 0)"
echo ""
echo "# Create backup with timestamp"
echo "backup_name=\"backup_\$(date +%Y%m%d_%H%M%S).tar.gz\""
echo "echo \"Creating backup: \$backup_name\""
echo "# tar -czf \$backup_name directory/"

echo "Output:"
echo "Largest files in current directory:"
ls -lh $(find . -maxdepth 1 -type f -exec ls -S {} + | head -3 2>/dev/null) 2>/dev/null || echo "  (No files found)"
echo ""
echo "Files modified today:"
ls -l $(find . -maxdepth 1 -type f -mtime 0 2>/dev/null) 2>/dev/null || echo "  (No files modified today)"
echo ""
backup_name="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
echo "Creating backup: $backup_name"
echo ""

# -----------------------------------------------------------------------------
# Example 5: Nested Command Substitution
# -----------------------------------------------------------------------------
echo "EXAMPLE 5: NESTED COMMAND SUBSTITUTION"
echo "======================================"
echo "Code:"
echo "# Get the name of the largest file"
echo "largest_file=\$(ls -S \$(pwd) | head -1)"
echo "echo \"Largest file: \$largest_file\""
echo ""
echo "# Get process count for current user"
echo "process_count=\$(ps -u \$(whoami) | wc -l)"
echo "echo \"Processes for \$(whoami): \$process_count\""
echo ""
echo "# Complex nesting example"
echo "echo \"Home directory of current user: \$(ls -la \$(echo ~\$(whoami)))\""

echo "Output:"
largest_file=$(ls -S $(pwd) 2>/dev/null | head -1 2>/dev/null)
echo "Largest file: $largest_file"
echo ""
process_count=$(ps -u $(whoami) 2>/dev/null | wc -l 2>/dev/null)
echo "Processes for $(whoami): $process_count"
echo ""
echo "Home directory listing (first few items):"
ls -la $(echo ~$(whoami)) 2>/dev/null | head -5
echo ""

# -----------------------------------------------------------------------------
# Example 6: In Conditionals and Loops
# -----------------------------------------------------------------------------
echo "EXAMPLE 6: IN CONDITIONALS AND LOOPS"
echo "===================================="
echo "Code:"

cat << 'EOF'
# Check if directory is empty
if [ -z "$(ls -A /tmp 2>/dev/null)" ]; then
    echo "/tmp is empty"
else
    echo "/tmp is not empty"
fi

# Loop through files found by find command
echo "Python files in current directory:"
for file in $(find . -name "*.py" -type f); do
    echo "  Found: $file"
done

# While loop reading from command output
echo "Recent log entries:"
while read -r line; do
    echo "  $line"
done <<< "$(tail -5 /var/log/syslog 2>/dev/null || echo 'No syslog access')"
EOF

echo "Output:"
if [ -z "$(ls -A /tmp 2>/dev/null)" ]; then
    echo "/tmp is empty"
else
    echo "/tmp is not empty"
fi
echo ""
echo "Python files in current directory:"
for file in $(find . -name "*.py" -type f 2>/dev/null); do
    echo "  Found: $file"
done
[ -z "$(find . -name "*.py" -type f 2>/dev/null)" ] && echo "  (No Python files found)"
echo ""
echo "Recent log entries (simulated):"
echo "  Log entry 1: System started"
echo "  Log entry 2: User login"
echo "  Log entry 3: Network connected"
echo "  Log entry 4: Update check"
echo "  Log entry 5: Backup completed"
echo ""

# -----------------------------------------------------------------------------
# Example 7: Arrays with Command Substitution
# -----------------------------------------------------------------------------
echo "EXAMPLE 7: ARRAYS WITH COMMAND SUBSTITUTION"
echo "==========================================="
echo "Code:"

cat << 'EOF'
# Create array from command output
files_list=($(ls *.txt 2>/dev/null))
echo "Text files: ${#files_list[@]} found"
for file in "${files_list[@]}"; do
    echo "  - $file"
done

# Read lines into array
mapfile -t lines < <(echo -e "line1\nline2\nline3")
echo "Lines in array: ${#lines[@]}"
for line in "${lines[@]}"; do
    echo "  Line: $line"
done

# Associative array from command output
declare -A users
while IFS=: read -r user uid; do
    users["$user"]=$uid
done <<< "$(awk -F: '{print $1 " " $3}' /etc/passwd | head -5)"
echo "First 5 users:"
for user in "${!users[@]}"; do
    echo "  $user: ${users[$user]}"
done
EOF

echo "Output:"
files_list=($(ls *.txt 2>/dev/null))
echo "Text files: ${#files_list[@]} found"
for file in "${files_list[@]}"; do
    echo "  - $file"
done
[ ${#files_list[@]} -eq 0 ] && echo "  (No text files found)"
echo ""

mapfile -t lines < <(echo -e "line1\nline2\nline3")
echo "Lines in array: ${#lines[@]}"
for line in "${files_list[@]}"; do
    echo "  Line: $line"
done
echo ""

echo "Sample users (simulated):"
declare -A users
users=(["root"]="0" ["daemon"]="1" ["bin"]="2" ["sys"]="3" ["sync"]="4")
for user in "${!users[@]}"; do
    echo "  $user: ${users[$user]}"
done
echo ""

# -----------------------------------------------------------------------------
# Example 8: Arithmetic Operations
# -----------------------------------------------------------------------------
echo "EXAMPLE 8: ARITHMETIC OPERATIONS"
echo "================================="
echo "Code:"

cat << 'EOF'
# Calculate disk usage percentage
total=$(df / | awk 'NR==2 {print $2}')
used=$(df / | awk 'NR==2 {print $3}')
usage_percent=$(( (used * 100) / total ))
echo "Disk usage: $usage_percent%"

# Count specific files
sh_files=$(find . -name "*.sh" -type f | wc -l)
py_files=$(find . -name "*.py" -type f | wc -l)
total_scripts=$((sh_files + py_files))
echo "Shell scripts: $sh_files"
echo "Python scripts: $py_files"
echo "Total scripts: $total_scripts"

# Generate sequence
numbers=$(seq 1 5)
sum=0
for num in $numbers; do
    sum=$((sum + num))
done
echo "Sum of 1-5: $sum"
EOF

echo "Output:"
total=$(df / 2>/dev/null | awk 'NR==2 {print $2}' 2>/dev/null || echo "1000000")
used=$(df / 2>/dev/null | awk 'NR==2 {print $3}' 2>/dev/null || echo "500000")
usage_percent=$(( (used * 100) / total ))
echo "Disk usage: $usage_percent%"
echo ""

sh_files=$(find . -name "*.sh" -type f 2>/dev/null | wc -l)
py_files=$(find . -name "*.py" -type f 2>/dev/null | wc -l)
total_scripts=$((sh_files + py_files))
echo "Shell scripts: $sh_files"
echo "Python scripts: $py_files"
echo "Total scripts: $total_scripts"
echo ""

numbers=$(seq 1 5)
sum=0
for num in $numbers; do
    sum=$((sum + num))
done
echo "Sum of 1-5: $sum"
echo ""

# -----------------------------------------------------------------------------
# Example 9: Process Substitution vs Command Substitution
# -----------------------------------------------------------------------------
echo "EXAMPLE 9: PROCESS SUBSTITUTION VS COMMAND SUBSTITUTION"
echo "======================================================"
echo "Code:"

cat << 'EOF'
# Command Substitution - captures output
output=$(echo "Hello World")
echo "Command substitution: $output"

# Process Substitution - treats output as file
echo "Process substitution - comparing two outputs:"
diff <(ls /bin | head -5) <(ls /usr/bin | head -5)

# Using both together
echo "Files in current directory sorted by size:"
sort -hr <(du -sh $(find . -maxdepth 1 -type f) 2>/dev/null)
EOF

echo "Output:"
output=$(echo "Hello World")
echo "Command substitution: $output"
echo ""
echo "Process substitution - comparing two directories (first 5 files):"
echo "/bin vs /usr/bin"
echo "(Sample comparison - actual output varies)"
echo "  /bin:    bash cat chmod cp date"
echo "  /usr/bin:awk gcc make perl python"
echo ""
echo "Files sorted by size (simulated):"
echo "  4.0K  script.sh"
echo "  2.0K  data.txt"
echo "  1.0K  README.md"
echo ""

# -----------------------------------------------------------------------------
# Example 10: Real-world Use Cases
# -----------------------------------------------------------------------------
echo "EXAMPLE 10: REAL-WORLD USE CASES"
echo "================================"
echo "Code:"

cat << 'EOF'
# 1. Dynamic filename with timestamp
backup_file="data_backup_$(date +%Y%m%d).sql"
echo "Backup file: $backup_file"

# 2. System monitoring
load_avg=$(uptime | awk -F'load average:' '{print $2}')
echo "System load: $load_avg"

# 3. Git status in prompt (simplified)
git_branch=$(git branch 2>/dev/null | grep '^*' | cut -d' ' -f2)
echo "Git branch: ${git_branch:-Not a git repo}"

# 4. Check service status
service_status=$(systemctl is-active sshd 2>/dev/null || echo "unknown")
echo "SSH service: $service_status"

# 5. Generate random password
random_pass=$(openssl rand -base64 12 2>/dev/null || echo "N/A")
echo "Random password: $random_pass"
EOF

echo "Output:"
backup_file="data_backup_$(date +%Y%m%d).sql"
echo "1. Backup file: $backup_file"
echo ""

load_avg="0.12, 0.08, 0.05"
echo "2. System load: $load_avg"
echo ""

git_branch=""
echo "3. Git branch: ${git_branch:-Not a git repo}"
echo ""

service_status="active"
echo "4. SSH service: $service_status"
echo ""

random_pass="s3cr3tp@ssw0rd"
echo "5. Random password: $random_pass"
echo ""

# -----------------------------------------------------------------------------
# SECTION 3: BEST PRACTICES & PITFALLS
# -----------------------------------------------------------------------------
echo ""
echo "3. BEST PRACTICES & PITFALLS"
echo "============================="
echo ""
echo "BEST PRACTICES:"
echo "---------------"
echo "1. Use \$( ) instead of backticks for readability and nesting"
echo "2. Quote command substitutions: \"\$(command)\""
echo "3. Use temporary variables for complex command substitutions"
echo "4. Check exit status: if output=\$(command); then ..."
echo "5. Redirect stderr for cleaner output: \$(command 2>/dev/null)"
echo ""
echo "COMMON PITFALLS:"
echo "----------------"
echo "1. Forgetting to quote:"
echo "   BAD:  for file in \$(ls *.txt); do"
echo "   GOOD: for file in \"\$(ls *.txt)\"; do"
echo ""
echo "2. Word splitting issues:"
echo "   BAD:  count=\$(ls | wc -l)  # May break with spaces"
echo "   GOOD: count=\$(find . -maxdepth 1 -type f | wc -l)"
echo ""
echo "3. Exit status lost:"
echo "   output=\$(command)"
echo "   if [ \$? -eq 0 ]; then  # Checks status of assignment, not command!"
echo "   Correct: if output=\$(command); then"
echo ""
echo "4. Performance with large outputs:"
echo "   Avoid: files=\$(find / -type f)  # May be huge"
echo "   Better: while IFS= read -r file; do ... done < <(find / -type f)"
echo ""
echo "5. Command injection vulnerability:"
echo "   UNSAFE: rm -rf \$(user_input)"
echo "   SAFE:   rm -rf \"\$(basename \"\$user_input\")\""
echo ""

# -----------------------------------------------------------------------------
# SECTION 4: PERFORMANCE CONSIDERATIONS
# -----------------------------------------------------------------------------
echo ""
echo "4. PERFORMANCE CONSIDERATIONS"
echo "============================="
echo ""
echo "SLOW (Creates subshell, captures ALL output):"
echo "  files=\$(find /var/log -type f)"
echo "  for file in \$files; do"
echo "    echo \"\$file\""
echo "  done"
echo ""
echo "FASTER (Processes line by line):"
echo "  find /var/log -type f | while read -r file; do"
echo "    echo \"\$file\""
echo "  done"
echo ""
echo "FASTEST (Bash process substitution):"
echo "  while IFS= read -r file; do"
echo "    echo \"\$file\""
echo "  done < <(find /var/log -type f)"
echo ""
echo "MEMORY USAGE:"
echo "------------"
echo "• Command substitution stores ALL output in memory"
echo "• For large outputs, use pipes or process substitution"
echo "• Example: \$(cat large_file) vs while read line; do ... done < large_file"
echo ""

# -----------------------------------------------------------------------------
# SECTION 5: ALTERNATIVES & RELATED CONCEPTS
# -----------------------------------------------------------------------------
echo ""
echo "5. ALTERNATIVES & RELATED CONCEPTS"
echo "=================================="
echo ""
echo "PROCESS SUBSTITUTION:"
echo "--------------------"
echo "Syntax: <(command) or >(command)"
echo "Use: Treat command output as file"
echo "Example: diff <(ls dir1) <(ls dir2)"
echo ""
echo "HERESTRING:"
echo "----------"
echo "Syntax: command <<< \"string\""
echo "Use: Pass string as stdin"
echo "Example: grep \"pattern\" <<< \"\$text\""
echo ""
echo "PIPELINES:"
echo "---------"
echo "Syntax: command1 | command2"
echo "Use: Pass output directly to next command"
echo "Example: ls -la | grep \"txt\""
echo ""
echo "EXEC COMMAND:"
echo "------------"
echo "Syntax: exec < <(command)"
echo "Use: Redirect command output to stdin"
echo "Example: exec 3< <(command); read -u 3 line"
echo ""

# -----------------------------------------------------------------------------
# SECTION 6: QUICK REFERENCE CHEAT SHEET
# -----------------------------------------------------------------------------
echo ""
echo "6. QUICK REFERENCE CHEAT SHEET"
echo "=============================="
echo ""
echo "BASIC SYNTAX:"
echo "------------"
echo "Variable assignment: var=\$(command)"
echo "In string:          echo \"Output: \$(command)\""
echo "Nested:             \$(command1 \$(command2))"
echo "Old style:          var=\`command\`"
echo ""
echo "WITH CONDITIONALS:"
echo "-----------------"
echo "Check success:      if output=\$(command); then"
echo "Check failure:      if ! output=\$(command); then"
echo "Test output:        if [ -n \"\$(command)\" ]; then"
echo ""
echo "WITH LOOPS:"
echo "----------"
echo "For loop:           for item in \$(command); do"
echo "While loop:         while read -r line; do ... done <<< \"\$(command)\""
echo "Process sub:        while read -r line; do ... done < <(command)"
echo ""
echo "REDIRECTION:"
echo "-----------"
echo "Ignore stderr:      \$(command 2>/dev/null)"
echo "Ignore all output:  \$(command >/dev/null 2>&1)"
echo "Capture stderr:     \$(command 2>&1)"
echo ""
echo "ARRAYS:"
echo "------"
echo "Create array:       array=(\$(command))"
echo "Mapfile:            mapfile -t array < <(command)"
echo "Read into array:    IFS='\n' read -ra array <<< \"\$(command)\""
echo ""
echo "PERFORMANCE TIPS:"
echo "----------------"
echo "• Use process substitution for large outputs"
echo "• Avoid command substitution in tight loops"
echo "• Use pipelines when possible"
echo "• Consider using xargs for file processing"
echo ""
echo "========================================================================"
echo "                     END OF COMMAND SUBSTITUTION GUIDE"
echo "========================================================================"