#!/bin/bash

# =============================================================================
# COMPLETE GUIDE TO cat (CONCATENATE) COMMAND
# =============================================================================

echo "========================================================================"
echo "            COMPLETE GUIDE TO cat COMMAND"
echo "========================================================================"

# Create sample files for examples
echo "Creating sample files..."
cat > file1.txt << 'EOF'
First file - Line 1
First file - Line 2
First file - Line 3
EOF

cat > file2.txt << 'EOF'
Second file - Line 1
Second file - Line 2
Second file - Line 3
EOF

cat > file3.txt << 'EOF'
Third file - Line 1
Third file - Line 2
Third file - Line 3
EOF

cat > empty.txt << 'EOF'
EOF

cat > special_chars.txt << 'EOF'
Line with tab:	tab here
Line with special chars: $HOME ~/*.txt
Multiple
empty


lines
EOF

# -----------------------------------------------------------------------------
# SECTION 1: THEORY & CONCEPTS
# -----------------------------------------------------------------------------
echo ""
echo "1. THEORY & CONCEPTS"
echo "===================="
echo ""
echo "WHAT IS cat?"
echo "------------"
echo "• cat = concatenate (concatenate files and print)"
echo "• Reads files sequentially and outputs their contents"
echo "• Part of GNU coreutils (available on all Unix-like systems)"
echo "• One of the most frequently used Unix commands"
echo ""
echo "PRIMARY USES:"
echo "-------------"
echo "1. Display file contents on terminal"
echo "2. Concatenate multiple files"
echo "3. Create new files"
echo "4. Append to existing files"
echo "5. Copy/combine files"
echo ""
echo "BASIC SYNTAX:"
echo "-------------"
echo "cat [OPTION]... [FILE]..."
echo ""
echo "WITH NO FILE or FILE IS '-': Reads from standard input"
echo ""

# -----------------------------------------------------------------------------
# SECTION 2: BASIC USAGE WITH EXAMPLES
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Example 1: Display Single File
# -----------------------------------------------------------------------------
echo ""
echo "2. BASIC USAGE - DISPLAY FILES"
echo "=============================="
echo ""

echo "EXAMPLE 1.1: DISPLAY SINGLE FILE"
echo "--------------------------------"
echo "Code: cat file1.txt"
echo "Output:"
cat file1.txt
echo ""

echo "EXAMPLE 1.2: DISPLAY MULTIPLE FILES"
echo "-----------------------------------"
echo "Code: cat file1.txt file2.txt"
echo "Output:"
cat file1.txt file2.txt
echo ""

echo "EXAMPLE 1.3: DISPLAY WITH GLOBBING"
echo "----------------------------------"
echo "Code: cat file*.txt"
echo "Output:"
cat file*.txt
echo ""

# -----------------------------------------------------------------------------
# Example 2: Create New Files
# -----------------------------------------------------------------------------
echo ""
echo "3. CREATING FILES"
echo "================="
echo ""

echo "EXAMPLE 2.1: CREATE FILE FROM STDIN (Ctrl+D to finish)"
echo "------------------------------------------------------"
echo "Code: cat > newfile.txt"
echo "Then type: Hello World"
echo "        : This is a new file"
echo "        : Press Ctrl+D"
echo ""
echo "Creating demo file programmatically:"
echo "Hello World" > newfile.txt
echo "This is a new file" >> newfile.txt
echo "Created newfile.txt with content:"
cat newfile.txt
echo ""

echo "EXAMPLE 2.2: CREATE FILE WITH HERE DOCUMENT"
echo "-------------------------------------------"
echo "Code: cat << 'EOF' > config.txt"
echo "PORT=8080"
echo "HOST=localhost"
echo "DEBUG=true"
echo "EOF"
echo ""
cat << 'EOF' > config.txt
PORT=8080
HOST=localhost
DEBUG=true
EOF
echo "Created config.txt:"
cat config.txt
echo ""

# -----------------------------------------------------------------------------
# Example 3: Append to Files
# -----------------------------------------------------------------------------
echo ""
echo "4. APPENDING TO FILES"
echo "====================="
echo ""

echo "EXAMPLE 3.1: APPEND TO EXISTING FILE"
echo "------------------------------------"
echo "Code: cat >> newfile.txt"
echo "Then type: Appended line"
echo "        : Another appended line"
echo "        : Press Ctrl+D"
echo ""
echo "Appending programmatically:"
echo "Appended line" >> newfile.txt
echo "Another appended line" >> newfile.txt
echo "Updated newfile.txt:"
cat newfile.txt
echo ""

echo "EXAMPLE 3.2: APPEND MULTIPLE FILES TO ANOTHER"
echo "---------------------------------------------"
echo "Code: cat file1.txt file2.txt >> combined.txt"
echo ""
cat file1.txt file2.txt >> combined.txt
echo "Created combined.txt:"
cat combined.txt
echo ""

# -----------------------------------------------------------------------------
# SECTION 3: USEFUL OPTIONS
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Example 4: Numbering Lines
# -----------------------------------------------------------------------------
echo ""
echo "5. LINE NUMBERING OPTIONS"
echo "========================="
echo ""

echo "EXAMPLE 4.1: NUMBER ALL LINES (-n)"
echo "----------------------------------"
echo "Code: cat -n file1.txt"
echo "Output:"
cat -n file1.txt
echo ""

echo "EXAMPLE 4.2: NUMBER NON-EMPTY LINES (-b)"
echo "----------------------------------------"
echo "Code: cat -b special_chars.txt"
echo "Output:"
cat -b special_chars.txt
echo ""

echo "COMPARISON:"
echo "-----------"
echo "Original special_chars.txt:"
cat special_chars.txt
echo ""
echo "With -n (all lines):"
cat -n special_chars.txt
echo ""
echo "With -b (non-empty only):"
cat -b special_chars.txt
echo ""

# -----------------------------------------------------------------------------
# Example 5: Display Special Characters
# -----------------------------------------------------------------------------
echo ""
echo "6. DISPLAY SPECIAL CHARACTERS"
echo "============================="
echo ""

echo "EXAMPLE 5.1: SHOW NON-PRINTING CHARACTERS (-A)"
echo "----------------------------------------------"
echo "Code: cat -A special_chars.txt"
echo "Output:"
cat -A special_chars.txt
echo ""

echo "EXAMPLE 5.2: SHOW TABS AS ^I (-T)"
echo "---------------------------------"
echo "Code: cat -T special_chars.txt"
echo "Output:"
cat -T special_chars.txt
echo ""

echo "EXAMPLE 5.3: SHOW END OF LINE AS $ (-E)"
echo "---------------------------------------"
echo "Code: cat -E special_chars.txt"
echo "Output:"
cat -E special_chars.txt
echo ""

echo "EXAMPLE 5.4: SHOW ALL SPECIAL CHARACTERS (-v)"
echo "---------------------------------------------"
echo "Code: echo -e 'Line with tab:\ttab' | cat -v"
echo "Output:"
echo -e 'Line with tab:\ttab' | cat -v
echo ""

# -----------------------------------------------------------------------------
# Example 6: Squeeze Blank Lines
# -----------------------------------------------------------------------------
echo ""
echo "7. SQUEEZE BLANK LINES (-s)"
echo "==========================="
echo ""

echo "EXAMPLE 6.1: SQUEEZE MULTIPLE EMPTY LINES"
echo "-----------------------------------------"
echo "Code: cat -s special_chars.txt"
echo "Output:"
cat -s special_chars.txt
echo ""

echo "COMPARISON:"
echo "-----------"
echo "Original file (with multiple empty lines):"
cat special_chars.txt
echo ""
echo "With -s (squeezed):"
cat -s special_chars.txt
echo ""

# -----------------------------------------------------------------------------
# SECTION 4: ADVANCED USAGE PATTERNS
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Example 7: Combine with Other Commands
# -----------------------------------------------------------------------------
echo ""
echo "8. COMBINING WITH OTHER COMMANDS"
echo "================================"
echo ""

echo "EXAMPLE 7.1: PIPE OUTPUT TO ANOTHER COMMAND"
echo "-------------------------------------------"
echo "Code: cat file1.txt | grep 'Line'"
echo "Output:"
cat file1.txt | grep 'Line'
echo ""

echo "EXAMPLE 7.2: COMBINE FILES AND SORT"
echo "-----------------------------------"
echo "Code: cat file1.txt file2.txt | sort"
echo "Output:"
cat file1.txt file2.txt | sort
echo ""

echo "EXAMPLE 7.3: COUNT LINES IN MULTIPLE FILES"
echo "------------------------------------------"
echo "Code: cat file*.txt | wc -l"
echo "Output: Total lines: $(cat file*.txt | wc -l)"
echo ""

echo "EXAMPLE 7.4: CREATE FILE FROM COMMAND OUTPUT"
echo "--------------------------------------------"
echo "Code: ls -la | cat > listing.txt"
echo ""
ls -la | cat > listing.txt
echo "Created listing.txt (first 5 lines):"
head -5 listing.txt
echo ""

# -----------------------------------------------------------------------------
# Example 8: Input Redirection Tricks
# -----------------------------------------------------------------------------
echo ""
echo "9. INPUT REDIRECTION TECHNIQUES"
echo "==============================="
echo ""

echo "EXAMPLE 8.1: READ FROM STDIN WITH -"
echo "-----------------------------------"
echo "Code: cat file1.txt - file2.txt"
echo "Then type: 'Input from keyboard' and Ctrl+D"
echo ""
echo "Simulating:"
echo "Input from keyboard" | cat file1.txt - file2.txt | head -6
echo "(Shows first 6 lines of combined output)"
echo ""

echo "EXAMPLE 8.2: HERE DOCUMENT WITH cat"
echo "-----------------------------------"
echo "Code: cat << 'MULTILINE'"
echo "Line 1"
echo "Line 2"
echo "Line 3"
echo "MULTILINE"
echo "Output:"
cat << 'MULTILINE'
Line 1
Line 2
Line 3
MULTILINE
echo ""

echo "EXAMPLE 8.3: HERE STRING"
echo "------------------------"
echo "Code: cat <<< 'Single line input'"
echo "Output:"
cat <<< 'Single line input'
echo ""

# -----------------------------------------------------------------------------
# Example 9: File Copy and Concatenation
# -----------------------------------------------------------------------------
echo ""
echo "10. FILE COPY & CONCATENATION"
echo "============================="
echo ""

echo "EXAMPLE 9.1: COPY FILE"
echo "----------------------"
echo "Code: cat source.txt > destination.txt"
echo ""
cp file1.txt source.txt
cat source.txt > destination.txt
echo "Copied source.txt to destination.txt:"
cat destination.txt
echo ""

echo "EXAMPLE 9.2: CONCATENATE INTO NEW FILE"
echo "--------------------------------------"
echo "Code: cat file1.txt file2.txt file3.txt > all_files.txt"
echo ""
cat file1.txt file2.txt file3.txt > all_files.txt
echo "Created all_files.txt (first 3 lines):"
head -3 all_files.txt
echo ""

echo "EXAMPLE 9.3: APPEND TO LOG FILE"
echo "-------------------------------"
echo "Code: echo '=== New Entry ===' | cat >> log.txt"
echo "      date | cat >> log.txt"
echo "      echo 'Action completed' | cat >> log.txt"
echo ""
echo '=== New Entry ===' | cat >> log.txt
date | cat >> log.txt
echo 'Action completed' | cat >> log.txt
echo "Created log.txt:"
cat log.txt
echo ""

# -----------------------------------------------------------------------------
# SECTION 5: REAL-WORLD USE CASES
# -----------------------------------------------------------------------------
echo ""
echo "11. REAL-WORLD USE CASES"
echo "========================"
echo ""

echo "USE CASE 1: VIEW CONFIGURATION FILES"
echo "------------------------------------"
cat << 'EOF'
# View system configuration
cat /etc/hosts
cat /etc/resolv.conf

# View application config
cat ~/.bashrc | grep -v '^#' | head -20

# Check service status
cat /var/log/syslog | tail -50
EOF
echo ""

echo "USE CASE 2: LOG FILE MONITORING"
echo "-------------------------------"
cat << 'EOF'
# Tail multiple logs
cat /var/log/auth.log /var/log/syslog | grep -i "fail"

# Combine logs with timestamps
cat /var/log/*.log | grep "$(date +'%Y-%m-%d')"

# Create daily report
cat /var/log/nginx/access.log | awk '{print $1}' | sort | uniq -c > daily_visitors.txt
EOF
echo ""

echo "USE CASE 3: DATA PROCESSING PIPELINES"
echo "-------------------------------------"
cat << 'EOF'
# Process CSV files
cat *.csv | grep -v "^#" | sort -u > combined.csv

# Extract data from multiple sources
cat server1.log server2.log server3.log | grep "ERROR" > all_errors.txt

# Create backup index
find /backup -type f -name "*.tar.gz" | cat > backup_index.txt
EOF
echo ""

echo "USE CASE 4: SCRIPTING AND AUTOMATION"
echo "------------------------------------"
cat << 'EOF'
# Create configuration from template
cat << 'CONFIG' > app.conf
PORT=${PORT:-8080}
HOST=${HOST:-localhost}
DEBUG=${DEBUG:-false}
CONFIG

# Generate HTML page
cat << 'HTML' > index.html
<!DOCTYPE html>
<html>
<head><title>${TITLE}</title></head>
<body>${CONTENT}</body>
</html>
HTML

# Create README from fragments
cat header.txt description.txt install.txt usage.txt > README.md
EOF
echo ""

echo "USE CASE 5: SYSTEM ADMINISTRATION"
echo "---------------------------------"
cat << 'EOF'
# Check disk usage
cat /proc/mounts | awk '{print $2}' | xargs df -h

# Monitor processes
cat /proc/loadavg
cat /proc/meminfo | grep -E "MemTotal|MemFree"

# Network connections
cat /proc/net/tcp | awk '{print $2, $3}' | head -10
EOF
echo ""

# -----------------------------------------------------------------------------
# SECTION 6: COMPARISON WITH RELATED COMMANDS
# -----------------------------------------------------------------------------
echo ""
echo "12. COMPARISON WITH RELATED COMMANDS"
echo "===================================="
echo ""

echo "cat vs less/more:"
echo "----------------"
echo "| Command | Purpose                          | Best for                  |"
echo "|---------|----------------------------------|---------------------------|"
echo "| cat     | Concatenate and display all      | Small files, piping       |"
echo "| less    | View file interactively          | Large files, navigation   |"
echo "| more    | View file page by page           | Simple paging             |"
echo ""

echo "cat vs head/tail:"
echo "----------------"
echo "| Command | Purpose                          | Example                   |"
echo "|---------|----------------------------------|---------------------------|"
echo "| cat     | Display entire file              | cat file.txt              |"
echo "| head    | Display beginning of file        | head -10 file.txt         |"
echo "| tail    | Display end of file              | tail -20 file.txt         |"
echo ""

echo "cat vs tee:"
echo "-----------"
echo "| Command | Purpose                          | Example                   |"
echo "|---------|----------------------------------|---------------------------|"
echo "| cat     | Read/write sequentially          | cat file1 > file2         |"
echo "| tee     | Read stdin, write stdout & file  | ls | tee listing.txt      |"
echo ""

# -----------------------------------------------------------------------------
# SECTION 7: COMMON PITFALLS & BEST PRACTICES
# -----------------------------------------------------------------------------
echo ""
echo "13. COMMON PITFALLS & BEST PRACTICES"
echo "===================================="
echo ""

echo "PITFALL 1: VIEWING BINARY FILES"
echo "-------------------------------"
echo "BAD: cat /bin/ls   # Will show garbage on terminal"
echo "GOOD: Use file, hexdump, or od for binary files"
echo "      file /bin/ls"
echo "      hexdump -C /bin/ls | head -20"
echo ""

echo "PITFALL 2: LARGE FILES"
echo "----------------------"
echo "BAD: cat huge_log_file.txt   # May freeze terminal"
echo "GOOD: Use less, tail, or head for large files"
echo "      less huge_log_file.txt"
echo "      tail -100 huge_log_file.txt"
echo ""

echo "PITFALL 3: OVERWRITING FILES"
echo "----------------------------"
echo "BAD: cat file1 > file1   # Will empty the file!"
echo "GOOD: Use temp file or sponge command"
echo "      cat file1 > temp && mv temp file1"
echo "      cat file1 | sponge file1   # If sponge is available"
echo ""

echo "BEST PRACTICE 1: ALWAYS QUOTE VARIABLES"
echo "---------------------------------------"
echo "GOOD: cat \"\$filename\""
echo "BAD:  cat \$filename    # Fails if filename has spaces"
echo ""

echo "BEST PRACTICE 2: CHECK FILE EXISTENCE"
echo "-------------------------------------"
echo "GOOD: if [ -f \"\$file\" ]; then cat \"\$file\"; fi"
echo "BAD:  cat \"\$file\"    # Shows error if file doesn't exist"
echo ""

echo "BEST PRACTICE 3: USE -n FOR DEBUGGING"
echo "-------------------------------------"
echo "When piping or redirecting, use -n to see line numbers:"
echo "  cat -n file.txt | grep 'error'"
echo ""

# -----------------------------------------------------------------------------
# SECTION 8: PERFORMANCE TIPS
# -----------------------------------------------------------------------------
echo ""
echo "14. PERFORMANCE TIPS"
echo "===================="
echo ""

echo "1. AVOID UNNECESSARY cat (UUOC - Useless Use of cat)"
echo "----------------------------------------------------"
echo "UUOC: cat file.txt | grep 'pattern'"
echo "Better: grep 'pattern' file.txt"
echo ""
echo "UUOC: cat file.txt | wc -l"
echo "Better: wc -l < file.txt"
echo ""

echo "2. USE REDIRECTION INSTEAD OF cat FOR SINGLE FILES"
echo "--------------------------------------------------"
echo "When creating from command output:"
echo "Slower: ls -la | cat > listing.txt"
echo "Faster: ls -la > listing.txt"
echo ""

echo "3. cat IS EFFICIENT FOR MULTIPLE FILES"
echo "--------------------------------------"
echo "Good: cat file1 file2 file3 > combined"
echo "This is what cat is designed for!"
echo ""

echo "4. BUFFERING CAN HELP WITH LARGE DATA"
echo "-------------------------------------"
echo "For large operations:"
echo "  cat bigfile.txt | buffer_command"
echo "Consider using:"
echo "  stdbuf -o0 cat bigfile.txt | buffer_command   # Disable buffering"
echo ""

# -----------------------------------------------------------------------------
# SECTION 9: QUICK REFERENCE CHEAT SHEET
# -----------------------------------------------------------------------------
echo ""
echo "15. QUICK REFERENCE CHEAT SHEET"
echo "==============================="
echo ""

echo "BASIC OPERATIONS:"
echo "----------------"
echo "Display file:                cat file.txt"
echo "Display multiple:            cat file1.txt file2.txt"
echo "Create file:                 cat > newfile.txt"
echo "Append to file:              cat >> existing.txt"
echo "Concatenate to new file:     cat file1 file2 > combined.txt"
echo ""

echo "USEFUL OPTIONS:"
echo "--------------"
echo "Number all lines:            cat -n file.txt"
echo "Number non-empty lines:      cat -b file.txt"
echo "Show end of lines ($):       cat -E file.txt"
echo "Show tabs as ^I:             cat -T file.txt"
echo "Show non-printing chars:     cat -A file.txt"
echo "Squeeze blank lines:         cat -s file.txt"
echo "Show non-printing:           cat -v file.txt"
echo ""

echo "INPUT METHODS:"
echo "-------------"
echo "Here document:               cat << EOF > file"
echo "Here string:                 cat <<< 'text'"
echo "Standard input:              cat -"
echo "From pipe:                   echo 'text' | cat"
echo ""

echo "COMMON COMBINATIONS:"
echo "-------------------"
echo "View with line numbers:      cat -n file.txt | less"
echo "Search in multiple:          cat *.log | grep 'error'"
echo "Count total lines:           cat *.txt | wc -l"
echo "Create from template:        cat << 'CONF' > config"
echo "Sort multiple files:         cat file1 file2 | sort"
echo "Remove empty lines:          cat file.txt | grep -v '^$'"
echo "Add header:                  echo 'Header' | cat - file.txt"
echo ""

echo "ONE-LINERS:"
echo "----------"
echo "# View latest log entries"
echo "cat /var/log/syslog | tail -100"
echo ""
echo "# Combine CSV files, remove comments"
echo "cat *.csv | grep -v '^#' > all_data.csv"
echo ""
echo "# Create script from template"
echo "cat << 'SCRIPT' > deploy.sh"
echo "#!/bin/bash"
echo "echo 'Deploying...'"
echo "SCRIPT"
echo ""
echo "# Monitor multiple logs in real-time"
echo "tail -f /var/log/nginx/*.log | cat"
echo ""

# -----------------------------------------------------------------------------
# SECTION 10: PRACTICAL EXAMPLES & EXERCISES
# -----------------------------------------------------------------------------
echo ""
echo "16. PRACTICAL EXAMPLES & EXERCISES"
echo "=================================="
echo ""

echo "EXERCISE 1: CREATE A CONFIGURATION MANAGER"
echo "------------------------------------------"
cat << 'EOF'
#!/bin/bash
# config_manager.sh

CONFIG_FILE="app.conf"

# Create default config if doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    cat > "$CONFIG_FILE" << 'DEFAULT'
# Application Configuration
PORT=8080
HOST=localhost
DEBUG=false
MAX_USERS=100
TIMEOUT=30
DEFAULT
    echo "Created default configuration"
fi

# Display config with line numbers
echo "Current configuration:"
cat -n "$CONFIG_FILE"

# Add new setting
echo ""
read -p "Enter new setting (KEY=VALUE): " new_setting
if [ -n "$new_setting" ]; then
    echo "$new_setting" >> "$CONFIG_FILE"
    echo "Added: $new_setting"
fi
EOF
echo ""

echo "EXERCISE 2: LOG FILE ANALYZER"
echo "-----------------------------"
cat << 'EOF'
#!/bin/bash
# log_analyzer.sh

LOG_DIR="/var/log"
REPORT_FILE="log_report_$(date +%Y%m%d).txt"

echo "=== Log Analysis Report ===" > "$REPORT_FILE"
echo "Generated: $(date)" >> "$REPORT_FILE"
echo "==========================" >> "$REPORT_FILE"

# Analyze each log file
for log_file in "$LOG_DIR"/*.log; do
    if [ -f "$log_file" ]; then
        echo "" >> "$REPORT_FILE"
        echo "=== $(basename "$log_file") ===" >> "$REPORT_FILE"
        echo "Total lines: $(wc -l < "$log_file")" >> "$REPORT_FILE"
        echo "Errors: $(grep -c -i "error" "$log_file")" >> "$REPORT_FILE"
        echo "Warnings: $(grep -c -i "warn" "$log_file")" >> "$REPORT_FILE"
        
        # Last 5 error lines
        echo "" >> "$REPORT_FILE"
        echo "Recent errors:" >> "$REPORT_FILE"
        grep -i "error" "$log_file" | tail -5 >> "$REPORT_FILE"
    fi
done

echo "Report generated: $REPORT_FILE"
cat "$REPORT_FILE"
EOF
echo ""

echo "EXERCISE 3: FILE MERGE UTILITY"
echo "------------------------------"
cat << 'EOF'
#!/bin/bash
# file_merge.sh

# Merge all text files in directory
merge_files() {
    local dir="$1"
    local output="$2"
    
    if [ ! -d "$dir" ]; then
        echo "Error: Directory not found"
        return 1
    fi
    
    echo "Merging files from $dir into $output"
    
    # Add header
    echo "=== Merged Files ===" > "$output"
    echo "Directory: $dir" >> "$output"
    echo "Date: $(date)" >> "$output"
    echo "===================" >> "$output"
    
    # Merge all .txt files
    for file in "$dir"/*.txt; do
        if [ -f "$file" ]; then
            echo "" >> "$output"
            echo "=== File: $(basename "$file") ===" >> "$output"
            cat "$file" >> "$output"
        fi
    done
    
    echo "Merge complete. Total lines: $(wc -l < "$output")"
}

# Usage: file_merge.sh /path/to/files output.txt
merge_files "${1:-.}" "${2:-merged_output.txt}"
EOF
echo ""

# Clean up temporary files
rm -f file1.txt file2.txt file3.txt empty.txt special_chars.txt newfile.txt \
      config.txt combined.txt all_files.txt log.txt source.txt destination.txt \
      listing.txt

echo "========================================================================"
echo "                     END OF cat COMMAND GUIDE"
echo "========================================================================"