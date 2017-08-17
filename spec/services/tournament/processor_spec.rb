require 'rails_helper'

RSpec.describe Tournament::Processor do
  let(:tourn_summary) {}
  let(:user) {}
  subject { described_class.new(tourn_summary, user).call }

  describe '#new' do
    context 'create instances' do
      it 'user type of User' do
      end

      it 'tourn_summary type of TournSummary' do
      end
    end
  end

  describe '#call' do
    context 'success' do
    end

    context 'tourn_summary without file' do
      let(:bad_tourn_summary) { TournSummary.create }
      let(:bad_user) { User.create }
      subject { described_class.new(bad_tourn_summary, bad_user).call }
      it 'change state to fail' do
        subject
        expect(bad_tourn_summary.state).to eq :failed
      end
    end
  end
end
