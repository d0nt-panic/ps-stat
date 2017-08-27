require 'rails_helper'

RSpec.describe GameValidator do
  let(:data) do
    {
      user_id: 1, tourn_summary_id: 1, tourney_number: 100500,
      players: 3, buy_in: 92, rake: 8,
      prize_pool: 200, place: 1, reward: 200,
      started_at: DateTime.parse('01.01.2017 16:50:55 ВВ').utc
    }
  end

  describe '#save!' do
    context 'success' do
      subject { described_class.new(data: data).save }

      it 'create game' do
        expect(subject).to be_an_instance_of(Game)
      end
    end

    context 'fail' do
      subject { described_class.new(data: { invalid: 'hash' }) }

      it 'return nil' do
        expect(subject.save).to be nil
      end

      it 'errors' do
        subject.save
        expect(subject.errors).not_to eq nil
      end
    end
  end
end
