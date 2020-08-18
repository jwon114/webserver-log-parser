require './lib/log_parser'
require 'spec_helper'
require 'byebug'

RSpec.describe LogParser do
  let(:file_path) { './spec/data/webserver.log' }
  let(:subject) { described_class.new(file_path) }
  let(:parsed_views) do
    {
      '/help_page/1' => ['126.318.035.038', '929.398.951.889', '722.247.931.582', '646.865.545.408'],
      '/contact' => ['184.123.665.067', '184.123.665.067'],
      '/home' => ['184.123.665.067', '235.313.352.950', '235.313.352.950', '235.313.352.950'],
      '/about/2' => ['444.701.448.104', '444.701.448.104'],
      '/index' => ['444.701.448.104', '444.701.448.104'],
      '/about' => ['061.945.150.735']
    }
  end

  describe '#initialize' do
    it 'loads the log file' do
      expect(subject.file_path).to eq(file_path)
    end

    it 'sets visits to empty hash' do
      expect(subject.visits).to eq(Hash.new)
    end
  end

  describe '#parse' do
    it 'opens the file and reads line by line' do
      subject.parse
      expect(subject.visits).to eq(parsed_views)
    end
  end

  describe '#most_page_views' do
    let(:most_page_views) do
      [
        { '/home' => 4 },
        { '/help_page/1' => 4 },        
        { '/index' => 2 },
        { '/about/2' => 2 },
        { '/contact' => 2 },
        { '/about' => 1 }
      ]
    end

    let(:most_unique_views) do
      [
        { '/help_page/1' => 4 },
        { '/home' => 2 },
        { '/about' => 1 },
        { '/index' => 1 },
        { '/about/2' => 1 },
        { '/contact' => 1 }        
      ]  
    end

    it 'returns a descending list of page views' do
      subject.instance_variable_set(:@visits, parsed_views)
      expect(subject.most_page_views).to eq(most_page_views)
    end

    it 'returns a descending list of unique page views' do
      subject.instance_variable_set(:@visits, parsed_views)
      expect(subject.most_unique_views).to eq(most_unique_views)
    end
  end

  describe '#file_exists?' do
    it 'raises exception when file does not exist' do
      expect { subject.send(:file_exists?, '') }.to raise_error(FileNotFound, 'File does not exist')
    end

    it 'returns file path if file exists' do
      expect(subject.send(:file_exists?, file_path)).to eq(file_path)
    end
  end

  describe '#sort_and_order' do
    let(:unordered_hash) { { a: 2, b: 3, c: 1} }
    let(:ordered_hash) { [{ b: 3 }, { a: 2 }, { c: 1 }] }

    it 'sorts by hash value and orders by descending, returning an array' do      
      expect(subject.send(:sort_and_order, unordered_hash)).to eq(ordered_hash)
    end
  end
end