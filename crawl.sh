#!/bin/bash
# Purpose: To add a delay for bots in robots.txt file
# Author: Muhammad Muneeb | Cloudways
# Last Edited: 15/09/2023:09:30
# Usage: wget https://raw.githubusercontent.com/ThakurGumansingh/scripts/main/crawl.sh && bash crawl.sh

# Get the current working directory
current_dir=$(pwd)

# Extract the database name from the directory path
dbname=$(echo "$current_dir" | grep -oP '(?<=applications/)[^/]+')

# Define the location of the robots.txt file
ROBOTS_FILE="/home/master/applications/$dbname/public_html/robots.txt"

# Function to add a bot and delay to the robots.txt file
add_bot() {
  local bot_name="$1"
  local delay="$2"
  # Convert bot name to lowercase for case-insensitive matching
  bot_name_lc="$(echo "$bot_name" | tr '[:upper:]' '[:lower:]')"

  # Check if the bot name is already defined in the robots.txt file
  if grep -q -i "$bot_name_lc" "$ROBOTS_FILE"; then
    # Bot name already exists, update the delay
    sed -i -E "s/^User-agent:\s*$bot_name_lc$/User-agent: $bot_name_lc\nCrawl-delay: $delay/gi" "$ROBOTS_FILE"
  else
    # Bot name doesn't exist, add it with the specified delay
    echo "User-agent: $bot_name_lc" >> "$ROBOTS_FILE"
    echo "Crawl-delay: $delay" >> "$ROBOTS_FILE"
  fi
}

# Create a new robots.txt file or clear existing content
echo -n "" > "$ROBOTS_FILE"

# Prompt the user to add bots and delays
while true; do
  read -p "Enter the bot name (or 'done' to finish): " bot_name
  # Convert bot name to lowercase for case-insensitive matching
  bot_name_lc="$(echo "$bot_name" | tr '[:upper:]' '[:lower:]')"
  
  if [ "$bot_name_lc" == "done" ]; then
    break
  fi
  
  read -p "Enter the crawl delay for '$bot_name': " delay
  add_bot "$bot_name" "$delay"
done

echo "robots.txt file has been created/updated:"
cat "$ROBOTS_FILE"

rm -rf ./crawl.sh
exit
