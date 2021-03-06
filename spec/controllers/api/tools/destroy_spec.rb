require 'spec_helper'

describe Api::ToolsController do
  include Devise::Test::ControllerHelpers
  describe '#destroy' do
    let(:user) { FactoryGirl.create(:user) }
    let(:tool_bay) { FactoryGirl.create(:tool_bay, device: user.device) }
    let(:tool_slot) { FactoryGirl.create(:tool_slot, tool_bay: tool_bay) }
    let!(:tool) { FactoryGirl.create(:tool,
                    tool_slot: tool_slot,
                    device: user.device) }

    it 'destroy a tool' do
      sign_in user
      before = Tool.count
      delete :destroy, params: { id: tool.id }
      after = Tool.count
      expect(response.status).to eq(200)
      expect(before).to be > after
    end
  end
end
