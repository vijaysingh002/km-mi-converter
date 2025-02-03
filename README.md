# **Distance Conversion Tool - README**

This repository (or script) includes two versions of an R function that converts distances between various units. Here’s a quick rundown of what’s included, how to use it, and how you can extend the functionality.

---

## **Contents**

1. [Overview](#overview)  
2. [Installation and Requirements](#installation-and-requirements)  
3. [Usage](#usage)  
   - [Version 1: Basic Extended Code](#version-1-basic-extended-code)  
   - [Version 2: Advanced Multi-Unit Code](#version-2-advanced-multi-unit-code)  
4. [Extending the Script](#extending-the-script)  
5. [License](#license)

---

## **Overview**

We provide two main conversion functions:

1. **Version 1**  
   - Allows conversion between **kilometers (km)** and **miles** within a loop.  
   - Supports simple numeric validation.  
   - Keeps track of all conversions in a data frame for a summary at the end.

2. **Version 2**  
   - Supports multiple units (kilometers, miles, meters, feet).  
   - Uses a **menu-based** interface for user input.  
   - Includes a **lookup table** of conversion factors to make extending or changing units easier.  
   - Outputs a summary of all user-performed conversions in a data frame.

Both versions are designed to be interactive in the R console.

---

## **Installation and Requirements**

1. **Software Requirements**  
   - **R (≥ 3.0.0)** is sufficient, but we recommend using the latest version of R for best compatibility.  
   - A **terminal** or **RStudio** (or any environment where you can run R scripts) is needed to execute the code.

2. **No External Packages**  
   - Both scripts only use base R functions, so **no additional package installations** are required.

---

## **Usage**

### **Version 1: Basic Extended Code**

**Script Name**: `convert_distance_version1.R` (example name, you can rename as needed)  

1. **Copy/Paste the code** (below) into an R script or your R console.

   ```r
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
   ```

2. **Run the script** in R or RStudio.  
3. **Follow the prompts**:
   - Type **"km"** or **"miles"** to select the conversion direction.
   - Input a numeric distance value.
   - Type **"quit"** to exit.
4. At the end, a summary data frame of your conversions is displayed.

---

### **Version 2: Advanced Multi-Unit Code**

**Script Name**: `convert_distance_advanced.R` (example name)

1. **Copy/Paste the code** (below) into an R script or your R console.

   ```r
   convert_distance_advanced <- function() {
     
     # Dictionary of base conversion factors to "meters" (you could choose another base unit)
     # 1 kilometer = 1000 meters, 1 mile = 1609.34 meters, 1 foot = 0.3048 meters, etc.
     conversion_factors <- list(
       km    = 1000,     # 1 km = 1000 m
       miles = 1609.34,  # 1 mile = 1609.34 m
       m     = 1,        # 1 m = 1 m (base)
       ft    = 0.3048    # 1 foot = 0.3048 m
     )

     # Initialize a data frame to store all conversions
     conversions <- data.frame(
       input_value     = numeric(),
       input_unit      = character(),
       converted_value = numeric(),
       converted_unit  = character(),
       stringsAsFactors = FALSE
     )

     repeat {
       cat("\n=== Distance Conversion Menu ===\n")
       cat("1) Convert Kilometers to another unit\n")
       cat("2) Convert Miles to another unit\n")
       cat("3) Convert Meters to another unit\n")
       cat("4) Convert Feet to another unit\n")
       cat("Q) Quit\n")

       # Prompt the user for a menu choice
       choice <- readline(prompt="Enter your choice (1-4, Q to quit): ")

       if (toupper(choice) == "Q") {
         # Quit if 'Q' is entered
         break
       }

       # Determine which unit we are converting FROM based on user choice
       from_unit <- switch(
         EXPR = choice,
         "1" = "km",
         "2" = "miles",
         "3" = "m",
         "4" = "ft",
         NA  # Default if invalid
       )

       # If user did not pick a valid menu item, show error and continue
       if (is.na(from_unit) || !from_unit %in% names(conversion_factors)) {
         cat("Invalid choice. Please try again.\n")
         next
       }

       # Prompt for the numeric value to convert
       from_value_input <- readline(
         prompt = paste("Enter distance in", from_unit, ": ")
       )
       from_value <- suppressWarnings(as.numeric(from_value_input))

       # Validate numeric input
       if (is.na(from_value)) {
         cat("Invalid numeric input. Please try again.\n")
         next
       }

       # Ask the user which unit to convert TO
       to_unit <- readline(prompt="Convert to which unit? (km, miles, m, ft): ")
       to_unit_lower <- tolower(to_unit)

       # Check if target unit is known
       if (!to_unit_lower %in% names(conversion_factors)) {
         cat("Unsupported unit. Supported units are: km, miles, m, ft.\n")
         next
       }

       # Perform conversion
       # Step 1: Convert FROM the chosen unit to the base unit (meters)
       value_in_meters <- from_value * conversion_factors[[from_unit]]
       # Step 2: Convert FROM the base unit (meters) to the target unit
       converted_value <- value_in_meters / conversion_factors[[to_unit_lower]]

       # Round the result for display
       converted_value_rounded <- round(converted_value, 4)

       cat(paste(
         from_value, from_unit, "=", converted_value_rounded, to_unit_lower, "\n"
       ))

       # Log the conversion in the data frame
       conversions <- rbind(
         conversions,
         data.frame(
           input_value     = from_value,
           input_unit      = from_unit,
           converted_value = converted_value_rounded,
           converted_unit  = to_unit_lower,
           stringsAsFactors = FALSE
         )
       )
     }

     # Print a summary of all conversions at the end
     cat("\n=== Conversions Summary ===\n")
     print(conversions)
   }

   # Run the advanced function
   convert_distance_advanced()
   ```

2. **Run the script** in R or RStudio.
3. **Menu Options**:
   - You will see options for converting **kilometers**, **miles**, **meters**, or **feet**.  
   - Enter a numeric value, then select the unit to convert **to** (`km`, `miles`, `m`, `ft`).
   - **Type “Q”** at the main menu to quit at any time.
4. At the end, the function prints a summary data frame of all conversions.

---

## **Extending the Script**

1. **Add More Units**  
   - Simply edit the `conversion_factors` list in **Version 2** to add additional units.  
   - For example, to add **yards**, you could do:  
     ```r
     conversion_factors$yd <- 0.9144   # 1 yard = 0.9144 meters
     ```

2. **Save Conversion History**  
   - Write the final `conversions` data frame to a CSV file for permanent storage:  
     ```r
     write.csv(conversions, "conversions_history.csv", row.names = FALSE)
     ```

3. **Build a Shiny App**  
   - Use the [Shiny package](https://shiny.rstudio.com/) to create a GUI that lets users input values and see results in a web-based interface.

4. **Add Unit Tests**  
   - Use [testthat](https://cran.r-project.org/web/packages/testthat/index.html) or other R testing libraries to verify conversion accuracy.

---

## **License**

This project is provided as-is without any explicit license. You are free to use, modify, and share this code in personal or commercial projects. If you distribute derivative works, please include credit to the original author(s).

---

Happy converting! If you have any questions, feel free to open an issue or contact the project maintainers.
