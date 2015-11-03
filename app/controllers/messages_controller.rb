class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @message = Message.new

  end

  def create
    @message = Message.new(message_params)
    phone_numbers = @message.to.split(",")

    phone_numbers.each do |phone_number|
      @message = Message.new(to: phone_number, from: message_params['from'], body: message_params['body'])
      @message.to = phone_number
      @response = @message.send_message

      @message.date_sent = @response['date_created']

      @message.save

      if @response['status'] == "queued"
        flash[:notice] = "Message sent"
      else
        flash[:notice] = @response
      end
    end

    redirect_to index
  end

private
  def message_params
    params.require(:message).permit(:to, :from, :body)
  end

end
