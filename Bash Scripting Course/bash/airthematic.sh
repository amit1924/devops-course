#!/bin/bash

# =============================================================================
# COMPLETE GUIDE TO ARITHMETIC EXPRESSIONS IN BASH
# =============================================================================

echo "========================================================================"
echo "            COMPLETE GUIDE TO ARITHMETIC EXPRESSIONS"
echo "========================================================================"

# -----------------------------------------------------------------------------
# SECTION 1: THEORY & CONCEPTS
# -----------------------------------------------------------------------------
echo ""
echo "1. THEORY & CONCEPTS"
echo "===================="
echo ""
echo "ARITHMETIC IN BASH:"
echo "-------------------"
echo "• Bash can perform integer arithmetic operations"
echo "• Three main syntaxes: \$(( )), let, expr"
echo "• Only integer arithmetic (no floating point)"
echo "• For floating point, use bc, awk, or printf"
echo ""
echo "WHY ARITHMETIC IN SCRIPTS?"
echo "--------------------------"
echo "• Counters and loops"
echo "• Mathematical calculations"
echo "• Index calculations for arrays"
echo "• Bitwise operations"
echo "• File size calculations"
echo "• Performance monitoring"
echo ""
echo "KEY POINTS:"
echo "----------"
echo "• Variables inside \$(( )) don't need \$ prefix"
echo "• No spaces allowed around operators (except in expr)"
echo "• Exit code 0 for success, 1 for failure (division by zero)"
echo ""

# -----------------------------------------------------------------------------
# SECTION 2: SYNTAX METHODS WITH EXAMPLES
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Method 1: $(( )) - ARITHMETIC EXPANSION (PREFERRED)
# -----------------------------------------------------------------------------
echo ""
echo "2. SYNTAX METHODS - \$(( )) (PREFERRED)"
echo "======================================"
echo "Syntax: \$(( expression ))"
echo "Note: No \$ needed for variables inside"
echo ""

echo "EXAMPLE 1: BASIC OPERATIONS"
echo "---------------------------"
echo "Code:"
echo "a=10"
echo "b=3"
echo "echo \"Addition:       \$((a + b))\"          # 13"
echo "echo \"Subtraction:    \$((a - b))\"          # 7"
echo "echo \"Multiplication: \$((a * b))\"          # 30"
echo "echo \"Division:       \$((a / b))\"          # 3 (integer)"
echo "echo \"Modulus:        \$((a % b))\"          # 1"
echo "echo \"Exponentiation: \$((a ** b))\"         # 1000"
echo ""

a=10
b=3
echo "Output:"
echo "Addition:       $((a + b))"
echo "Subtraction:    $((a - b))"
echo "Multiplication: $((a * b))"
echo "Division:       $((a / b))"
echo "Modulus:        $((a % b))"
echo "Exponentiation: $((a ** b))"
echo ""

echo "EXAMPLE 2: COMPLEX EXPRESSIONS"
echo "------------------------------"
echo "Code:"
echo "x=5"
echo "y=2"
echo "z=3"
echo "echo \"Complex: \$((x * (y + z) / 2))\"     # 12"
echo "echo \"Nested:  \$(( (x**y) + (z*2) ))\"    # 31"
echo "echo \"Mixed:   \$(( x * y + z / 2 ))\"     # 11"
echo ""

x=5
y=2
z=3
echo "Output:"
echo "Complex: $((x * (y + z) / 2))"
echo "Nested:  $(( (x**y) + (z*2) ))"
echo "Mixed:   $(( x * y + z / 2 ))"
echo ""

echo "EXAMPLE 3: INCREMENT/DECREMENT OPERATORS"
echo "----------------------------------------"
echo "Code:"
echo "counter=5"
echo "echo \"Original: \$counter\""
echo "echo \"Post-increment: \$((counter++))\"     # 5"
echo "echo \"After post-inc: \$counter\"          # 6"
echo "echo \"Pre-increment: \$((++counter))\"     # 7"
echo "echo \"After pre-inc: \$counter\"           # 7"
echo "echo \"Post-decrement: \$((counter--))\"    # 7"
echo "echo \"After post-dec: \$counter\"          # 6"
echo ""

counter=5
echo "Output:"
echo "Original: $counter"
echo "Post-increment: $((counter++))"
echo "After post-inc: $counter"
echo "Pre-increment: $((++counter))"
echo "After pre-inc: $counter"
echo "Post-decrement: $((counter--))"
echo "After post-dec: $counter"
echo ""

# -----------------------------------------------------------------------------
# Method 2: let COMMAND
# -----------------------------------------------------------------------------
echo ""
echo "3. SYNTAX METHODS - let COMMAND"
echo "==============================="
echo "Syntax: let 'expression'"
echo "Note: No \$ output, stores result in variable"
echo ""

echo "EXAMPLE 1: BASIC LET OPERATIONS"
echo "-------------------------------"
echo "Code:"
echo "let result=5+3"
echo "echo \"5 + 3 = \$result\""
echo ""
echo "let \"x = 10 * 2\""
echo "let \"y = x / 4\""
echo "echo \"x = \$x, y = \$y\""
echo ""
echo "let \"z = 2 ** 4\""
echo "echo \"2^4 = \$z\""
echo ""

let result=5+3
echo "Output:"
echo "5 + 3 = $result"

let "x = 10 * 2"
let "y = x / 4"
echo "x = $x, y = $y"

let "z = 2 ** 4"
echo "2^4 = $z"
echo ""

echo "EXAMPLE 2: INCREMENT WITH LET"
echo "-----------------------------"
echo "Code:"
echo "count=5"
echo "let count++"
echo "echo \"After increment: \$count\""
echo ""
echo "let \"count += 3\""
echo "echo \"After add 3: \$count\""
echo ""
echo "let \"count *= 2\""
echo "echo \"After multiply by 2: \$count\""
echo ""

count=5
let count++
echo "Output:"
echo "After increment: $count"

let "count += 3"
echo "After add 3: $count"

let "count *= 2"
echo "After multiply by 2: $count"
echo ""

# -----------------------------------------------------------------------------
# Method 3: expr COMMAND (LEGACY)
# -----------------------------------------------------------------------------
echo ""
echo "4. SYNTAX METHODS - expr COMMAND (LEGACY)"
echo "========================================="
echo "Syntax: expr expression"
echo "Note: Requires spaces around operators"
echo ""

echo "EXAMPLE 1: BASIC EXPR OPERATIONS"
echo "--------------------------------"
echo "Code:"
echo "echo \"Addition:       \$(expr 10 + 3)\"      # 13"
echo "echo \"Subtraction:    \$(expr 10 - 3)\"      # 7"
echo "echo \"Multiplication: \$(expr 10 \\* 3)\"    # 30 (escape *)"
echo "echo \"Division:       \$(expr 10 / 3)\"      # 3"
echo "echo \"Modulus:        \$(expr 10 % 3)\"      # 1"
echo ""

echo "Output:"
echo "Addition:       $(expr 10 + 3)"
echo "Subtraction:    $(expr 10 - 3)"
echo "Multiplication: $(expr 10 \* 3)"
echo "Division:       $(expr 10 / 3)"
echo "Modulus:        $(expr 10 % 3)"
echo ""

echo "EXAMPLE 2: EXPR WITH VARIABLES"
echo "------------------------------"
echo "Code:"
echo "num1=15"
echo "num2=4"
echo "result=\$(expr \$num1 / \$num2)"
echo "echo \"15 / 4 = \$result\""
echo ""

num1=15
num2=4
result=$(expr $num1 / $num2)
echo "Output:"
echo "15 / 4 = $result"
echo ""

# -----------------------------------------------------------------------------
# Method 4: ARITHMETIC COMPARISON
# -----------------------------------------------------------------------------
echo ""
echo "5. ARITHMETIC COMPARISON OPERATORS"
echo "=================================="
echo "Used inside (( )) for conditional arithmetic"
echo ""

echo "EXAMPLE: COMPARISON OPERATORS"
echo "-----------------------------"
echo "Code:"
echo "a=10"
echo "b=20"
echo ""
echo "(( a < b )) && echo \"\$a < \$b is true\""
echo "(( a > b )) || echo \"\$a > \$b is false\""
echo "(( a == 10 )) && echo \"\$a == 10 is true\""
echo "(( a != b )) && echo \"\$a != \$b is true\""
echo "(( a <= 10 )) && echo \"\$a <= 10 is true\""
echo "(( b >= 20 )) && echo \"\$b >= 20 is true\""
echo ""

a=10
b=20
echo "Output:"
(( a < b )) && echo "$a < $b is true"
(( a > b )) || echo "$a > $b is false"
(( a == 10 )) && echo "$a == 10 is true"
(( a != b )) && echo "$a != $b is true"
(( a <= 10 )) && echo "$a <= 10 is true"
(( b >= 20 )) && echo "$b >= 20 is true"
echo ""

# -----------------------------------------------------------------------------
# SECTION 3: BITWISE OPERATIONS
# -----------------------------------------------------------------------------
echo ""
echo "6. BITWISE OPERATIONS"
echo "====================="
echo ""

echo "EXAMPLE: BITWISE OPERATORS"
echo "--------------------------"
echo "Code:"
echo "x=5    # 0101 binary"
echo "y=3    # 0011 binary"
echo ""
echo "echo \"x = \$x (binary: \$(printf '%04d' \$(echo \"obase=2;\$x\" | bc)))\""
echo "echo \"y = \$y (binary: \$(printf '%04d' \$(echo \"obase=2;\$y\" | bc)))\""
echo "echo \"\""
echo "echo \"Bitwise AND (\$x & \$y): \$((x & y))\"   # 0101 & 0011 = 0001 (1)"
echo "echo \"Bitwise OR  (\$x | \$y): \$((x | y))\"   # 0101 | 0011 = 0111 (7)"
echo "echo \"Bitwise XOR (\$x ^ \$y): \$((x ^ y))\"   # 0101 ^ 0011 = 0110 (6)"
echo "echo \"Bitwise NOT (~\$x): \$((~x))\"           # ~0101 = ...11111010 (-6 in 2's complement)"
echo "echo \"Left shift  (\$x << 1): \$((x << 1))\"   # 0101 << 1 = 1010 (10)"
echo "echo \"Right shift (\$x >> 1): \$((x >> 1))\"   # 0101 >> 1 = 0010 (2)\""
echo ""

x=5
y=3
echo "Output:"
echo "x = $x (binary: $(printf '%04d' $(echo "obase=2;$x" | bc)))"
echo "y = $y (binary: $(printf '%04d' $(echo "obase=2;$y" | bc)))"
echo ""
echo "Bitwise AND ($x & $y): $((x & y))"
echo "Bitwise OR  ($x | $y): $((x | y))"
echo "Bitwise XOR ($x ^ $y): $((x ^ y))"
echo "Bitwise NOT (~$x): $((~x))"
echo "Left shift  ($x << 1): $((x << 1))"
echo "Right shift ($x >> 1): $((x >> 1))"
echo ""

# -----------------------------------------------------------------------------
# SECTION 4: ASSIGNMENT OPERATORS
# -----------------------------------------------------------------------------
echo ""
echo "7. ASSIGNMENT OPERATORS"
echo "======================="
echo ""

echo "EXAMPLE: COMPOUND ASSIGNMENT OPERATORS"
echo "--------------------------------------"
echo "Code:"
echo "value=10"
echo "echo \"Initial value: \$value\""
echo ""
echo "(( value += 5 ))"
echo "echo \"After += 5: \$value\""
echo ""
echo "(( value -= 3 ))"
echo "echo \"After -= 3: \$value\""
echo ""
echo "(( value *= 2 ))"
echo "echo \"After *= 2: \$value\""
echo ""
echo "(( value /= 4 ))"
echo "echo \"After /= 4: \$value\""
echo ""
echo "(( value %= 3 ))"
echo "echo \"After %= 3: \$value\""
echo ""
echo "(( value **= 2 ))"
echo "echo \"After **= 2: \$value\""
echo ""
echo "(( value <<= 1 ))"
echo "echo \"After <<= 1: \$value\""
echo ""
echo "(( value >>= 2 ))"
echo "echo \"After >>= 2: \$value\""
echo ""

value=10
echo "Output:"
echo "Initial value: $value"
(( value += 5 ))
echo "After += 5: $value"
(( value -= 3 ))
echo "After -= 3: $value"
(( value *= 2 ))
echo "After *= 2: $value"
(( value /= 4 ))
echo "After /= 4: $value"
(( value %= 3 ))
echo "After %= 3: $value"
(( value **= 2 ))
echo "After **= 2: $value"
(( value <<= 1 ))
echo "After <<= 1: $value"
(( value >>= 2 ))
echo "After >>= 2: $value"
echo ""

# -----------------------------------------------------------------------------
# SECTION 5: INTEGER BASE CONVERSIONS
# -----------------------------------------------------------------------------
echo ""
echo "8. INTEGER BASE CONVERSIONS"
echo "==========================="
echo "Bash supports different number bases"
echo ""

echo "EXAMPLE: DIFFERENT NUMBER BASES"
echo "-------------------------------"
echo "Code:"
echo "# Decimal (default)"
echo "dec=255"
echo "echo \"Decimal: \$dec\""
echo ""
echo "# Octal (prefix 0)"
echo "oct=0377"
echo "echo \"Octal 0377: \$((oct)) decimal\""
echo ""
echo "# Hexadecimal (prefix 0x or 0X)"
echo "hex=0xFF"
echo "echo \"Hexadecimal 0xFF: \$((hex)) decimal\""
echo ""
echo "# Binary (prefix 0b or 0B, Bash 4.0+)"
echo "bin=0b11111111"
echo "echo \"Binary 0b11111111: \$((bin)) decimal\""
echo ""
echo "# Base conversion using #"
echo "echo \"Decimal 255 in different bases:\""
echo "echo \"  Octal: \$((10#255))? No, use printf: \$(printf '%o' 255)\""
echo "echo \"  Hex:   \$(printf '%X' 255)\""
echo "echo \"  Binary: \$(echo \"obase=2;255\" | bc)\""
echo ""

dec=255
echo "Output:"
echo "Decimal: $dec"
oct=0377
echo "Octal 0377: $((oct)) decimal"
hex=0xFF
echo "Hexadecimal 0xFF: $((hex)) decimal"
bin=0b11111111
echo "Binary 0b11111111: $((bin)) decimal"
echo ""
echo "Decimal 255 in different bases:"
echo "  Octal: $(printf '%o' 255)"
echo "  Hex:   $(printf '%X' 255)"
echo "  Binary: $(echo "obase=2;255" | bc)"
echo ""

# -----------------------------------------------------------------------------
# SECTION 6: FLOATING POINT ARITHMETIC (USING EXTERNAL TOOLS)
# -----------------------------------------------------------------------------
echo ""
echo "9. FLOATING POINT ARITHMETIC (EXTERNAL TOOLS)"
echo "============================================="
echo "Bash only does integer math. Use these for floating point:"
echo ""

echo "EXAMPLE 1: USING bc (BASIC CALCULATOR)"
echo "--------------------------------------"
echo "Code:"
echo "echo \"10 / 3 = \$(echo 'scale=2; 10/3' | bc)\""
echo "echo \"sqrt(100) = \$(echo 'scale=2; sqrt(100)' | bc -l)\""
echo "echo \"2.5 * 3.7 = \$(echo '2.5 * 3.7' | bc)\""
echo "echo \"e(1) = \$(echo 'scale=10; e(1)' | bc -l)\""
echo ""

echo "Output:"
echo "10 / 3 = $(echo 'scale=2; 10/3' | bc)"
echo "sqrt(100) = $(echo 'scale=2; sqrt(100)' | bc -l)"
echo "2.5 * 3.7 = $(echo '2.5 * 3.7' | bc)"
echo "e(1) = $(echo 'scale=10; e(1)' | bc -l)"
echo ""

echo "EXAMPLE 2: USING awk"
echo "--------------------"
echo "Code:"
echo "echo \"Using awk for floating point:\""
echo "result=\$(awk 'BEGIN {printf \"%.2f\", 10/3}')"
echo "echo \"10 / 3 = \$result\""
echo ""
echo "circle_area=\$(awk -v r=5 'BEGIN {printf \"%.2f\", 3.14159 * r * r}')"
echo "echo \"Area of circle (r=5) = \$circle_area\""
echo ""

echo "Output:"
result=$(awk 'BEGIN {printf "%.2f", 10/3}')
echo "10 / 3 = $result"
circle_area=$(awk -v r=5 'BEGIN {printf "%.2f", 3.14159 * r * r}')
echo "Area of circle (r=5) = $circle_area"
echo ""

echo "EXAMPLE 3: USING printf"
echo "-----------------------"
echo "Code:"
echo "printf \"Floating division: %.2f\\n\" \"\$((10/3))e-0\"  # Won't work"
echo "printf \"Better: %.2f\\n\" \"\$(echo '10/3' | bc -l)\""
echo ""

echo "Output:"
printf "Floating division: %.2f\n" "$(echo '10/3' | bc -l)"
echo ""

# -----------------------------------------------------------------------------
# SECTION 7: REAL-WORLD EXAMPLES
# -----------------------------------------------------------------------------
echo ""
echo "10. REAL-WORLD EXAMPLES"
echo "======================="
echo ""

echo "EXAMPLE 1: CALCULATE DISK USAGE PERCENTAGE"
echo "------------------------------------------"
echo "Code:"
echo "total_space=1000000  # 1GB in MB"
echo "used_space=650000    # 650MB used"
echo "usage_percent=\$(( (used_space * 100) / total_space ))"
echo "echo \"Disk usage: \$usage_percent%\""
echo "if (( usage_percent > 90 )); then"
echo "    echo \"WARNING: Disk almost full!\""
echo "fi"
echo ""

total_space=1000000
used_space=650000
usage_percent=$(( (used_space * 100) / total_space ))
echo "Output:"
echo "Disk usage: $usage_percent%"
if (( usage_percent > 90 )); then
    echo "WARNING: Disk almost full!"
else
    echo "Disk space is OK"
fi
echo ""

echo "EXAMPLE 2: FIBONACCI SEQUENCE"
echo "------------------------------"
echo "Code:"
echo "a=0"
echo "b=1"
echo "echo \"Fibonacci sequence (first 10):\""
echo "for ((i=0; i<10; i++)); do"
echo "    echo -n \"\$a \""
echo "    temp=\$((a + b))"
echo "    a=\$b"
echo "    b=\$temp"
echo "done"
echo "echo"
echo ""

a=0
b=1
echo "Output:"
echo "Fibonacci sequence (first 10):"
for ((i=0; i<10; i++)); do
    echo -n "$a "
    temp=$((a + b))
    a=$b
    b=$temp
done
echo ""
echo ""

echo "EXAMPLE 3: RANDOM NUMBER GENERATION"
echo "-----------------------------------"
echo "Code:"
echo "echo \"Random numbers between 1 and 100:\""
echo "for i in {1..5}; do"
echo "    echo \"  \$((RANDOM % 100 + 1))\""
echo "done"
echo ""
echo "# Generate random in range [min, max]"
echo "min=50"
echo "max=100"
echo "range=\$((max - min + 1))"
echo "random_in_range=\$((RANDOM % range + min))"
echo "echo \"Random between \$min and \$max: \$random_in_range\""
echo ""

echo "Output:"
echo "Random numbers between 1 and 100:"
for i in {1..5}; do
    echo "  $((RANDOM % 100 + 1))"
done
echo ""
min=50
max=100
range=$((max - min + 1))
random_in_range=$((RANDOM % range + min))
echo "Random between $min and $max: $random_in_range"
echo ""

echo "EXAMPLE 4: ARRAY INDEX CALCULATIONS"
echo "-----------------------------------"
echo "Code:"
echo "files=(*.sh)"
echo "file_count=\${#files[@]}"
echo "echo \"Found \$file_count shell scripts\""
echo ""
echo "# Calculate middle index"
echo "middle_index=\$((file_count / 2))"
echo "echo \"Middle file: \${files[middle_index]}\""
echo ""
echo "# Loop with arithmetic in condition"
echo "for ((i=0; i<file_count; i+=2)); do"
echo "    echo \"Even index \$i: \${files[i]}\""
echo "done"
echo ""

files=(*.sh)
file_count=${#files[@]}
echo "Output:"
echo "Found $file_count shell scripts"
middle_index=$((file_count / 2))
if [ $file_count -gt 0 ]; then
    echo "Middle file: ${files[middle_index]:-(none)}"
else
    echo "Middle file: (no files)"
fi
echo ""
echo "Even indexed files:"
for ((i=0; i<file_count; i+=2)); do
    echo "  Index $i: ${files[i]}"
done
echo ""

# -----------------------------------------------------------------------------
# SECTION 8: BEST PRACTICES & PITFALLS
# -----------------------------------------------------------------------------
echo ""
echo "11. BEST PRACTICES & PITFALLS"
echo "============================="
echo ""
echo "BEST PRACTICES:"
echo "---------------"
echo "1. Use \$(( )) for arithmetic expansion (modern, preferred)"
echo "2. Use (( )) for arithmetic evaluation in conditionals"
echo "3. Always check for division by zero"
echo "4. Use bc or awk for floating point calculations"
echo "5. Quote arithmetic expressions in complex strings"
echo ""
echo "COMMON PITFALLS:"
echo "----------------"
echo "1. FLOATING POINT WITH INTEGER ARITHMETIC:"
echo "   BAD:  result=\$((10/3))          # Gives 3"
echo "   GOOD: result=\$(echo 'scale=2;10/3' | bc)  # Gives 3.33"
echo ""
echo "2. DIVISION BY ZERO:"
echo "   BAD:  result=\$((10/0))          # Error"
echo "   GOOD: if (( divisor != 0 )); then result=\$((dividend/divisor)); fi"
echo ""
echo "3. MISSING \$ FOR OUTPUT:"
echo "   BAD:  echo ((5+3))              # Syntax error"
echo "   GOOD: echo \$((5+3))            # Correct"
echo ""
echo "4. SPACES IN \$(( )):"
echo "   BAD:  \$(( 5 + 3 ))              # Works but inconsistent"
echo "   GOOD: \$((5+3))                  # Preferred"
echo ""
echo "5. VARIABLE PREFIX INSIDE \$(( )):"
echo "   BAD:  \$((\$a + \$b))            # Works but redundant"
echo "   GOOD: \$((a + b))                # Cleaner"
echo ""

# -----------------------------------------------------------------------------
# SECTION 9: PERFORMANCE TIPS
# -----------------------------------------------------------------------------
echo ""
echo "12. PERFORMANCE TIPS"
echo "===================="
echo ""
echo "1. \$(( )) vs expr:"
echo "   • \$(( )) is built-in, faster"
echo "   • expr is external command, slower"
echo ""
echo "2. Avoid subshells for simple math:"
echo "   SLOW:  result=\$(expr 5 + 3)"
echo "   FAST:  result=\$((5+3))"
echo ""
echo "3. Use integer variables:"
echo "   declare -i var=10   # Integer variable"
echo "   var+=5              # No arithmetic expansion needed"
echo ""
echo "4. Batch calculations:"
echo "   # Multiple calculations in one expansion"
echo "   read a b c <<< \$((x+1, y*2, z/3))"
echo ""

# -----------------------------------------------------------------------------
# SECTION 10: QUICK REFERENCE CHEAT SHEET
# -----------------------------------------------------------------------------
echo ""
echo "13. QUICK REFERENCE CHEAT SHEET"
echo "================================"
echo ""
echo "ARITHMETIC OPERATORS:"
echo "-------------------"
echo "+   Addition           \$((5+3))   → 8"
echo "-   Subtraction        \$((5-3))   → 2"
echo "*   Multiplication     \$((5*3))   → 15"
echo "/   Division           \$((5/3))   → 1"
echo "%   Modulus            \$((5%3))   → 2"
echo "**  Exponentiation     \$((5**3))  → 125"
echo ""
echo "BITWISE OPERATORS:"
echo "----------------"
echo "&   AND                \$((5&3))   → 1"
echo "|   OR                 \$((5|3))   → 7"
echo "^   XOR                \$((5^3))   → 6"
echo "~   NOT                \$((~5))    → -6"
echo "<<  Left shift         \$((5<<1))  → 10"
echo ">>  Right shift        \$((5>>1))  → 2"
echo ""
echo "ASSIGNMENT OPERATORS:"
echo "-------------------"
echo "=   Assignment         ((x=5))"
echo "+=  Add and assign     ((x+=3))"
echo "-=  Subtract and assign ((x-=2))"
echo "*=  Multiply and assign ((x*=4))"
echo "/=  Divide and assign  ((x/=2))"
echo "%=  Modulus and assign ((x%=3))"
echo ""
echo "COMPARISON OPERATORS (in (( ))):"
echo "------------------------------"
echo "==  Equal              ((x == y))"
echo "!=  Not equal          ((x != y))"
echo "<   Less than          ((x < y))"
echo "<=  Less or equal      ((x <= y))"
echo ">   Greater than       ((x > y))"
echo ">=  Greater or equal   ((x >= y))"
echo ""
echo "INCREMENT/DECREMENT:"
echo "------------------"
echo "++var  Pre-increment   \$((++x))"
echo "var++  Post-increment  \$((x++))"
echo "--var  Pre-decrement   \$((--x))"
echo "var--  Post-decrement  \$((x--))"
echo ""
echo "NUMBER BASES:"
echo "-----------"
echo "10   Decimal           123"
echo "8    Octal (prefix 0)  0173"
echo "16   Hex (prefix 0x)   0x7B"
echo "2    Binary (prefix 0b) 0b1111011"
echo ""
echo "FLOATING POINT TOOLS:"
echo "-------------------"
echo "bc     echo 'scale=2;10/3' | bc"
echo "awk    awk 'BEGIN {printf \"%.2f\", 10/3}'"
echo "printf printf \"%.2f\" \"value\""
echo ""
echo "RANDOM NUMBERS:"
echo "-------------"
echo "RANDOM % 100        # 0-99"
echo "RANDOM % 100 + 1    # 1-100"
echo "\$((RANDOM % (max-min+1) + min))  # Range"
echo ""
echo "========================================================================"
echo "                     END OF ARITHMETIC EXPRESSIONS GUIDE"
echo "========================================================================"