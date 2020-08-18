require './lib/log_parser'
require 'spec_helper'
require 'byebug'

RSpec.describe LogParser do
  let(:file_path) { './spec/data/webserver.log' }
  let(:subject) { described_class.new(file_path) }

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
      expected_visits = {
        '/help_page/1' => ['126.318.035.038', '929.398.951.889', '722.247.931.582', '646.865.545.408'],
        '/contact' => ['184.123.665.067'],
        '/home'=> ['184.123.665.067', '235.313.352.950'],
        '/about/2'=> ['444.701.448.104'],
        '/index'=> ['444.701.448.104'],
        '/about'=> ['061.945.150.735']
      }
      
      expect(subject.visits).to eq(expected_visits)
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
end