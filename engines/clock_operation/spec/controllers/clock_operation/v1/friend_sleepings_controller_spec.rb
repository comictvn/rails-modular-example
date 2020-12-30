require 'rails_helper'

RSpec.describe ClockOperation::V1::FriendSleepingsController do
  describe "GET #index clock_operation/v1/friend_sleepings" do
    context 'when valid get sleeping records' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it "JSON body response contains expected recipe attributes" do
        byebug
        expect(response).to match_response_schema("v1/friend_sleepings")
      end
    end
  end
end
