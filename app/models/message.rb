class Message < ActiveRecord::Base
  before_create :send_message

  private

  def send_message
    response = RestClient::Request.new(
      :method => :post,
      :url => 'https://api.twilio.com/2010-04-01/Accounts/AC8b37026640c29be0f05e793c8a707ed5/Messages.json',
      :user => 'AC8b37026640c29be0f05e793c8a707ed5',
      :password => '38c1f0c964af302ce043cd171658c7f8',
      :payload => { :Body => body,
                    :To => to,
                    :From => from }
    ).execute
  end
end
