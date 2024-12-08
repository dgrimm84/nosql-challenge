# -*- coding: UTF-8 -*-

# Dependencies
import csv
import os

# Files to load and output (update with correct file paths)
file_to_load = os.path.join("Resources", "budget_data.csv")  # Input file path
file_to_output = os.path.join("analysis", "budget_analysis.txt")  # Output file path

# Define variables to track the financial data
total_months = 1
total_value = 0
greatest_value = 0
current_value = 0
prev_value = 0
least_value = 0
current_net = 0
greatest_month = ""
least_month = ""

# Add more variables to track other necessary financial data
net_change_list = []
data_list = []

# Open and read the csv
with open(file_to_load) as financial_data:
    reader = csv.reader(financial_data)

    # Skip the header row
    header = next(reader)

    # Extract first row to avoid appending to net_change_list
    first_row = next(reader)
    
    # Track the total and net change
    total_value = int(first_row[1])
    prev_value = int(first_row[1])
    
    # Process each row of data
    for row in reader:
        
        #store csv row in list to compare later for greatest values
        data_list.append(row)

        # Track the total
        total_value += int(row[1])

        # Track the net change and add it to the list to store them
        current_value = int(row[1])
        current_net = current_value - prev_value
        net_change_list.append(current_net)

        #add net change to data list to track which month it happened in
        data_list.append(current_net)

        #make the current value in the row the previous value for the next net change calculation
        prev_value = current_value

        #reset current change variable to track the next change
        current_net = 0

        #increment the number of months to add to the total for final summary
        total_months += 1

#search the list of values for the greatest net increase and the month it happened
greatest_value = f"${max(net_change_list):.0f}"
greatest_month = data_list[data_list.index(max(net_change_list))-1][0]

#search the list of values for the greatest net decrease and the month it happened
least_value = f"${min(net_change_list):.0f}"
least_month = data_list[data_list.index(min(net_change_list))-1][0]

# Print the output to terminal
print("-----------------------------------------")
print("-----------Financial Analysis------------")
print("-----------------------------------------")
print(f'Number of Months: {total_months}')
print(f'Total of Profit & Losses: ${total_value}')
print(f'Average Change: {f"${sum(net_change_list)/len(net_change_list):.2f}"}')
print(f'Greatest Increase in Profits: {greatest_month} ({greatest_value})')
print(f'Greatest Decrease in Profits: {least_month} ({least_value})')
print("-----------------------------------------")

# Write the results to a text file
with open(file_to_output, "w") as f:
    print("-----------------------------------------", file=f)
    print("-----------Financial Analysis------------", file=f)
    print("-----------------------------------------", file=f)
    print(f'Number of Months: {total_months}', file=f)
    print(f'Total of Profit & Losses: ${total_value}', file=f)
    print(f'Average Change: {f"${sum(net_change_list)/len(net_change_list):.2f}"}', file=f)
    print(f'Greatest Increase in Profits: {greatest_month} ({greatest_value})', file=f)
    print(f'Greatest Decrease in Profits: {least_month} ({least_value})', file=f)
    print("-----------------------------------------", file=f)

