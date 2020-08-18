require 'byebug'
require 'error'

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

  private

  def file_exists?(path)
    raise FileNotFound.new('File does not exist') unless File.file?(path)
    path
  end
end