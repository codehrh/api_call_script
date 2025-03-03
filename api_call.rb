require 'net/http'
require 'json'
require 'csv'
require 'optparse'

BASE_URL = 'https://opentdb.com/api.php'

# Fetch API data method with a dynamic number of questions
def fetch_data(amount)
  url = "#{BASE_URL}?amount=#{amount}&category=9&difficulty=easy&type=boolean"
  response = Net::HTTP.get_response(URI(url))

  if response.is_a?(Net::HTTPSuccess)
    parsed_data = JSON.parse(response.body)
    puts "Data fetched successfully."
    return parsed_data["results"]
  else
    puts "Error: API request failed with status #{response.code} - #{response.message}"
    return []
  end
end

# save data as JSON
def save_as_json(data, filename = 'response.json')
  return if data.empty?
  File.write(filename, JSON.pretty_generate(data))
  puts "Data saved to #{filename}"
end

# save data as CSV
def save_as_csv(data, filename = 'response.csv')
  return if data.empty?
  CSV.open(filename, 'w', write_headers: true, headers: data.first.keys) do |csv|
    data.each { |row| csv << row.values }
  end
  puts "Data saved to #{filename}"
end

# command line logic
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby api_call.rb -n <number_of_questions> -f <format>"
  opts.on('-nNUMBER', '--number=NUMBER', Integer, 'Number of questions to fetch') { |n| options[:number] = n }
  opts.on('-fFORMAT', '--format=FORMAT', 'Output format: json, csv, console') { |f| options[:format] = f }
end.parse!

abort("Error: Missing arguments. Usage: ruby api_call.rb -n <number_of_questions> -f <format>") unless options[:number] && options[:format]

# fetching data with specified number of questions
data = fetch_data(options[:number])

# format cases
case options[:format]
when 'json' then save_as_json(data) # saves as json
when 'csv' then save_as_csv(data) # saves as csv
when 'console' then puts JSON.pretty_generate(data) # prints to console
else abort("Error: Invalid format. Choose json, csv, or console.")
end
