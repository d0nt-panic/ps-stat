require 'rails_helper'

RSpec.describe Tournament::LineParsers::TourneyNumber do
  let(:line) { "PokerStars Турнир №100500, Безлимитный Холдем\n" }
  subject { described_class.new(line).formatted_result }

  it 'return result hash' do
    expect(subject).to match(tourney_number: '100500')
  end
end
