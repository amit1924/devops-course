#!/bin/bash

# ================= CONFIG =================
SEARCH_PATHS=(
  "$HOME"
  "/media/amit"
  "/opt"                   # Optional/third-party software
  "/usr/local"             # Locally installed software
  "/usr/share"             # Shared data
  "/usr/bin"               # User commands
  "/usr/sbin"              # System admin commands
  "/usr/lib"               # Libraries
  "/usr/include"           # Header files
                
        
  "/home/*/.local"         # User local data
  "/home/*/.cache"         # User cache
  "/home/*/Downloads"      # User downloads
  "/home/*/Documents"      # User documents
  "/home/*/Desktop"        # User desktop
  "/home/*/Pictures"       # User pictures
  "/home/*/Music"          # User music
  "/home/*/Videos"         # User videos
   
)

IGNORE_DIRS=(
  "node_modules"
  ".git"
  "__pycache__"
  ".cache"
  ".npm"
  "Trash"
  ".thumbnails"
  ".mozilla"              # Firefox cache
  ".chrome"               # Chrome cache
  ".chromium"             # Chromium cache
  ".opera"                # Opera cache
  ".local/share/Trash"    # Trash
  ".steam"                # Steam cache
  "Cache"                 # Various caches
  "cache"                 # Lowercase cache
  ".config/Code/Cache"    # VSCode cache
  ".config/chromium"      # Chromium config cache
  ".config/google-chrome" # Chrome config cache
  ".gradle"               # Gradle cache
  ".m2"                   # Maven cache
  ".npm"                  # NPM cache
  ".pip"                  # PIP cache
  ".pyenv"                # Pyenv
  ".rbenv"                # Rbenv
  "go/pkg"                # Go cache
  ".rustup"               # Rustup cache
  ".cargo/registry"       # Cargo registry
)

# ================= FUNCTIONS =================
show_progress() {
    local current=$1
    local total=$2
    local phase=$3
    local width=50
    
    # Calculate percentage
    local percent=$((current * 100 / total))
    
    # Calculate progress bar length
    local progress=$((current * width / total))
    
    # Create progress bar string
    local bar=""
    for ((i=0; i<width; i++)); do
        if [ $i -lt $progress ]; then
            bar+="█"
        else
            bar+="░"
        fi
    done
    
    # ANSI color codes
    local RED='\033[0;31m'
    local GREEN='\033[0;32m'
    local YELLOW='\033[1;33m'
    local BLUE='\033[0;34m'
    local MAGENTA='\033[0;35m'
    local CYAN='\033[0;36m'
    local RESET='\033[0m'
    
    # Phase-specific colors and icons
    local color=$BLUE
    local icon="🔄"
    
    case $phase in
        "validate") color=$CYAN; icon="🔍" ;;
        "content") color=$GREEN; icon="📄" ;;
        "filename") color=$YELLOW; icon="📁" ;;
        "generate") color=$MAGENTA; icon="🎨" ;;
        "complete") color=$GREEN; icon="✅" ;;
    esac
    
    # Clear line and show progress
    printf "\r${color}${icon} [%s] %3d%% %s${RESET}" "$bar" "$percent" "$phase"
    
    # If complete, add newline
    if [ $current -eq $total ]; then
        echo ""
    fi
}

estimate_search_time() {
    local total_paths=$1
    # Rough estimation: 0.5 seconds per path (adjust based on your system)
    echo $((total_paths * 3))
}

# ================= INPUT =================
if [ -z "$1" ]; then
  echo "❌ Usage: search <keyword>"
  exit 1
fi

KEYWORD="$1"

# Start timing
SECONDS=0

echo ""
echo "⚡ POWER SEARCH for: \"$KEYWORD\""
echo "======================================"

# ================= PATH VALIDATION =================
echo "🔍 Validating search paths..."
VALID_PATHS=()
total_paths=${#SEARCH_PATHS[@]}
current_path=0

for path in "${SEARCH_PATHS[@]}"; do
  # Expand wildcards and home directory
  expanded_paths=()
  
  if [[ "$path" == *"*"* ]]; then
    # Handle wildcards
    for expanded in $path; do
      expanded_paths+=("$expanded")
    done
  else
    expanded_paths+=("$path")
  fi
  
  for expanded_path in "${expanded_paths[@]}"; do
    current_path=$((current_path + 1))
    show_progress $current_path $total_paths "validate"
    
    if [ -e "$expanded_path" ] || [ -d "$expanded_path" ] 2>/dev/null; then
      VALID_PATHS+=("$expanded_path")
    fi
  done
done

echo ""
if [ ${#VALID_PATHS[@]} -eq 0 ]; then
  echo "❌ No valid search paths found!"
  exit 1
fi

echo "✅ Validated ${#VALID_PATHS[@]} search paths"

# ================= BUILD IGNORE GLOBS =================
IGNORE_ARGS=()
for dir in "${IGNORE_DIRS[@]}"; do
  IGNORE_ARGS+=(--glob "!**/$dir/**")
done

# Create temporary files for HTML output
CONTENT_FILE=$(mktemp)
FILENAME_FILE=$(mktemp)
HTML_FILE="/tmp/search_results_$(date +%Y%m%d_%H%M%S).html"

# ================= FILE CONTENT SEARCH =================
echo ""
echo "📄 Searching inside files..."

# Create a temporary file to capture output and count lines
TEMP_CONTENT_FILE=$(mktemp)

# Run ripgrep in background and capture output
(
  rg "$KEYWORD" "${VALID_PATHS[@]}" \
    --smart-case \
    --hidden \
    "${IGNORE_ARGS[@]}" \
    --max-columns 200 \
    --line-number \
    --no-heading \
    --color never \
    --max-depth 10 \
    --follow 2>/dev/null | tee "$TEMP_CONTENT_FILE"
) &

RG_PID=$!

# Show progress while ripgrep is running
echo "⏳ Content search in progress..."
while kill -0 $RG_PID 2>/dev/null; do
    # Count lines found so far
    current_lines=$(wc -l < "$TEMP_CONTENT_FILE" 2>/dev/null || echo "0")
    
    # Animated spinner
    for spin in '⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏'; do
        if ! kill -0 $RG_PID 2>/dev/null; then
            break 2
        fi
        printf "\r📄 %s Searching... Found: %d matches" "$spin" "$current_lines"
        sleep 0.1
    done
done

wait $RG_PID

# Move temp file to final location
mv "$TEMP_CONTENT_FILE" "$CONTENT_FILE"

CONTENT_COUNT=$(wc -l < "$CONTENT_FILE" 2>/dev/null || echo "0")
echo ""
echo "✅ Found $CONTENT_COUNT content matches"

# ================= FILE & FOLDER NAME SEARCH =================
echo ""
echo "📁 Searching file/folder names..."

# Create a temporary file for fd output
TEMP_FILENAME_FILE=$(mktemp)

# Run fd in background
(
  fd "$KEYWORD" "${VALID_PATHS[@]}" \
    --hidden \
    --max-depth 10 \
    --follow \
    --type f \
    --type d \
    2>/dev/null | head -1000 > "$TEMP_FILENAME_FILE"
) &

FD_PID=$!

# Show progress while fd is running
echo "⏳ Filename search in progress..."
while kill -0 $FD_PID 2>/dev/null; do
    # Count lines found so far
    current_lines=$(wc -l < "$TEMP_FILENAME_FILE" 2>/dev/null || echo "0")
    
    # Animated spinner
    for spin in '⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏'; do
        if ! kill -0 $FD_PID 2>/dev/null; then
            break 2
        fi
        printf "\r📁 %s Searching... Found: %d matches" "$spin" "$current_lines"
        sleep 0.1
    done
done

wait $FD_PID

# Move temp file to final location
mv "$TEMP_FILENAME_FILE" "$FILENAME_FILE"

FILENAME_COUNT=$(wc -l < "$FILENAME_FILE" 2>/dev/null || echo "0")
echo ""
echo "✅ Found $FILENAME_COUNT filename matches"

# ================= GENERATE HTML REPORT =================
echo ""
echo "🎨 Generating beautiful HTML report..."

# Show progress for HTML generation
TOTAL_LINES=$((CONTENT_COUNT + FILENAME_COUNT))
if [ $TOTAL_LINES -gt 1000 ]; then
    TOTAL_LINES=1000  # Cap for progress display
fi

# Count lines as we generate HTML
HTML_PROGRESS_FILE=$(mktemp)
echo "0" > "$HTML_PROGRESS_FILE"

# Generate HTML in background
(
  generate_html() {
    cat << EOF > "$HTML_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🔍 Linux Search: "$KEYWORD"</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { 
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
        }
        .search-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
        }
        .result-item:hover { 
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .highlight { 
            background: linear-gradient(120deg, #4f46e5 0%, #7c3aed 100%);
            color: white;
        }
        .path-breadcrumb { 
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 600;
        }
        .linux-badge {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            color: white;
        }
        .glass-effect {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        }
        .search-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
        }
        .line-number {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: bold;
        }
        .copy-btn {
            transition: all 0.3s ease;
        }
        .copy-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .file-icon {
            transition: transform 0.3s ease;
        }
        .result-item:hover .file-icon {
            transform: scale(1.2);
        }
        .keyword-highlight {
            background-color: #e0f2fe;
            border-radius: 3px;
            padding: 0 2px;
            font-weight: 600;
            color: #0369a1;
        }
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            border-radius: 10px;
        }
        .stats-card {
            background: linear-gradient(135deg, #1e3c7220 0%, #2a529820 100%);
            border-left: 4px solid #1e3c72;
        }
        .path-category {
            background: linear-gradient(135deg, #dbeafe 0%, #eff6ff 100%);
            border-left: 4px solid #3b82f6;
        }
        .config-file {
            background: linear-gradient(135deg, #fef3c7 0%, #fef9c3 100%);
            border-left: 4px solid #f59e0b;
        }
        .system-file {
            background: linear-gradient(135deg, #fce7f3 0%, #fbcfe8 100%);
            border-left: 4px solid #db2777;
        }
        .user-file {
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
            border-left: 4px solid #10b981;
        }
        .pulse-animation {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }
        .tux-icon {
            color: #1e3c72;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        .progress-bar {
            background: linear-gradient(90deg, #4f46e5 0%, #7c3aed 100%);
            height: 6px;
            border-radius: 3px;
            transition: width 0.3s ease;
        }
    </style>
</head>
<body class="p-4">
    <div class="max-w-7xl mx-auto">
        <!-- Header -->
        <div class="search-header rounded-2xl p-8 mb-8 shadow-2xl">
            <div class="flex items-center justify-between">
                <div>
                    <div class="flex items-center mb-2">
                        <i class="fab fa-linux text-3xl mr-3"></i>
                        <h1 class="text-4xl font-bold">Linux File Search</h1>
                    </div>
                    <p class="text-xl opacity-90">Keyword: <span class="highlight px-4 py-2 rounded-full font-bold">"$KEYWORD"</span></p>
                    <div class="flex items-center mt-6 space-x-4">
                        <span class="px-4 py-2 bg-white/20 rounded-lg backdrop-blur-sm">
                            <i class="far fa-calendar mr-2"></i>$(date "+%Y-%m-%d %H:%M:%S")
                        </span>
                        <span class="px-4 py-2 bg-white/20 rounded-lg backdrop-blur-sm">
                            <i class="fas fa-microchip mr-2"></i>$(hostname)
                        </span>
                        <span class="px-4 py-2 bg-white/20 rounded-lg backdrop-blur-sm">
                            <i class="fas fa-folder mr-2"></i>${#VALID_PATHS[@]} Search Paths
                        </span>
                    </div>
                </div>
                <div class="text-6xl opacity-20">
                    <i class="fas fa-search tux-icon"></i>
                </div>
            </div>
        </div>

        <!-- Search Progress Summary -->
        <div class="glass-effect rounded-2xl p-6 mb-8">
            <h2 class="text-2xl font-bold mb-4 flex items-center text-gray-800">
                <i class="fas fa-chart-line mr-3 text-purple-600"></i>Search Performance
            </h2>
            <div class="space-y-4">
                <div>
                    <div class="flex justify-between text-sm text-gray-600 mb-1">
                        <span>Content Search</span>
                        <span>$CONTENT_COUNT matches</span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2.5">
                        <div class="progress-bar h-2.5 rounded-full" style="width: $((CONTENT_COUNT > 0 ? 100 : 0))%"></div>
                    </div>
                </div>
                <div>
                    <div class="flex justify-between text-sm text-gray-600 mb-1">
                        <span>Filename Search</span>
                        <span>$FILENAME_COUNT matches</span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2.5">
                        <div class="progress-bar h-2.5 rounded-full" style="width: $((FILENAME_COUNT > 0 ? 100 : 0))%"></div>
                    </div>
                </div>
                <div>
                    <div class="flex justify-between text-sm text-gray-600 mb-1">
                        <span>Search Time</span>
                        <span>${SECONDS} seconds</span>
                    </div>
                    <div class="w-full bg-gray-200 rounded-full h-2.5">
                        <div class="progress-bar h-2.5 rounded-full" style="width: $((SECONDS > 0 ? 100 : 0))%"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="stats-card rounded-xl p-6">
                <div class="flex items-center">
                    <div class="mr-4 text-3xl text-blue-600">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold text-gray-800">Content Matches</h3>
                        <p class="text-3xl font-bold text-gray-900">$CONTENT_COUNT</p>
                        <p class="text-sm text-gray-600">Lines containing keyword</p>
                    </div>
                </div>
            </div>
            <div class="stats-card rounded-xl p-6">
                <div class="flex items-center">
                    <div class="mr-4 text-3xl text-green-600">
                        <i class="fas fa-folder"></i>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold text-gray-800">Filename Matches</h3>
                        <p class="text-3xl font-bold text-gray-900">$FILENAME_COUNT</p>
                        <p class="text-sm text-gray-600">Files/folders found</p>
                    </div>
                </div>
            </div>
            <div class="stats-card rounded-xl p-6">
                <div class="flex items-center">
                    <div class="mr-4 text-3xl text-purple-600">
                        <i class="fas fa-tachometer-alt"></i>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold text-gray-800">Performance</h3>
                        <p class="text-3xl font-bold text-gray-900">${SECONDS}s</p>
                        <p class="text-sm text-gray-600">Search completed in</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search Paths by Category -->
        <div class="glass-effect rounded-2xl p-6 mb-8">
            <h2 class="text-2xl font-bold mb-4 flex items-center text-gray-800">
                <i class="fas fa-sitemap mr-3 text-blue-600"></i>Search Paths by Category
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                <!-- System Paths -->
                <div class="path-category rounded-xl p-4">
                    <h3 class="font-bold text-lg text-gray-800 mb-2 flex items-center">
                        <i class="fas fa-server mr-2 text-blue-500"></i>System
                    </h3>
                    <div class="space-y-2">
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-cog text-gray-400 mr-2 text-xs"></i>/etc
                        </div>
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-file-alt text-gray-400 mr-2 text-xs"></i>/var/log
                        </div>
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-microchip text-gray-400 mr-2 text-xs"></i>/boot
                        </div>
                    </div>
                </div>
                
                <!-- User Paths -->
                <div class="path-category rounded-xl p-4">
                    <h3 class="font-bold text-lg text-gray-800 mb-2 flex items-center">
                        <i class="fas fa-user mr-2 text-green-500"></i>User
                    </h3>
                    <div class="space-y-2">
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-home text-gray-400 mr-2 text-xs"></i>$HOME
                        </div>
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-download text-gray-400 mr-2 text-xs"></i>~/Downloads
                        </div>
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-cog text-gray-400 mr-2 text-xs"></i>~/.config
                        </div>
                    </div>
                </div>
                
                <!-- Application Paths -->
                <div class="path-category rounded-xl p-4">
                    <h3 class="font-bold text-lg text-gray-800 mb-2 flex items-center">
                        <i class="fas fa-box mr-2 text-purple-500"></i>Applications
                    </h3>
                    <div class="space-y-2">
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-folder-open text-gray-400 mr-2 text-xs"></i>/opt
                        </div>
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-code text-gray-400 mr-2 text-xs"></i>/usr/local
                        </div>
                        <div class="text-sm text-gray-700 flex items-center">
                            <i class="fas fa-share-alt text-gray-400 mr-2 text-xs"></i>/usr/share
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <!-- File Content Results -->
            <div class="glass-effect rounded-2xl p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-2xl font-bold flex items-center text-gray-800">
                        <i class="fas fa-file-code mr-3 text-blue-600"></i>Content Matches
                        <span class="ml-3 px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm font-bold">
                            $CONTENT_COUNT results
                        </span>
                    </h2>
                    <button onclick="copyContentResults()" class="copy-btn px-4 py-2 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-lg hover:opacity-90 font-medium">
                        <i class="far fa-copy mr-2"></i>Copy All
                    </button>
                </div>
                
                <div id="contentResults" class="space-y-4 max-h-[500px] overflow-y-auto pr-2">
EOF

  # Update progress
  echo "25" > "$HTML_PROGRESS_FILE"

  # Add content search results with categorization
  if [ -s "$CONTENT_FILE" ]; then
    line_count=0
    total_lines=$(wc -l < "$CONTENT_FILE")
    while IFS= read -r line; do
      line_count=$((line_count + 1))
      
      # Update progress every 10 lines
      if [ $((line_count % 10)) -eq 0 ]; then
        progress=$((25 + (line_count * 25 / total_lines)))
        echo "$progress" > "$HTML_PROGRESS_FILE"
      fi
      
      file=$(echo "$line" | cut -d: -f1)
      line_num=$(echo "$line" | cut -d: -f2)
      content=$(echo "$line" | cut -d: -f3-)
      
      # Determine file category for styling
      file_class=""
      category=""
      icon="fa-file"
      
      if [[ "$file" == /etc/* ]]; then
        file_class="config-file"
        category="System Config"
        icon="fa-cog"
      elif [[ "$file" == /var/log/* ]]; then
        file_class="system-file"
        category="System Log"
        icon="fa-clipboard-list"
      elif [[ "$file" == $HOME/* ]]; then
        file_class="user-file"
        category="User File"
        icon="fa-user"
      elif [[ "$file" == /usr/* ]]; then
        file_class="system-file"
        category="System File"
        icon="fa-server"
      else
        file_class=""
        category="File"
      fi
      
      # Highlight the keyword in content
      highlighted_content=$(echo "$content" | sed "s/$KEYWORD/<span class='keyword-highlight'>$KEYWORD<\/span>/g")
      
      echo "                    <div class='result-item $file_class p-4 bg-white rounded-xl border border-gray-200 transition-all duration-300 cursor-pointer'>" >> "$HTML_FILE"
      echo "                        <div class='flex justify-between items-start mb-2'>" >> "$HTML_FILE"
      echo "                            <div>" >> "$HTML_FILE"
      echo "                                <span class='line-number font-bold'><i class='fas fa-hashtag mr-1'></i>Line $line_num</span>" >> "$HTML_FILE"
      echo "                                <span class='ml-2 text-xs px-2 py-1 bg-gray-100 text-gray-700 rounded'>$category</span>" >> "$HTML_FILE"
      echo "                            </div>" >> "$HTML_FILE"
      echo "                            <span class='text-xs text-gray-500'>$(stat -c %y "$file" 2>/dev/null | cut -d' ' -f1 || echo 'Unknown date')</span>" >> "$HTML_FILE"
      echo "                        </div>" >> "$HTML_FILE"
      echo "                        <div class='font-mono text-sm mb-2 text-gray-700 flex items-center'>" >> "$HTML_FILE"
      echo "                            <i class='fas $icon text-blue-500 mr-2 file-icon'></i>" >> "$HTML_FILE"
      echo "                            <span class='truncate' title='$file'><span class='font-semibold'>$(basename "$file"):</span> $(dirname "$file")</span>" >> "$HTML_FILE"
      echo "                        </div>" >> "$HTML_FILE"
      echo "                        <div class='p-3 bg-gray-50 rounded-lg border border-gray-100'>" >> "$HTML_FILE"
      echo "                            <pre class='text-sm whitespace-pre-wrap text-gray-800'>$highlighted_content</pre>" >> "$HTML_FILE"
      echo "                        </div>" >> "$HTML_FILE"
      echo "                        <div class='mt-2 flex space-x-2'>" >> "$HTML_FILE"
      echo "                            <button onclick=\"openInTerminal('$file', $line_num)\" class='text-xs px-3 py-1 bg-blue-100 text-blue-700 rounded hover:bg-blue-200'>" >> "$HTML_FILE"
      echo "                                <i class='fas fa-terminal mr-1'></i>Open" >> "$HTML_FILE"
      echo "                            </button>" >> "$HTML_FILE"
      echo "                            <button onclick=\"copyPath('$file')\" class='text-xs px-3 py-1 bg-gray-100 text-gray-700 rounded hover:bg-gray-200'>" >> "$HTML_FILE"
      echo "                                <i class='far fa-copy mr-1'></i>Copy Path" >> "$HTML_FILE"
      echo "                            </button>" >> "$HTML_FILE"
      echo "                        </div>" >> "$HTML_FILE"
      echo "                    </div>" >> "$HTML_FILE"
    done < "$CONTENT_FILE"
  else
    echo "                    <div class='text-center py-12 text-gray-500'>" >> "$HTML_FILE"
    echo "                        <i class='fas fa-search fa-4x mb-4 text-gray-300'></i>" >> "$HTML_FILE"
    echo "                        <p class='text-xl font-medium'>No content matches found</p>" >> "$HTML_FILE"
    echo "                        <p class='text-sm mt-2'>Try a different keyword or check your search paths</p>" >> "$HTML_FILE"
    echo "                    </div>" >> "$HTML_FILE"
  fi

  # Update progress
  echo "50" > "$HTML_PROGRESS_FILE"

  cat << EOF >> "$HTML_FILE"
                </div>
            </div>

            <!-- Filename Results -->
            <div class="glass-effect rounded-2xl p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-2xl font-bold flex items-center text-gray-800">
                        <i class="fas fa-folder mr-3 text-green-600"></i>Filename Matches
                        <span class="ml-3 px-3 py-1 bg-green-100 text-green-800 rounded-full text-sm font-bold">
                            $FILENAME_COUNT results
                        </span>
                    </h2>
                    <button onclick="copyFilenameResults()" class="copy-btn px-4 py-2 bg-gradient-to-r from-green-600 to-teal-600 text-white rounded-lg hover:opacity-90 font-medium">
                        <i class="far fa-copy mr-2"></i>Copy All
                    </button>
                </div>
                
                <div id="filenameResults" class="space-y-3 max-h-[500px] overflow-y-auto pr-2">
EOF

  # Add filename search results
  if [ -s "$FILENAME_FILE" ]; then
    line_count=0
    total_lines=$(wc -l < "$FILENAME_FILE")
    while IFS= read -r file; do
      line_count=$((line_count + 1))
      
      # Update progress every 5 lines
      if [ $((line_count % 5)) -eq 0 ]; then
        progress=$((50 + (line_count * 25 / total_lines)))
        echo "$progress" > "$HTML_PROGRESS_FILE"
      fi
      
      file_type="file"
      icon="fa-file"
      color="text-blue-500"
      bg_color="bg-blue-100"
      text_color="text-blue-800"
      
      if [ -d "$file" ]; then
        file_type="folder"
        icon="fa-folder"
        color="text-yellow-500"
        bg_color="bg-yellow-100"
        text_color="text-yellow-800"
      elif [ -x "$file" ]; then
        file_type="executable"
        icon="fa-cog"
        color="text-green-500"
        bg_color="bg-green-100"
        text_color="text-green-800"
      elif [[ "$file" == *.conf ]] || [[ "$file" == *.config ]]; then
        file_type="config"
        icon="fa-cog"
        color="text-purple-500"
        bg_color="bg-purple-100"
        text_color="text-purple-800"
      elif [[ "$file" == *.log ]]; then
        file_type="log"
        icon="fa-clipboard-list"
        color="text-red-500"
        bg_color="bg-red-100"
        text_color="text-red-800"
      fi
      
      # Get file size
      file_size=$(ls -lh "$file" 2>/dev/null | awk '{print $5}' || echo "Unknown")
      
      echo "                    <div class='result-item p-4 bg-white rounded-xl border border-gray-200 transition-all duration-300 cursor-pointer'>" >> "$HTML_FILE"
      echo "                        <div class='flex items-center'>" >> "$HTML_FILE"
      echo "                            <i class='$icon $color mr-3 text-xl file-icon'></i>" >> "$HTML_FILE"
      echo "                            <div class='flex-1'>" >> "$HTML_FILE"
      echo "                                <div class='font-medium text-gray-900'>$(basename "$file")</div>" >> "$HTML_FILE"
      echo "                                <div class='text-sm text-gray-600 mt-1 truncate'>" >> "$HTML_FILE"
      echo "                                    <i class='fas fa-location-arrow mr-1 text-gray-400'></i>$(dirname "$file")</span>" >> "$HTML_FILE"
      echo "                                </div>" >> "$HTML_FILE"
      echo "                            </div>" >> "$HTML_FILE"
      echo "                            <div class='text-right'>" >> "$HTML_FILE"
      echo "                                <span class='px-2 py-1 $bg_color $text_color rounded text-xs font-bold block mb-1'>$file_type</span>" >> "$HTML_FILE"
      echo "                                <span class='text-xs text-gray-500'>$file_size</span>" >> "$HTML_FILE"
      echo "                            </div>" >> "$HTML_FILE"
      echo "                        </div>" >> "$HTML_FILE"
      echo "                        <div class='mt-3 flex space-x-2'>" >> "$HTML_FILE"
      echo "                            <button onclick=\"openInFileManager('$file')\" class='text-xs px-3 py-1 bg-blue-100 text-blue-700 rounded hover:bg-blue-200 flex-1'>" >> "$HTML_FILE"
      echo "                                <i class='fas fa-folder-open mr-1'></i>Open" >> "$HTML_FILE"
      echo "                            </button>" >> "$HTML_FILE"
      echo "                            <button onclick=\"copyPath('$file')\" class='text-xs px-3 py-1 bg-gray-100 text-gray-700 rounded hover:bg-gray-200'>" >> "$HTML_FILE"
      echo "                                <i class='far fa-copy'></i>" >> "$HTML_FILE"
      echo "                            </button>" >> "$HTML_FILE"
      echo "                        </div>" >> "$HTML_FILE"
      echo "                    </div>" >> "$HTML_FILE"
    done < "$FILENAME_FILE"
  else
    echo "                    <div class='text-center py-12 text-gray-500'>" >> "$HTML_FILE"
    echo "                        <i class='fas fa-folder fa-4x mb-4 text-gray-300'></i>" >> "$HTML_FILE"
    echo "                        <p class='text-xl font-medium'>No filename matches found</p>" >> "$HTML_FILE"
    echo "                        <p class='text-sm mt-2'>Try a different keyword or check your search paths</p>" >> "$HTML_FILE"
    echo "                    </div>" >> "$HTML_FILE"
  fi

  # Update progress
  echo "75" > "$HTML_PROGRESS_FILE"

  cat << EOF >> "$HTML_FILE"
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="mt-12 glass-effect rounded-2xl p-6 text-center">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="mb-4 md:mb-0 text-left">
                    <div class="flex items-center mb-2">
                        <i class="fab fa-linux text-2xl text-gray-700 mr-2"></i>
                        <p class="text-gray-700 font-bold">Linux Power Search v4.0</p>
                    </div>
                    <p class="text-sm text-gray-600">
                        <i class="fas fa-cogs mr-1"></i>$(uname -r) | 
                        <i class="fas fa-hdd mr-1 ml-2"></i>$(df -h / | awk 'NR==2 {print $4}') free
                    </p>
                </div>
                <div class="flex space-x-3">
                    <button onclick="showQuickCommands()" class="px-4 py-2 bg-gradient-to-r from-orange-500 to-red-500 text-white rounded-lg font-medium hover:opacity-90">
                        <i class="fas fa-terminal mr-2"></i>Quick Commands
                    </button>
                    <button onclick="exportToJSON()" class="px-4 py-2 bg-gradient-to-r from-purple-600 to-pink-600 text-white rounded-lg font-medium hover:opacity-90">
                        <i class="fas fa-download mr-2"></i>Export JSON
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Copy functions
        function copyContentResults() {
            const content = document.getElementById('contentResults').innerText;
            navigator.clipboard.writeText(content).then(() => {
                showNotification('Content results copied to clipboard!', 'success');
            });
        }
        
        function copyFilenameResults() {
            const content = document.getElementById('filenameResults').innerText;
            navigator.clipboard.writeText(content).then(() => {
                showNotification('Filename results copied to clipboard!', 'success');
            });
        }
        
        function copyPath(path) {
            navigator.clipboard.writeText(path).then(() => {
                showNotification('Path copied to clipboard!', 'success');
            });
        }
        
        // Open functions (Linux-specific)
        function openInTerminal(file, line) {
            showNotification(\`Opening \${file} in terminal...\`, 'info');
            // Example command to copy to clipboard for terminal use
            navigator.clipboard.writeText(\`vim "\${file}" +\${line}\`);
            showNotification('Vim command copied to clipboard!', 'success');
        }
        
        function openInFileManager(path) {
            showNotification(\`Opening \${path} in file manager...\`, 'info');
            // Could use: xdg-open "\${path}"
            navigator.clipboard.writeText(\`xdg-open "\${path}"\`);
            showNotification('File manager command copied!', 'success');
        }
        
        // Export function
        function exportToJSON() {
            const results = {
                keyword: "$KEYWORD",
                timestamp: "$(date)",
                system: {
                    hostname: "$(hostname)",
                    kernel: "$(uname -r)",
                    searchTime: "${SECONDS}s"
                },
                stats: {
                    contentMatches: $CONTENT_COUNT,
                    filenameMatches: $FILENAME_COUNT,
                    searchPaths: ${#VALID_PATHS[@]}
                },
                contentResults: [],
                filenameResults: []
            };
            
            // Collect content results
            document.querySelectorAll('#contentResults .result-item').forEach(item => {
                const line = item.querySelector('.line-number').textContent.replace('Line ', '');
                const file = item.querySelector('.font-mono span').textContent;
                const content = item.querySelector('pre').textContent;
                const category = item.querySelector('.bg-gray-100')?.textContent || 'File';
                results.contentResults.push({ file, line, content, category });
            });
            
            // Collect filename results
            document.querySelectorAll('#filenameResults .result-item').forEach(item => {
                const name = item.querySelector('.font-medium').textContent;
                const path = item.querySelector('.text-sm').textContent.replace('📌 ', '');
                const type = item.querySelector('.font-bold').textContent;
                const size = item.querySelector('.text-gray-500:last-child').textContent;
                results.filenameResults.push({ name, path, type, size });
            });
            
            const dataStr = JSON.stringify(results, null, 2);
            const dataUri = 'data:application/json;charset=utf-8,'+ encodeURIComponent(dataStr);
            const exportFileDefaultName = 'linux_search_$(date +%Y%m%d_%H%M%S).json';
            
            const linkElement = document.createElement('a');
            linkElement.setAttribute('href', dataUri);
            linkElement.setAttribute('download', exportFileDefaultName);
            linkElement.click();
            
            showNotification('JSON exported successfully!', 'success');
        }
        
        // Quick Linux Commands
        function showQuickCommands() {
            const commands = {
                "Find Files Modified Today": \`find $HOME -type f -mtime 0\`,
                "Search in Config Files": \`grep -r "$KEYWORD" /etc 2>/dev/null | head -20\`,
                "Check Disk Space": "df -h",
                "Show Running Processes": "ps aux | head -20",
                "System Information": "inxi -Fxxxz",
                "Update Package List": "sudo apt update",
                "Clean Package Cache": "sudo apt autoclean"
            };
            
            let message = "📟 Useful Linux Commands:\\n\\n";
            for (const [desc, cmd] of Object.entries(commands)) {
                message += \`🔹 \${desc}:\\n   \${cmd}\\n\\n\`;
            }
            
            navigator.clipboard.writeText(message).then(() => {
                showNotification('Linux commands copied to clipboard! Paste in terminal.', 'info');
            });
        }
        
        // Notification system
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = \`fixed top-4 right-4 px-6 py-3 rounded-lg shadow-lg text-white font-medium z-50 transition-transform transform translate-x-full \${type === 'success' ? 'bg-green-500' : type === 'info' ? 'bg-blue-500' : 'bg-orange-500'}\`;
            notification.textContent = message;
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.classList.remove('translate-x-full');
                notification.classList.add('translate-x-0');
            }, 10);
            
            setTimeout(() => {
                notification.classList.remove('translate-x-0');
                notification.classList.add('translate-x-full');
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }
        
        // Add click animations
        document.querySelectorAll('.result-item').forEach(item => {
            item.addEventListener('click', function(e) {
                if (!e.target.closest('button')) {
                    this.style.transform = 'scale(0.99)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 200);
                }
            });
        });
        
        // Highlight keyword in all text
        document.addEventListener('DOMContentLoaded', function() {
            const keyword = "$KEYWORD";
            const regex = new RegExp(\`(\${keyword})\`, 'gi');
            document.body.innerHTML = document.body.innerHTML.replace(regex, '<span class="keyword-highlight">\$1</span>');
        });
    </script>
</body>
</html>
EOF

  # Final progress update
  echo "100" > "$HTML_PROGRESS_FILE"
}

# Run HTML generation in background
generate_html &
HTML_PID=$!

# Show progress while HTML is being generated
echo "🔄 Generating HTML report..."
while kill -0 $HTML_PID 2>/dev/null; do
    progress=$(cat "$HTML_PROGRESS_FILE" 2>/dev/null || echo "0")
    
    # Create progress bar
    width=30
    filled=$((progress * width / 100))
    empty=$((width - filled))
    
    bar=""
    for ((i=0; i<filled; i++)); do
        bar+="█"
    done
    for ((i=0; i<empty; i++)); do
        bar+="░"
    done
    
    printf "\r🎨 [%s] %3d%% Generating HTML" "$bar" "$progress"
    sleep 0.1
done

wait $HTML_PID

echo ""
echo "✅ HTML report generated successfully!"

# Cleanup temp files
rm -f "$CONTENT_FILE" "$FILENAME_FILE" "$HTML_PROGRESS_FILE"

# ================= FINAL OUTPUT =================
echo ""
echo "✨ Beautiful Linux Search Report Generated:"
echo "   📁 Location: $HTML_FILE"
echo ""
echo "📊 Search Statistics:"
echo "   - Content matches: $CONTENT_COUNT"
echo "   - Filename matches: $FILENAME_COUNT"
echo "   - Total matches: $((CONTENT_COUNT + FILENAME_COUNT))"
echo "   - Search time: ${SECONDS} seconds"
echo "   - Valid paths: ${#VALID_PATHS[@]}"
echo ""

# Open HTML in default browser automatically
echo "🌐 Opening in your default browser..."

# Try different methods to open the HTML file
if command -v xdg-open &> /dev/null; then
    xdg-open "$HTML_FILE" 2>/dev/null &
elif command -v open &> /dev/null; then
    open "$HTML_FILE" 2>/dev/null &
elif command -v firefox &> /dev/null; then
    firefox "$HTML_FILE" 2>/dev/null &
elif command -v google-chrome &> /dev/null; then
    google-chrome "$HTML_FILE" 2>/dev/null &
elif command -v chromium-browser &> /dev/null; then
    chromium-browser "$HTML_FILE" 2>/dev/null &
else
    echo ""
    echo "⚠️  Could not auto-open browser. Please open manually:"
    echo "   file://$HTML_FILE"
fi

echo ""
echo "🎉 Search completed successfully!"
echo ""