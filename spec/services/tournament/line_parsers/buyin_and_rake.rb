require 'rails_helper'

RSpec.describe Tournament::LineParsers::BuyinAndRake do
  let(:line) { "Бай-ин: $0.92/$0.08 USD\n" }
  subject { described_class.new(line).parse }

  it 'return result hash' do
    expect(subject).to match(buy_in: '0.92', rake: '0.08')
  end
end

# module Tournament
#   module LineParsers
#     class BuyinAndRake < LineParser
#       private

#       def pattern
#         %r{\$(?<buy_in>\d+\.\d+)\/\$(?<rake>\d+\.\d+)}
#       end
#     end
#   end
# end
