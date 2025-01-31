#!/bin/bash
# Purpose: To check the traffic between a particular time duration
# Author: Muhammad Muneeb | Cloudways
# Last Edited: 16/09/2023:09:05
# Usage: wget https://raw.githubusercontent.com/ThakurGumansingh/scripts/main/traffic.sh && bash traffic.sh

# Prompt the user for the first date and time
read -p "Enter the first date and time (DD/MM/YYYY HH:MM): " first_datetime

# Prompt the user for the second date and time
read -p "Enter the second date and time (DD/MM/YYYY HH:MM): " second_datetime

# Get the current working directory
current_dir=$(pwd)

# Extract the database name from the directory path
dbname=$(echo "$current_dir" | grep -oP '(?<=applications/)[^/]+')

# Execute the apm traffic command with the provided timestamps and fetched database name
sudo apm traffic -s "$dbname" -f "$first_datetime" -u "$second_datetime"

rm -rf ./traffic.sh
exit
