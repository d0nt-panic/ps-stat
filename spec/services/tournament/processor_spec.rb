require 'rails_helper'

RSpec.describe Tournament::Processor do
  let(:user_id) { User.create(nickname: 'Fedor').id }

  describe '#new' do
    let(:tourn_summary) { raise 'define me' }

    subject { described_class.new(tourn_summary) }

    context 'with bad values' do
      let(:tourn_summary) { 'bad value' }

      it 'raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#call' do
    let(:tourn_summary) { raise 'define me' }
    let(:parse_file) { described_class.new(tourn_summary).call }

    subject { tourn_summary.aasm_state }

    context 'tourn_summary with correct data' do
      let(:correct_file) { Rails.root.join('spec', 'fixtures', 'valid_tourney.txt').open }
      let(:tourn_summary) { TournSummary.create(user_id: user_id, text_file: correct_file) }

      it 'success' do
        parse_file
        is_expected.to eq 'successful'
      end
    end

    context 'tourn_summary with incorrect data' do
      let(:incorrect_file) { Rails.root.join('spec', 'fixtures', 'invalid_tourney.txt').open }
      let(:tourn_summary) { TournSummary.create(user_id: user_id, text_file: incorrect_file) }

      it 'failed' do
        parse_file
        is_expected.to eq 'failed'
      end
    end

    context 'tourn_summary without data' do
      let(:tourn_summary) { TournSummary.create(user_id: user_id) }

      it 'failed' do
        parse_file
        is_expected.to eq 'failed'
      end
    end
  end
end
