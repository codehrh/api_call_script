# API Call Script
This is a simple Ruby script that fetches data from an API and allows the user to download (as CSV or JSON) or print the data to console.

# Related Project
## API fetching app: `https://github.com/codehrh/api_fetching_app`
- The related project shows the a fully functioning frontend, along with the necessary backend logic. Please see the README file in the repository of api_fetching_app for more information! 😃

## Features
- Fetches trivia questions from an API (OpenTDB).
- Allows users to download the questions as JSON or CSV.
- Allows users to print the data on the terminal.

## Installation
1. Clone the repository: `git clone https://github.com/codehrh/api_call_script`
2. Navigate to the project directory: `cd api_call_script`

## Usage
1. Run the script using the following format: `ruby api_call.rb -n <number_of_questions> -f <format>`

## Notes
1. Trivia questions will be fetched once according to the set number of questions.
2. Format only accepts json, csv, or console.

## Languages Used
- Ruby
