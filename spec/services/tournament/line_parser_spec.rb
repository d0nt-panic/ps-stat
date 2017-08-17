require 'rails_helper'

RSpec.describe Tournament::LineParser do
  describe '#parse' do
    context 'call from father class' do
      subject { described_class.new('test line').parse }
      it 'return error' do
        expect { subject }.to raise_error NotImplementedError
      end
    end
  end
end
