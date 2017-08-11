require 'rails_helper'

RSpec.describe Tournament::LineParsers::FindPlaceAndReward do
  let(:nickname) { 'Fedor' }

  describe 'current person' do
    subject { described_class.new(line, nickname).parse }

    context 'in prize' do
      let(:line) { "  1: Fedor (Russia), $2,00 (100%)\n" }
      it 'return result hash' do
        expect(subject).to match(place: '1', nickname: 'Fedor', reward: '2,00')
      end
    end

    context 'not in prize' do
      let(:line) { "  1: Fedor (Russia), \n" }
      it 'return result hash' do
        expect(subject).to match(place: '1', nickname: 'Fedor')
      end
    end
  end

  describe 'other person' do
    let(:line) { "2: Sam (Canada), \n" }
    it 'return result hash' do
      expect(subject).to match({})
    end
  end
end

# module Tournament
#   module LineParsers
#     class FindPlaceAndReward < LineParser
#       def initialize(line, opts)
#         super
#         @nickname = opts[:nickname]
#       end

#       def parse
#         super
#         raise WrongUser unless @parse_result['nickname'] == @nickname
#         reward_result = if @parse_result['place'].to_i <= Tournament::Parser::PLACES_IN_PRIZES
#                           @line.match(reward_pattern).named_captures
#                         else
#                           { reward: '0,00' }
#                         end
#         @parse_result.merge!(reward_result)
#       end

#       # private

#       def pattern
#         /(?<place>\d+): (?<nickname>\w+) .+\),/
#       end

#       def reward_pattern
#         /\$(?<reward>\d+\,\d+)/
#       end
#     end
#   end
# end
