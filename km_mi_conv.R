convert_distance <- function() {
  # Create an empty data frame to store conversion history
  conversions <- data.frame(
    input_value     = numeric(),
    input_unit      = character(),
    converted_value = numeric(),
    converted_unit  = character(),
    stringsAsFactors = FALSE
  )
  
  repeat {
    # Ask user which unit they are converting from
    choice <- readline(prompt="Convert from (Km or Miles)? (type 'quit' to exit) ")
    choice_lower <- tolower(choice)
    
    if (choice_lower == "quit") {
      # Exit the loop if user types 'quit'
      break
    } else if (choice_lower == "km") {
      km_input <- readline(prompt="Enter distance in kilometers: ")
      km_value <- suppressWarnings(as.numeric(km_input))
      
      if (!is.na(km_value)) {
        miles <- km_value * 0.621371
        miles_rounded <- round(miles, 4)
        message(paste(km_value, "km is", miles_rounded, "miles"))
        
        # Record the conversion in the data frame
        conversions <- rbind(
          conversions,
          data.frame(
            input_value     = km_value,
            input_unit      = "km",
            converted_value = miles_rounded,
            converted_unit  = "miles",
            stringsAsFactors = FALSE
          )
        )
      } else {
        message("Invalid numeric input. Please try again.")
      }
      
    } else if (choice_lower == "miles") {
      miles_input <- readline(prompt="Enter distance in miles: ")
      miles_value <- suppressWarnings(as.numeric(miles_input))
      
      if (!is.na(miles_value)) {
        km <- miles_value / 0.621371
        km_rounded <- round(km, 4)
        message(paste(miles_value, "miles is", km_rounded, "km"))
        
        # Record the conversion in the data frame
        conversions <- rbind(
          conversions,
          data.frame(
            input_value     = miles_value,
            input_unit      = "miles",
            converted_value = km_rounded,
            converted_unit  = "km",
            stringsAsFactors = FALSE
          )
        )
      } else {
        message("Invalid numeric input. Please try again.")
      }
      
    } else {
      message("Invalid choice. Please enter 'Km', 'Miles', or 'quit'.")
    }
  }
  
  # Print a summary of all conversions
  cat("\n=== Conversions Summary ===\n")
  print(conversions)
}

# Run the function
convert_distance()
