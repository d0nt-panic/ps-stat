require 'rails_helper'

RSpec.describe Tournament::LineParsers::TourneyNumber do
  let(:line) { "PokerStars Турнир №100500, Безлимитный Холдем\n" }
  subject { described_class.new(line).parse }

  it 'return result hash' do
    expect(subject).to match(tourney_number: '100500')
  end
end

# module Tournament
#   module LineParsers
#     class TourneyNumber < LineParser
#       private

#       def pattern
#         /№(?<tourney_number>\d+)/
#       end
#     end
#   end
# end
