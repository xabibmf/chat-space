require 'rails_helper'
describe Message do
  describe '#create' do
    it "is valid" do
      message = build(:message)
      message.valid?
      expect(message).to be_valid
    end

    it "is invalid without a body" do
      message = build(:message, body: "")
      message.valid?
      expect(message.errors.full_messages).to include("メッセージを入力してください")
    end
  end
end
