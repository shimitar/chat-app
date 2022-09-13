class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end

  def new
  end

 def create
  @room = Room.find(params[:room_id])
  # 特定のツイートに紐づくインスタンスを生成し、属性値を指定
  @message = @room.messages.new(message_params)
  # インスタンスを保存

  if @message.save
    redirect_to room_messages_path(@room)
  else
    @messages = @room.messages.includes(:user)
    render :index
   end
 end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
