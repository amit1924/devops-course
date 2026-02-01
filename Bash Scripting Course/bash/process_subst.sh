#!/bin/bash

# =============================================================================
# COMPLETE GUIDE TO PROCESS SUBSTITUTION IN BASH
# =============================================================================

echo "========================================================================"
echo "            COMPLETE GUIDE TO PROCESS SUBSTITUTION"
echo "========================================================================"

# -----------------------------------------------------------------------------
# SECTION 1: THEORY & CONCEPTS
# -----------------------------------------------------------------------------
echo ""
echo "1. THEORY & CONCEPTS"
echo "===================="
echo ""
echo "WHAT IS PROCESS SUBSTITUTION?"
echo "------------------------------"
echo "• Makes command output appear as a file"
echo "• Syntax: <(command) or >(command)"
echo "• Creates a named pipe (FIFO) or temporary file"
echo "• Available in Bash, Zsh, Ksh"
echo ""
echo "HOW IT WORKS:"
echo "-------------"
echo "• <(command) : Creates a file descriptor for reading"
echo "• >(command) : Creates a file descriptor for writing"
echo "• Returns a special file path like /dev/fd/63"
echo "• Process runs in background, output/input goes through the file"
echo ""
echo "WHY USE PROCESS SUBSTITUTION?"
echo "------------------------------"
echo "• Compare outputs of two commands"
echo "• Feed command output to programs expecting files"
echo "• Avoid creating temporary files"
echo "• Multiple input streams"
echo "• Preserve variables in pipelines"
echo ""
echo "VS COMMAND SUBSTITUTION:"
echo "------------------------"
echo "• Command substitution: \$(cmd) - Captures output as string"
echo "• Process substitution: <(cmd) - Makes output appear as file"
echo ""

# -----------------------------------------------------------------------------
# SECTION 2: BASIC SYNTAX & EXAMPLES
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Example 1: Basic Input Process Substitution (<)
# -----------------------------------------------------------------------------
echo ""
echo "2. BASIC SYNTAX - INPUT <(command)"
echo "=================================="
echo "Syntax: command <(command_to_generate_input)"
echo ""

echo "EXAMPLE 1: DIFF TWO COMMAND OUTPUTS"
echo "-----------------------------------"
echo "Code:"
echo "diff <(ls /bin) <(ls /usr/bin)"
echo ""
echo "# More practical - compare sorted lists"
echo "echo \"Differences between /bin and /usr/bin:\""
echo "diff <(ls /bin | sort) <(ls /usr/bin | sort) | head -10"
echo ""

echo "Output (sample):"
echo "Differences between /bin and /usr/bin:"
ls /bin 2>/dev/null | sort > /tmp/bin_list
ls /usr/bin 2>/dev/null | sort > /tmp/usrbin_list
diff /tmp/bin_list /tmp/usrbin_list 2>/dev/null | head -10 || echo "  (Directories may not exist or no differences)"
echo ""

echo "EXAMPLE 2: GREP MULTIPLE FILES"
echo "------------------------------"
echo "Code:"
echo "echo 'Looking for bash in common directories:'"
echo "grep -l 'bash' <(find /etc -name '*bash*' -type f 2>/dev/null) \\"
echo "               <(find /usr -name '*bash*' -type f 2>/dev/null 2>/dev/null)"
echo ""

echo "Output (simulated):"
echo "Looking for bash in common directories:"
echo "  /etc/bash.bashrc"
echo "  /usr/bin/bash"
echo ""

# -----------------------------------------------------------------------------
# Example 2: Output Process Substitution (>)
# -----------------------------------------------------------------------------
echo ""
echo "3. BASIC SYNTAX - OUTPUT >(command)"
echo "==================================="
echo "Syntax: command >(command_to_process_output)"
echo ""

echo "EXAMPLE 1: TEE TO MULTIPLE PROCESSES"
echo "------------------------------------"
echo "Code:"
echo "echo 'Processing data...'"
echo "ls -la | tee >(grep '^d' | wc -l > dir_count.txt) \\"
echo "            >(grep '^-' | wc -l > file_count.txt) \\"
echo "            >(wc -l > total_count.txt)"
echo "echo 'Counts saved to files'"
echo ""

echo "Output:"
echo "Processing data..."
# Simulate the output
ls -la 2>/dev/null | head -5
echo "..."
echo "Counts saved to files"
echo ""

echo "EXAMPLE 2: LOGGING WHILE DISPLAYING"
echo "-----------------------------------"
echo "Code:"
echo "echo 'Running process with logging:'"
echo "df -h | tee >(grep '/$' > root_usage.txt) \\"
echo "          >(awk '{print \$1, \$5}' > all_partitions.txt) \\"
echo "          | column -t"
echo "echo 'Logs created: root_usage.txt, all_partitions.txt'"
echo ""

echo "Output:"
echo "Running process with logging:"
df -h 2>/dev/null | head -5 | column -t
echo "Logs created: root_usage.txt, all_partitions.txt"
echo ""

# -----------------------------------------------------------------------------
# SECTION 3: ADVANCED USAGE PATTERNS
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Example 3: Multiple Input Streams
# -----------------------------------------------------------------------------
echo ""
echo "4. MULTIPLE INPUT STREAMS"
echo "========================="
echo ""

echo "EXAMPLE 1: PASTE COMMAND (COMBINE COLUMNS)"
echo "------------------------------------------"
echo "Code:"
echo "echo 'Combining two command outputs:'"
echo "paste <(seq 1 5) <(ls /bin | head -5)"
echo ""

echo "Output:"
echo "Combining two command outputs:"
seq 1 5 | paste - <(ls /bin 2>/dev/null | head -5) 2>/dev/null || echo "1	/bin/bash"
echo "2	/bin/cat"
echo "3	/bin/chmod"
echo "4	/bin/cp"
echo "5	/bin/date"
echo ""

echo "EXAMPLE 2: JOIN TWO SORTED LISTS"
echo "--------------------------------"
echo "Code:"
echo "# Get users from passwd and groups from group file"
echo "echo 'Users and their primary groups:'"
echo "join -t: -1 1 -2 1 \\"
echo "  <(cut -d: -f1,4 /etc/passwd | sort) \\"
echo "  <(cut -d: -f1,3 /etc/group | sort) 2>/dev/null | head -5"
echo ""

echo "Output (simulated):"
echo "Users and their primary groups:"
echo "root:0:0"
echo "daemon:1:1"
echo "bin:2:2"
echo "sys:3:3"
echo "adm:4:4"
echo ""

# -----------------------------------------------------------------------------
# Example 4: While Read Loops
# -----------------------------------------------------------------------------
echo ""
echo "5. WHILE READ LOOPS WITH PROCESS SUBSTITUTION"
echo "============================================="
echo ""

echo "EXAMPLE 1: PROCESS EACH LINE WITH VARIABLES INTACT"
echo "--------------------------------------------------"
echo "Code:"
echo "counter=0"
echo "while read -r line; do"
echo "    ((counter++))"
echo "    echo \"Line \$counter: \$line\""
echo "done < <(find /etc -maxdepth 1 -type f -name '*.conf' | head -5)"
echo "echo \"Total files processed: \$counter\""
echo ""
echo "# Compare with pipeline (counter would be lost):"
echo "# find ... | while read line; do ((counter++)); done"
echo "# echo \"Counter after pipeline: \$counter\" # Would be 0!"
echo ""

echo "Output:"
counter=0
echo "Looking for .conf files in /etc:"
while read -r line; do
    ((counter++))
    echo "  Line $counter: $(basename "$line" 2>/dev/null)"
done < <(find /etc -maxdepth 1 -type f -name '*.conf' 2>/dev/null | head -5)
echo "Total files processed: $counter"
echo ""

echo "EXAMPLE 2: PROCESS MULTIPLE STREAMS"
echo "-----------------------------------"
echo "Code:"
echo "echo 'Processing two streams simultaneously:'"
echo "while read -r file1 && read -r file2 <&3; do"
echo "    echo \"File1: \$file1 | File2: \$file2\""
echo "done < <(ls /bin/* 2>/dev/null | head -3) \\"
echo "     3< <(ls /usr/bin/* 2>/dev/null | head -3)"
echo ""

echo "Output:"
echo "Processing two streams simultaneously:"
ls /bin/* 2>/dev/null | head -3 > /tmp/bin_files
ls /usr/bin/* 2>/dev/null | head -3 > /tmp/usrbin_files
paste -d '|' /tmp/bin_files /tmp/usrbin_files 2>/dev/null | sed 's/^/  File1: /; s/|/ | File2: /' || echo "  File1: /bin/bash | File2: /usr/bin/awk"
echo ""

# -----------------------------------------------------------------------------
# Example 5: Complex Data Processing
# -----------------------------------------------------------------------------
echo ""
echo "6. COMPLEX DATA PROCESSING"
echo "=========================="
echo ""

echo "EXAMPLE 1: AGGREGATE DATA FROM MULTIPLE SOURCES"
echo "-----------------------------------------------"
echo "Code:"
echo "echo 'Disk usage analysis:'"
echo "df -h | awk 'NR>1 {print \$1, \$5}' > disk_usage.txt"
echo ""
echo "# Compare with memory usage"
echo "paste \\"
echo "  <(sort -k1 disk_usage.txt) \\"
echo "  <(free -h | awk '/^Mem:/ {print \"memory\", \$3\"/\"\$2}') \\"
echo "  | column -t"
echo ""

echo "Output:"
echo "Disk usage analysis:"
df -h 2>/dev/null | awk 'NR>1 {print $1, $5}' | head -3 | column -t
echo "..."
free -h 2>/dev/null | awk '/^Mem:/ {print "Memory usage:", $3"/"$2}'
echo ""

echo "EXAMPLE 2: REAL-TIME MONITORING"
echo "-------------------------------"
echo "Code:"
echo "# Monitor both disk and CPU simultaneously"
echo "echo 'System Monitor (refresh every 2s):'"
echo "for i in {1..3}; do"
echo "    paste \\"
echo "      <(df -h / | awk 'NR==2 {print \"Disk:\", \$5}') \\"
echo "      <(top -bn1 | grep 'Cpu' | awk '{print \"CPU:\", \$2\"%\"}')"
echo "    sleep 2"
echo "done"
echo ""

echo "Output (simulated):"
echo "System Monitor (refresh every 2s):"
echo "Disk: 45%	CPU: 12%"
echo "Disk: 45%	CPU: 8%"
echo "Disk: 45%	CPU: 15%"
echo ""

# -----------------------------------------------------------------------------
# SECTION 4: COMPARISON WITH OTHER TECHNIQUES
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Example 6: Process Substitution vs Pipelines
# -----------------------------------------------------------------------------
echo ""
echo "7. PROCESS SUBSTITUTION VS PIPELINES"
echo "===================================="
echo ""

echo "EXAMPLE: VARIABLE SCOPE PRESERVATION"
echo "------------------------------------"
echo "Code:"
echo "echo '=== PIPELINE (variable lost) ==='"
echo "counter=0"
echo "seq 1 5 | while read num; do"
echo "    ((counter++))"
echo "    echo \"Inside: \$counter\""
echo "done"
echo "echo \"Outside after pipeline: \$counter\"  # Still 0!"
echo ""
echo "echo '=== PROCESS SUBSTITUTION (variable preserved) ==='"
echo "counter=0"
echo "while read num; do"
echo "    ((counter++))"
echo "    echo \"Inside: \$counter\""
echo "done < <(seq 1 5)"
echo "echo \"Outside after process sub: \$counter\"  # Correct: 5"
echo ""

echo "Output:"
echo "=== PIPELINE (variable lost) ==="
counter=0
seq 1 5 | while read num; do
    ((counter++))
    echo "  Inside: $counter"
done
echo "Outside after pipeline: $counter"
echo ""
echo "=== PROCESS SUBSTITUTION (variable preserved) ==="
counter=0
while read num; do
    ((counter++))
    echo "  Inside: $counter"
done < <(seq 1 5)
echo "Outside after process sub: $counter"
echo ""

# -----------------------------------------------------------------------------
# Example 7: Process Substitution vs Temporary Files
# -----------------------------------------------------------------------------
echo ""
echo "8. PROCESS SUBSTITUTION VS TEMPORARY FILES"
echo "=========================================="
echo ""

echo "EXAMPLE: CLEANER CODE WITHOUT TEMP FILES"
echo "----------------------------------------"
echo "Code:"
echo "# With temporary files (messy)"
echo "ls /bin > /tmp/bin_list.txt"
echo "ls /usr/bin > /tmp/usrbin_list.txt"
echo "diff /tmp/bin_list.txt /tmp/usrbin_list.txt"
echo "rm /tmp/bin_list.txt /tmp/usrbin_list.txt"
echo ""
echo "# With process substitution (clean)"
echo "diff <(ls /bin) <(ls /usr/bin)"
echo ""
echo "echo 'Advantages:'"
echo "echo '1. No cleanup needed'"
echo "echo '2. More readable'"
echo "echo '3. No race conditions'"
echo "echo '4. Automatic cleanup on exit'"
echo ""

# -----------------------------------------------------------------------------
# SECTION 5: REAL-WORLD USE CASES
# -----------------------------------------------------------------------------
echo ""
echo "9. REAL-WORLD USE CASES"
echo "======================="
echo ""

echo "USE CASE 1: CONFIGURATION VALIDATION"
echo "------------------------------------"
cat << 'EOF'
# Compare current config with backup
echo "Checking config changes:"
diff <(sort /etc/ssh/sshd_config) \
     <(sort /etc/ssh/sshd_config.backup) \
     && echo "No changes" || echo "Changes detected"

# Validate against template
grep -v -f <(awk '/^#/ {print $1}' template.conf) \
           current.conf > unmatched_settings.txt
EOF
echo ""

echo "USE CASE 2: LOG ANALYSIS"
echo "------------------------"
cat << 'EOF'
# Analyze multiple log files simultaneously
echo "Error frequency analysis:"
paste \
  <(grep -c ERROR /var/log/syslog) \
  <(grep -c ERROR /var/log/auth.log) \
  <(grep -c ERROR /var/log/kern.log) \
  | awk '{print "Syslog:", $1, "Auth:", $2, "Kern:", $3}'

# Find patterns across logs
grep -h "Failed password" \
  <(zcat /var/log/auth.log.*.gz 2>/dev/null) \
  <(cat /var/log/auth.log) \
  | wc -l
EOF
echo ""

echo "USE CASE 3: DATA SYNCHRONIZATION CHECK"
echo "--------------------------------------"
cat << 'EOF'
# Compare local and remote directories
echo "Comparing local and remote:"
diff \
  <(ssh user@remote "find /data -type f -exec md5sum {} \;" | sort) \
  <(find /data -type f -exec md5sum {} \; | sort) \
  > sync_diff.txt

# Check file count mismatch
paste \
  <(ssh user@remote "find /backup -type f | wc -l") \
  <(find /backup -type f | wc -l) \
  | awk '{diff = $1 - $2; print "File count difference:", diff}'
EOF
echo ""

echo "USE CASE 4: SYSTEM MONITORING DASHBOARD"
echo "---------------------------------------"
cat << 'EOF'
# Create a monitoring dashboard
watch -n 5 '
echo "=== SYSTEM STATUS ==="
paste \
  <(df -h / | awk "NR==2 {print \"Disk:\", \$5}") \
  <(free -h | awk "/^Mem:/ {print \"Memory:\", \$3\"/\"\$2}") \
  <(uptime | awk "{print \"Load:\", \$(NF-2), \$(NF-1), \$NF}") \
  <(sensors | grep "Core" | head -1 | awk "{print \"Temp:\", \$3}") \
  | column -t
'
EOF
echo ""

echo "USE CASE 5: BATCH FILE PROCESSING"
echo "---------------------------------"
cat << 'EOF'
# Process multiple file types simultaneously
echo "Processing files:"
while read -r img && read -r txt <&3; do
    echo "Converting $img with caption from $txt"
    # convert "$img" -caption "$(<"$txt")" "output_${img%.*}.jpg"
done < <(find . -name "*.jpg" | head -5) \
     3< <(find . -name "*.txt" | head -5)
EOF
echo ""

# -----------------------------------------------------------------------------
# SECTION 6: LIMITATIONS & WORKAROUNDS
# -----------------------------------------------------------------------------
echo ""
echo "10. LIMITATIONS & WORKAROUNDS"
echo "============================="
echo ""
echo "LIMITATION 1: NOT PORTABLE"
echo "--------------------------"
echo "• Works in Bash, Zsh, Ksh"
echo "• NOT in POSIX sh (dash)"
echo "• Workaround: Use temporary files for portability"
echo ""
echo "LIMITATION 2: CAN'T USE WITH REDIRECTION OPERATORS"
echo "--------------------------------------------------"
echo "BAD:  cmd < <(gen_input) > >(process_output)   # Syntax error"
echo "GOOD: cmd < <(gen_input) | tee >(process_output)"
echo ""
echo "LIMITATION 3: ORDER NOT GUARANTEED"
echo "----------------------------------"
echo "• Multiple >() processes may complete in any order"
echo "• Use wait or synchronization for ordered processing"
echo ""
echo "LIMITATION 4: LARGE OUTPUTS"
echo "---------------------------"
echo "• May create large temporary files"
echo "• Use streaming processing when possible"
echo "• Consider using named pipes directly"
echo ""

# -----------------------------------------------------------------------------
# SECTION 7: PERFORMANCE CONSIDERATIONS
# -----------------------------------------------------------------------------
echo ""
echo "11. PERFORMANCE CONSIDERATIONS"
echo "=============================="
echo ""
echo "1. TEMPORARY FILES VS NAMED PIPES:"
echo "   • Process substitution uses named pipes (FIFO)"
echo "   • Faster than disk-based temp files"
echo "   • But still has overhead"
echo ""
echo "2. FOR LARGE DATA:"
echo "   • Streaming is better than loading all into memory"
echo "   • Use: while read line; do ... done < <(cmd)"
echo "   • Avoid: var=$(cmd)  # Loads all into memory"
echo ""
echo "3. MULTIPLE PROCESSES:"
echo "   • Each <() or >() creates a subshell"
echo "   • Too many can impact performance"
echo "   • Consider xargs or parallel for heavy processing"
echo ""

# -----------------------------------------------------------------------------
# SECTION 8: BEST PRACTICES
# -----------------------------------------------------------------------------
echo ""
echo "12. BEST PRACTICES"
echo "=================="
echo ""
echo "1. USE FOR READABILITY:"
echo "   • When command would need intermediate files"
echo "   • When comparing command outputs"
echo ""
echo "2. PRESERVE VARIABLES:"
echo "   • Use < <(cmd) instead of pipes for while loops"
echo "   • This keeps variables in current shell"
echo ""
echo "3. QUOTE CORRECTLY:"
echo "   • No quotes around <() or >()"
echo "   • Command inside can have its own quotes"
echo "   Example: diff <(grep 'pattern' file1) <(grep 'pattern' file2)"
echo ""
echo "4. ERROR HANDLING:"
echo "   • Check exit status of processes"
echo "   • Redirect stderr: <(cmd 2>/dev/null)"
echo "   • Use set -o pipefail when possible"
echo ""
echo "5. CLEANUP:"
echo "   • Named pipes are automatically cleaned up"
echo "   • But kill background processes if script exits early"
echo ""

# -----------------------------------------------------------------------------
# SECTION 9: COMMON PATTERNS CHEAT SHEET
# -----------------------------------------------------------------------------
echo ""
echo "13. COMMON PATTERNS CHEAT SHEET"
echo "================================"
echo ""
echo "COMPARE TWO COMMANDS:"
echo "--------------------"
echo "diff <(cmd1) <(cmd2)"
echo "comm <(sort file1) <(sort file2)"
echo ""
echo "MULTIPLE INPUTS:"
echo "--------------"
echo "paste <(cmd1) <(cmd2) <(cmd3)"
echo "join <(sort file1) <(sort file2)"
echo ""
echo "MULTIPLE OUTPUTS:"
echo "---------------"
echo "cmd | tee >(proc1) >(proc2) >(proc3)"
echo ""
echo "WHILE LOOPS (preserve vars):"
echo "---------------------------"
echo "while read line; do"
echo "    # process"
echo "done < <(cmd)"
echo ""
echo "WITH FILE DESCRIPTORS:"
echo "--------------------"
echo "exec 3< <(cmd1)"
echo "exec 4< <(cmd2)"
echo "# Use fd 3 and 4"
echo "exec 3<&- 4<&-  # Close"
echo ""
echo "COMMAND WITH ARGUMENTS:"
echo "----------------------"
echo "grep pattern <(find . -name \"*.txt\")"
echo ""
echo "COMPLEX FILTERING:"
echo "-----------------"
echo "grep -v -f <(awk '/^#/{print \$1}' exclude.txt) input.txt"
echo ""

# -----------------------------------------------------------------------------
# SECTION 10: PRACTICAL EXAMPLES
# -----------------------------------------------------------------------------
echo ""
echo "14. PRACTICAL EXAMPLES"
echo "======================"
echo ""

echo "EXAMPLE 1: FIND DUPLICATE FILES"
echo "-------------------------------"
cat << 'EOF'
# Find files with same content but different names
find . -type f -exec md5sum {} \; | \
awk '{print $1, $2}' | \
sort | \
awk '
{
    if ($1 == prev_md5) {
        if (!duplicate_found) {
            print prev_file
            duplicate_found = 1
        }
        print $2
    } else {
        duplicate_found = 0
    }
    prev_md5 = $1
    prev_file = $2
}' | \
sort -u > duplicates.txt
EOF
echo ""

echo "EXAMPLE 2: MONITOR LOG FOR PATTERNS"
echo "-----------------------------------"
cat << 'EOF'
# Watch log for errors and send alert
(
    echo "Monitoring started at $(date)"
    tail -f /var/log/syslog | \
    while read -r line; do
        if echo "$line" | grep -q "ERROR\|CRITICAL\|FAILED"; then
            echo "[ALERT] $(date): $line"
            # Could add: mail, notification, etc.
        fi
    done
) &> monitoring.log &
EOF
echo ""

echo "EXAMPLE 3: PARALLEL PROCESSING"
echo "------------------------------"
cat << 'EOF'
# Process files in parallel
for file in *.csv; do
    echo "Processing $file"
    (
        # Complex processing in subshell
        awk -F, '{sum += $3} END {print FILENAME, sum/NR}' "$file"
    ) > >(cat >> results.txt) &
done
wait
echo "All files processed"
sort results.txt
EOF
echo ""

echo "========================================================================"
echo "                     END OF PROCESS SUBSTITUTION GUIDE"
echo "========================================================================"