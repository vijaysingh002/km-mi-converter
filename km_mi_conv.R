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
