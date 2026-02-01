#!/usr/bin/env bash

# Colors for UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# FIXED: Default download directory for Termux (SD Card)
OUTPUT_DIR="/sdcard/utube"

# Progress bar function
show_progress() {
    local width=50
    local percent=$1
    local filled=$((width * percent / 100))
    local empty=$((width - filled))
    
    printf "\r${CYAN}["
    for ((i=0; i<filled; i++)); do
        printf "█"
    done
    for ((i=0; i<empty; i++)); do
        printf "░"
    done
    printf "] ${percent}%%${NC}"
}

# Simulated download progress (for demo)
simulate_progress() {
    echo -e "\n${YELLOW}⏳ Starting download...${NC}\n"
    for i in {0..100}; do
        show_progress $i
        sleep 0.05  # Simulate download time
    done
    echo -e "\n${GREEN}✅ Download complete!${NC}\n"
}

# Display download info
show_download_info() {
    clear
    echo -e "${PURPLE}==============================${NC}"
    echo -e "${WHITE}     TERMUX YDL Downloader     ${NC}"
    echo -e "${PURPLE}==============================${NC}"
    echo -e "${CYAN}Selected: ${WHITE}$1${NC}"
    echo -e "${CYAN}URL: ${WHITE}$2${NC}"
    echo -e "${CYAN}Location: ${WHITE}$OUTPUT_DIR${NC}"
    echo -e "${PURPLE}==============================${NC}"
}

# Check dependencies for Termux
check_dependencies() {
    echo -e "${YELLOW}Checking dependencies...${NC}"
    
    # Check and install yt-dlp
    if ! command -v yt-dlp &> /dev/null; then
        echo -e "${RED}❌ yt-dlp is not installed!${NC}"
        echo -e "${YELLOW}Installing yt-dlp...${NC}"
        
        # For Termux
        if [[ -d /data/data/com.termux ]]; then
            pkg update -y
            pkg install -y python python-pip ffmpeg
            pip install yt-dlp
        else
            # For regular Linux systems
            sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
            sudo chmod a+rx /usr/local/bin/yt-dlp
        fi
        echo -e "${GREEN}✅ yt-dlp installed successfully!${NC}"
    else
        echo -e "${GREEN}✅ yt-dlp is already installed${NC}"
    fi
    
    # Check ffmpeg
    if ! command -v ffmpeg &> /dev/null; then
        echo -e "${YELLOW}⚠️  ffmpeg is not installed. Audio conversions may fail.${NC}"
        read -p "Install ffmpeg? (y/n): " install_ffmpeg
        if [[ $install_ffmpeg == "y" ]]; then
            if [[ -d /data/data/com.termux ]]; then
                # Termux
                pkg install -y ffmpeg
            elif [[ -f /etc/debian_version ]]; then
                sudo apt-get update && sudo apt-get install -y ffmpeg
            elif [[ -f /etc/redhat-release ]]; then
                sudo yum install -y ffmpeg
            elif [[ "$OSTYPE" == "darwin"* ]]; then
                brew install ffmpeg
            fi
            echo -e "${GREEN}✅ ffmpeg installed successfully!${NC}"
        fi
    else
        echo -e "${GREEN}✅ ffmpeg is already installed${NC}"
    fi
    
    # Check and create download directory
    if [[ ! -d "$OUTPUT_DIR" ]]; then
        echo -e "${YELLOW}Creating download directory...${NC}"
        mkdir -p "$OUTPUT_DIR"
        echo -e "${GREEN}✅ Directory created: $OUTPUT_DIR${NC}"
    fi
    
    # Check storage permission for Termux
    if [[ -d /data/data/com.termux ]]; then
        if [[ ! -d /sdcard ]]; then
            echo -e "${YELLOW}Granting storage permission...${NC}"
            termux-setup-storage
            sleep 2
        fi
    fi
}

# Show menu
show_menu() {
    clear
    echo -e "${PURPLE}==============================${NC}"
    echo -e "${WHITE}     TERMUX YDL Downloader     ${NC}"
    echo -e "${PURPLE}==============================${NC}"
    echo -e "${CYAN}Downloading to:${NC}"
    echo -e "${WHITE}$OUTPUT_DIR${NC}"
    echo -e "${PURPLE}==============================${NC}"
    echo -e "${GREEN}1) Best Video + Audio${NC}"
    echo -e "${BLUE}2) 1080p Video${NC}"
    echo -e "${CYAN}3) 720p Video${NC}"
    echo -e "${YELLOW}4) 480p Video${NC}"
    echo -e "${RED}5) Audio MP3${NC}"
    echo -e "${RED}6) Audio M4A${NC}"
    echo -e "${WHITE}7) Custom Quality${NC}"
    echo -e "${WHITE}8) Playlist Download${NC}"
    echo -e "${WHITE}9) Show Info Only${NC}"
    echo -e "${WHITE}0) Update yt-dlp${NC}"
    echo -e "${PURPLE}==============================${NC}"
}

# Custom quality selection
custom_quality() {
    echo -e "${CYAN}Available quality options:${NC}"
    echo "1) 4K (2160p)"
    echo "2) 1440p"
    echo "3) 1080p"
    echo "4) 720p"
    echo "5) 480p"
    echo "6) 360p"
    read -p "Choose quality (1-6): " quality_choice
    
    case "$quality_choice" in
        1) height=2160 ;;
        2) height=1440 ;;
        3) height=1080 ;;
        4) height=720 ;;
        5) height=480 ;;
        6) height=360 ;;
        *) echo -e "${RED}Invalid choice, using 1080p${NC}"; height=1080 ;;
    esac
    
    yt-dlp -f "bv*[height<=${height}]+ba/best" --merge-output-format mkv -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$url"
}

# Playlist download
playlist_download() {
    echo -e "${YELLOW}Playlist Options:${NC}"
    echo "1) Download entire playlist"
    echo "2) Download specific range"
    echo "3) Download single video from playlist"
    read -p "Choose option (1-3): " playlist_option
    
    case "$playlist_option" in
        1)
            yt-dlp -f "bv*+ba/best" --yes-playlist -o "$OUTPUT_DIR/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" "$url"
            ;;
        2)
            read -p "Start from video number: " start
            read -p "End at video number: " end
            yt-dlp -f "bv*+ba/best" --playlist-start $start --playlist-end $end -o "$OUTPUT_DIR/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" "$url"
            ;;
        3)
            yt-dlp -f "bv*+ba/best" --no-playlist -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$url"
            ;;
        *)
            yt-dlp -f "bv*+ba/best" --yes-playlist -o "$OUTPUT_DIR/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" "$url"
            ;;
    esac
}

# Main script
main() {
    check_dependencies
    
    while true; do
        show_menu
        read -p "Choose option (0-9, q to quit): " option
        
        if [[ "$option" == "q" ]]; then
            echo -e "${GREEN}👋 Goodbye!${NC}"
            exit 0
        fi
        
        if [[ "$option" != "0" && "$option" != "9" ]]; then
            read -p "Paste video URL: " url
            if [[ -z "$url" ]]; then
                echo -e "${RED}❌ URL cannot be empty!${NC}"
                sleep 2
                continue
            fi
        fi
        
        case "$option" in
            0)
                echo -e "${YELLOW}Updating yt-dlp...${NC}"
                if [[ -d /data/data/com.termux ]]; then
                    pip install --upgrade yt-dlp
                else
                    sudo yt-dlp -U
                fi
                ;;
            1)
                show_download_info "Best Video + Audio" "$url"
                simulate_progress
                yt-dlp -f "bv*+ba/best" --merge-output-format mkv -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$url"
                ;;
            2)
                show_download_info "1080p Video" "$url"
                simulate_progress
                yt-dlp -f "bv*[height<=1080]+ba/best" --merge-output-format mkv -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$url"
                ;;
            3)
                show_download_info "720p Video" "$url"
                simulate_progress
                yt-dlp -f "bv*[height<=720]+ba/best" -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$url"
                ;;
            4)
                show_download_info "480p Video" "$url"
                simulate_progress
                yt-dlp -f "bv*[height<=480]+ba/best" -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$url"
                ;;
            5)
                show_download_info "Audio MP3" "$url"
                simulate_progress
                yt-dlp -x --audio-format mp3 --audio-quality 0 -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$url"
                ;;
            6)
                show_download_info "Audio M4A" "$url"
                simulate_progress
                yt-dlp -x --audio-format m4a -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$url"
                ;;
            7)
                show_download_info "Custom Quality" "$url"
                custom_quality
                ;;
            8)
                show_download_info "Playlist Download" "$url"
                playlist_download
                ;;
            9)
                echo -e "${YELLOW}Fetching video info...${NC}"
                yt-dlp --list-formats "$url"
                read -p "Press Enter to continue..."
                ;;
            *)
                echo -e "${RED}❌ Invalid option${NC}"
                sleep 2
                continue
                ;;
        esac
        
        # Show completion message with file location
        echo -e "\n${GREEN}=================================${NC}"
        echo -e "${GREEN}      Operation Complete!       ${NC}"
        echo -e "${GREEN}=================================${NC}"
        echo -e "${CYAN}Files saved to:${NC}"
        echo -e "${WHITE}$OUTPUT_DIR${NC}"
        
        # List downloaded files
        echo -e "\n${YELLOW}📁 Recent downloads:${NC}"
        ls -lt "$OUTPUT_DIR" | head -5
        
        read -p "Download another? (y/n): " another
        if [[ "$another" != "y" ]]; then
            echo -e "${GREEN}👋 Goodbye!${NC}"
            break
        fi
    done
}

# Run main function
main