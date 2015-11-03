class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @response = @message.send_message
binding.pry
    flash[:notice] = @response
    @message.save
    redirect_to index
  end

private
  def message_params
    params.require(:message).permit(:to, :from, :body)
  end

end
