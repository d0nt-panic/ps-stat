require 'rails_helper'

RSpec.describe Tournament::Parser do
  describe 'valid file' do
    let(:nickname) { 'Fedor' }
    let(:valid_file_path) { Rails.root.join('spec', 'fixtures', 'valid_tourney.txt') }
    subject { Tournament::Parser.new(valid_file_path, nickname).call }

    it 'return correct hash' do
      expect(subject).to match(
        tourney_number: 100500,
        players: 3,
        buy_in: 92,
        rake: 8,
        prize_pool: 200,
        place: 1,
        reward: 200,
        started_at: DateTime.parse('01.01.2017 16:50:55 ВВ').in_time_zone
      )
    end
  end

  describe 'invalid file' do
    pending 'spec in progress'
  end
end
