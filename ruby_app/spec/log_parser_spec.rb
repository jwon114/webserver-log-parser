require './lib/log_parser'
require 'spec_helper'

RSpec.describe LogParser do
  let(:subject) { described_class.new('./data/webserver.log') }

  describe '#initialize' do
    it 'loads the log file' do
      expect(subject.file_path).to eq('./data/webserver.log')
    end
  end
end