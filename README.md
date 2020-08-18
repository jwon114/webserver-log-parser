# Webserver Log Parser
A Ruby parser for printing the most viewed and unique viewed webpages from a webserver log file.

## Getting Started
### Prequisites
- Ruby >= 2.6.3

### Installation
Install the project dependencies

```
bundle install
```

## Running the Tests
Navigate to the ruby_app directory

```
rspec
```

## Implementation Details
A single Log Parser class for opening, parsing and extracting data from the log file. On initialization the file path is set when provided as a run argument.

The parse method reads the file line by line, splitting the string by whitespace to a URL and IP address. This data is saved to memory in a instance variable hash named visits, with the webpage URL as a key and a value of IP addresses in an array. To find the most viewed webpages, the visits hash is iterated and the IP address array counted. For unique visits, the unique parameter is passed to the method as a boolean. Duplicate IP addresses are removed from the array before counted. Views counts are sorted in descending order.

A print method formats and outputs the view counts to the terminal.

## Execution
Parser script file. Parse the log file. Run methods to print views.
```ruby
require './lib/log_parser'

raise RuntimeError('Missing log file') if ARGV[0].nil?

parser = LogParser.new(ARGV[0])
parser.parse

puts 'List of Webpages with Most Views'
parser.list_most_page_views

puts

puts 'List of Webpages with Most Unique Views'
parser.list_most_unique_views
```

On command line
```
ruby parser.rb webserver.log
```

## Ouput
```
List of Webpages with Most Views
/about/2 90 visits
/contact 89 visits
/index 82 visits
/about 81 visits
/help_page/1 80 visits
/home 78 visits

List of Webpages with Most Unique Views
/index 23 unique views
/home 23 unique views
/contact 23 unique views
/help_page/1 23 unique views
/about/2 22 unique views
/about 21 unique views
```

## Built With
- Ruby 2.6.3
- RSpec 3.9

## Author
- James Wong