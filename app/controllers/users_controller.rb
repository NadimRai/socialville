class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_the_user, only: [:show]
  

# Making Friends ---------------------  
	def index
	case params[:people] when "friends"
      @users = current_user.active_friends
    when "requests"
      @users = current_user.pending_friend_requests_from.map(&:user)
    when "pending"
      @users = current_user.pending_friend_requests_to.map(&:friend)
    else
      @users = User.where.not(id: current_user.id)
    end
	end
# Making Friends ---------------------	


  def show
  end
  
  
    private
    
    def set_the_user
      @user = User.find_by(username: params[:id])
    end
end