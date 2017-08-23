require 'rails_helper'

RSpec.describe Tournament::LineParsers::FindPlaceAndReward do
  let(:nickname) { 'Fedor' }
  subject { described_class.new(line, nickname: nickname).formatted_result }

  describe 'current person' do
    context 'in prize' do
      let(:line) { "  1: Fedor (Russia), $2,00 (100%)\n" }
      it 'return result hash' do
        expect(subject).to match(place: '1', reward: '2,00')
      end
    end

    context 'not in prize' do
      let(:line) { "  1: Fedor (Russia), \n" }
      it 'return result hash' do
        expect(subject).to match(place: '1', reward: '0,00')
      end
    end
  end

  describe 'other person' do
    let(:line) { "2: Sam (Canada), \n" }
    it 'return Parser::WrongUserException error' do
      expect { subject }.to raise_error Tournament::Parser::WrongUserException
    end
  end
end
