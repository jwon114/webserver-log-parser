require './lib/log_parser'
require './lib/printer'

parser = LogParser.new(ARGV[0])
parser.parse

puts "List of Webpages with Most Views"
Printer.print_visits(parser.most_page_views)

