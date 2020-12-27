require 'rails_helper'
RSpec.describe ::Identity::JwtService do
  subject(:jwt_service_opts) { described_class }
  let(:user_payload) { { user_id: 1 } }
  let(:verify_key) { '59F72693ECA21649' }

  describe '.encode' do
    context 'when generate token sucessfull' do
      it 'returns an jwt token is encoded' do
        token = jwt_service_opts.encode(user_payload, verify_key)
        expect(token).not_to be_nil
      end
    end

    context 'when generate token without payload' do
      it 'raises an exception payload should be required' do
        expect { jwt_service_opts.encode(nil) }.to raise_error(Identity::JwtServicePayloadEmpty)
      end
    end
  end

  describe '.decode' do
    context 'when verify token sucessfull' do
      subject do
        token = jwt_service_opts.encode(user_payload, verify_key)
        jwt_service_opts.decode(token, verify_key)
      end

      it 'returns an payload having user_id attribute' do
        is_expected.to have_key(:user_id)
      end

      it 'returns a value of user_id definitely' do
        expect(subject['user_id']).to eq(user_payload[:user_id])
      end
    end
  end
end
