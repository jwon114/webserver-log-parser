require './lib/log_parser'

raise RuntimeError('Missing log file') if ARGV[0].nil?

parser = LogParser.new(ARGV[0])
parser.parse

puts 'List of Webpages with Most Views'
parser.list_most_page_views

puts

puts 'List of Webpages with Most Unique Views'
parser.list_most_unique_views

