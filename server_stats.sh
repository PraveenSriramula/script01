#!/bin/bash

# Display the current date and time
echo "Server Performance Stats - $(date)"
echo "----------------------------------"

# CPU Usage
echo "CPU Usage:"
mpstat | awk '$12 ~ /[0-9.]+/ { print "CPU Idle: " 100 - $12"%"; print "CPU Usage: " $12"%" }'
echo ""

# Memory Usage
echo "Memory Usage:"
free -h | awk '/^Mem/ { print "Total: " $2 "\nUsed: " $3 "\nFree: " $4 }'
echo ""

# Disk Usage
echo "Disk Usage:"
df -h | awk '$NF=="/"{print "Total: " $2 "\nUsed: " $3 "\nAvailable: " $4 "\nUsage: " $5}'
echo ""

# Network Performance
echo "Network Performance:"
echo "Packets Received and Transmitted:"
netstat -i | awk 'NR>2 {print $1 ": RX packets=" $3 ", TX packets=" $7}'
echo ""

# Top 5 Processes by CPU Usage
echo "Top 5 Processes by CPU Usage:"
ps aux --sort=-%cpu | head -n 6 | awk '{print "User: " $1, " | CPU%: " $3, " | MEM%: " $4, " | Command: " $11}'
echo ""

# Top 5 Processes by Memory Usage
echo "Top 5 Processes by Memory Usage:"
ps aux --sort=-%mem | head -n 6 | awk '{print "User: " $1, " | CPU%: " $3, " | MEM%: " $4, " | Command: " $11}'
echo ""

# Network Latency to a specific server (e.g., Google DNS)
echo "Network Latency to 8.8.8.8 (Google DNS):"
ping -c 4 8.8.8.8 | tail -1| awk '{print $4}' | cut -d '/' -f 2
echo ""
