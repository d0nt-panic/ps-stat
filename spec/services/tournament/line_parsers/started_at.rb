require 'rails_helper'

RSpec.describe Tournament::LineParsers::StartedAt do
  let(:line) { "Турнир начался 01.01.2017 0:50:55 MSK [01.01.2017 16:50:55 ВВ]\n" }
  subject { described_class.new(line).parse }

  it 'return result hash' do
    expect(subject).to match(started_at: '01.01.2017 16:50:55 ВВ')
  end
end

# module Tournament
#   module LineParsers
#     class StartedAt < LineParser
#       private

#       def pattern
#         /\[(?<started_at>.*)\]/
#       end
#     end
#   end
# end
