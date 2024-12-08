# nosql-challenge
# filename: NoSQL_setup_starter.ipynb
<ins>Part 1: Database and Jupyter Notebook Set Up</ins></br>
> - I used the terminal to import the establishments.json file from the repository Resources folder with the command ***"mongoimport --type json -d uk_food -c establishments --drop --jsonArray establishments.json"*** to be used as the dataset<br>
> - I then created the uk_food database and establishments collection from this data and assigned them to Python variables to analyze the data
> - I used the find_one function to make sure the data loaded correctly and then assigned the collection to a varaible<br>

<ins>Part 2: Update the Database</ins>
> - I then created a dictionary for the new restaurant "Penang Flavours" with the information provided and added it to the database, and then performa a query to make sure it loaded

  ![image](https://github.com/user-attachments/assets/b32e6402-a508-492d-a765-e4bb72143af4)

> - I then used a query to return BusinessType andn BusinessTypeID values from a document to see what BusinessTypeID is assigned to Restaurant/Cafe/Canteen establishments

  ![image](https://github.com/user-attachments/assets/cc07ca6d-7b8f-4e85-8e0c-6b7c92b8465f)

> - This value is 1, so I use the update_one function to set the BusinessTypeID to 1 for this new restaurant.  Then, I run a query to make sure it updated
> - I then ran a query to find all LocalAuthorityName values that equalled Dover, then ran a delete_many function to remove them as the magazine is not interested in those documents.  Then, I run a query to make sure the values that equal Dover have been removed

  ![image](https://github.com/user-attachments/assets/5d1adf71-e1a0-4689-97b8-e0500dacb854)
  ![image](https://github.com/user-attachments/assets/6488344a-ebb8-450f-8f5d-116d9441c0c3)
  ![image](https://github.com/user-attachments/assets/e1851ad2-4e31-40b1-a42d-1073fec0b2b9)

> - I then used the update_many function to update the Latitude and Longitude fields within the geocode dictionary in all the documents to Decimal format so that we can perform calculations on them later

  ![image](https://github.com/user-attachments/assets/f7030f68-cd26-48d5-b876-32e2a195b5d9)
  ![image](https://github.com/user-attachments/assets/8bbbb322-14d5-4456-9ed1-19f9b2cc0ac7)
  
> - I then use update_many to convert all RatingValue fields from string to Integer as well as changing all non 1-5 ratings to Null for the entire dataset

  ![image](https://github.com/user-attachments/assets/ec0ffcd7-ac67-4c0b-947f-8c3901668d9d)

> - Finally, I use queries to test the type() of the latitude, longitude, and RatinGValue fields to make sure the datatype properly updated

  ![image](https://github.com/user-attachments/assets/12665398-8c14-4200-b302-3c7570545de3)
  ![image](https://github.com/user-attachments/assets/ab9b4095-8436-4a82-96da-4d3789a908fd)

# filename: NoSQL_analysis_starter.ipynb

<ins>Part 3: Exploratory Analysis</ins>
> - I used a find query to find all documents with a Hygiene score equal to 20 (Hygiene is within the score dictionary in each document) and displayed them.  I also used the count_documents() function to find the quantity of documents that have a Hygiene score of 20.  The answer is 41

  ![image](https://github.com/user-attachments/assets/54562155-0791-4864-8167-0f882e53cc4a)

> - I then turned this result into a Dataframe with db.DataFrame()
> - 

