# -*- coding: UTF-8 -*-

# Import necessary modules
import csv
import os

# Files to load and output (update with correct file paths)
file_to_load = os.path.join("Resources", "election_data.csv")  # Input file path
file_to_output = os.path.join("analysis", "election_analysis.txt")  # Output file path

# begin the total vote count at -1 because we need to store the header names to use them
# to loop through the csv document and store the candidate names in the dictionary
total_votes = -1  

# initiate the winner string variable to store the winning candidate
winner = ""

# Define lists and dictionaries to track candidate names and vote counts
candidate_name_list = []
candidate_vote_list = []
candidate_dict = {}

# Open the CSV file and process it
with open(file_to_load) as election_data:
    reader = csv.reader(election_data)

    # I would normally use #header = next(reader) to skip/store the header row, but I need the header row
    # in my code to properly test for the Candidate name

    # call the Candidate name in the csv file and loop through the CSV file in the csv reader
    for ID, County, Candidate in reader:

        # track the total of votes cast
        total_votes += 1

        # add Candidate name to the dictionary and increment the vote count in dictionary
        if Candidate not in candidate_dict:
            candidate_dict[Candidate] = 0
        candidate_dict[Candidate] += 1

# convert the dictionary keys and values lists back to lists so each element can be called and printed
# a dictionary doesn't allow this as the elements are not stored in order        
candidate_name_list = list(candidate_dict.keys())
candidate_vote_list = list(candidate_dict.values())

# calculate the winning candidate based on who has the highest number of votes in the dictionary values
winner = max(candidate_dict, key=lambda key: candidate_dict[key])

print("")
print("------------------------------------------")
print("-------------Election Results-------------")
print("------------------------------------------")
print("")
print(f'Total Votes Cast: {total_votes}')
print("")
print("------------------------------------------")
print("")
print("Percentage of total vote per candidate:")
print("")

# print the name of the candidate, calculate the percentage of the vote they received, and print
# the total votes received for each candidate
print(f'{candidate_name_list[1]}: {(candidate_vote_list[1]/total_votes)*100:.3f}% ({candidate_vote_list[1]} votes)')
print("")
print(f'{candidate_name_list[2]}: {(candidate_vote_list[2]/total_votes)*100:.3f}% ({candidate_vote_list[2]} votes)')
print("")
print(f'{candidate_name_list[3]}: {(candidate_vote_list[3]/total_votes)*100:.3f}% ({candidate_vote_list[3]} votes)')
print("")
print("------------------------------------------")
print("")
print(f'The winner of this election is: {winner}')
print("")
print("------------------------------------------")

# Open a text file to save the output
with open(file_to_output, "w") as f:

    print("", file=f)
    print("------------------------------------------", file=f)
    print("-------------Election Results-------------", file=f)
    print("------------------------------------------", file=f)
    print("", file=f)
    print(f'Total Votes Cast: {total_votes}', file=f)
    print("", file=f)
    print("------------------------------------------", file=f)
    print("", file=f)
    print("Percentage of total vote per candidate:", file=f)
    print("", file=f)

    # print the name of the candidate, calculate the percentage of the vote they received, and print
    # the total votes received for each candidate
    print(f'{candidate_name_list[1]}: {(candidate_vote_list[1]/total_votes)*100:.3f}% ({candidate_vote_list[1]} votes)', file=f)
    print("", file=f)
    print(f'{candidate_name_list[2]}: {(candidate_vote_list[2]/total_votes)*100:.3f}% ({candidate_vote_list[2]} votes)', file=f)
    print("", file=f)
    print(f'{candidate_name_list[3]}: {(candidate_vote_list[3]/total_votes)*100:.3f}% ({candidate_vote_list[3]} votes)', file=f)
    print("", file=f)
    print("------------------------------------------", file=f)
    print("", file=f)
    print(f'The winner of this election is: {winner}', file=f)
    print("", file=f)
    print("------------------------------------------", file=f)