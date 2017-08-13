require 'rails_helper'

RSpec.describe Tournament::LineParsers::LineParsers do
  let(:line) { "Общий призовой фонд: $2.00 USD \n" }
  subject { described_class.new(line).parse }

  it 'return result hash' do
    expect(subject).to match(prize_pool: '2.00')
  end
end
