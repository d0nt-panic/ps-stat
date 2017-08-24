require 'rails_helper'

# TODO: complete spec using Rspec.shared_example
RSpec.describe Tournament::LineParsers::Repository do
  describe '#formatter_for' do
    let(:result) { raise 'define me!' }
    subject { described_class.formatter_for(result) }

    context 'with bad key' do
      let(:result) do
        {
          bad_key: 'value'
        }
      end

      it 'raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'with date with time zone' do
      let(:result) do
        {
          started_at: '01.01.2017 16:50:55 ВВ'
        }
      end

      it 'parse in correct UTC' do
        expect(subject).to match(started_at: DateTime.new(2017, 1, 1, 20, 50, 55).utc)
      end
    end
  end
end
