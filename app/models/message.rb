class Message < ActiveRecord::Base
  # before_create :send_message

  # private

  def send_message
    begin
    response = RestClient::Request.new(
      :method => :post,
      :url => 'https://api.twilio.com/2010-04-01/Accounts/AC8b37026640c29be0f05e793c8a707ed5/Messages.json',
      :user => ENV['TWILIO_ACCOUNT_SID'],
      :password => ENV['TWILIO_AUTH_TOKEN'],
      :payload => { :Body => body,
                    :To => to,
                    :From => from }
    ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      false
      response = message
    end
    response
  end
end
