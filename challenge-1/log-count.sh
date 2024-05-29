#!/bin/bash

# Set the directory containing the log files
log_dir="./logs"

# Set the time range in minutes
time_range=10

# Set the HTTP 500 error code
error_code=500

# Get the current time in seconds
current_time=$(date +%s)

# Iterate through the log files in the directory
for log_file in "$log_dir"/*
do
    # Check if the file is a regular file
    if [ -f "$log_file" ]; then
        # Get the file modification time in seconds
        file_time=$(date -r "$log_file" +%s)

        # Check if the file was modified within the last 10 minutes
        if [ $((current_time - file_time)) -le $((time_range * 60)) ]; then
            # Count the number of HTTP 500 errors in the file
            error_count=$(grep -c "$error_code" "$log_file")
            printf "There were\t%d\tHTTP\t%d\terrors in\t%s\tin the last %d minutes\n" "$error_count" "$error_code" "$log_file" "$time_range"
        fi
    fi
done
