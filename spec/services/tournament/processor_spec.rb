require 'rails_helper'

RSpec.describe Tournament::Processor do
  let(:user_id) { User.create.id }

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

    subject { described_class.new(tourn_summary) }

    context 'success (tourn_summary with correct data)' do
      it 'return true' do
        expect(subject.call).to eq true
      end

      it 'change tourn_summary state to success' do
        pending
        # test that tourn_summary.aasm_state == :success
      end
    end

    context 'failed (tourn_summary without correct data)' do
      let(:tourn_summary) { TournSummary.create(user_id: user_id) }

      it 'return false' do
        expect(subject.call).to eq false
      end

      it 'change state to fail' do
        pending
        # subject.call
        # expect(subject.tourn_summary.aasm_state).to eq :failed
      end
    end
  end
end
