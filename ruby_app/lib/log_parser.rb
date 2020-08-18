require 'byebug'
require './lib/error'

class LogParser  
  attr_reader :file_path, :visits

  def initialize(file_path)
    @file_path = file_exists?(file_path)
    @visits = Hash.new
  end

  def parse
    File.readlines(file_path).each do |line|
      url, ip_address = *line.split(' ')
      visits[url] ||= []
      visits[url] << ip_address
    end
  end

  def most_page_views
    sort_and_order(count_views(unique: false))
  end

  def most_unique_views
    sort_and_order(count_views(unique: true))
  end

  private

  def file_exists?(path)
    raise FileNotFound.new('File does not exist') unless File.file?(path)
    path
  end

  def count_views(unique:)
    visits.each_with_object(Hash.new) do |(url, ip_addresses), views| 
      views[url] = unique ? ip_addresses.uniq.count : ip_addresses.count
    end
  end

  def sort_and_order(hash)
    hash
      .sort_by(&:last)
      .reverse
      .inject(Array.new) { |arr, v| arr << Hash[v[0], v[1]] }
  end

  def print(logs, type)
    byebug
    logs.each do |(url, count)|
      puts "#{url}: #{count} #{type}"
    end
  end
end