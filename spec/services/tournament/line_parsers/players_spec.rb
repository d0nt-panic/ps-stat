require 'rails_helper'

RSpec.describe Tournament::LineParsers::Players do
  let(:line) { "3 игроков(а)\n" }
  subject { described_class.new(line).formatted_result }

  it 'return result hash' do
    expect(subject).to match(players: '3')
  end
end
