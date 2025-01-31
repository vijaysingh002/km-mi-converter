# Kilometer-Mile Converter in R

## Overview
This project is an interactive R script that allows users to convert distances between **kilometers and miles**. 

## Features
- Converts between **Km and Miles** interactively.
- Handles user input validation.
- Provides accurate and rounded distance conversions.

## Usage
1. Run the script in R.
2. Enter the unit you want to convert from (Km or Miles).
3. Enter the distance.
4. The program returns the converted value.

## Code
```r
# Function to convert between kilometers and miles
convert_distance <- function() {
  choice <- readline(prompt="Convert from (Km or Miles)? ")
  
  if (tolower(choice) == "km") {
    km <- as.numeric(readline(prompt="Enter distance in kilometers: "))
    miles <- km * 0.621371
    print(paste(km, "km is", round(miles, 4), "miles"))
  } else if (tolower(choice) == "miles") {
    miles <- as.numeric(readline(prompt="Enter distance in miles: "))
    km <- miles / 0.621371
    print(paste(miles, "miles is", round(km, 4), "km"))
  } else {
    print("Invalid input! Please enter 'Km' or 'Miles'.")
  }
}
convert_distance()
