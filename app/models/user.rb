class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :statuses



  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", 
  micro: "40x40>" }, default_url:  "ina.jpeg"  
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/ 

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy

  def request_friendship(user_2)
  	self.friendships.create(friend: user_2)
  end
  
  def pending_friend_requests_from
    self.inverse_friendships.where(friend_status: "pending")
  end
  
  def pending_friend_requests_to
    self.friendships.where(friend_status: "pending")
  end
  
  def active_friends
    self.friendships.where(friend_status: "active").map(&:friend) + self.inverse_friendships.where(friend_status: "active").map(&:user)
  end
  
    def friendship_status(user_2)
    friendship = Friendship.where(user_id: [self.id,user_2.id], friend_id: [self.id,user_2.id])
    unless friendship.any?
      return "not_friends"
    else
      if friendship.first.friend_status == "active"
        return "friends"
      else
        if friendship.first.user == self
          return "pending"
        else
          return "requested"
        end
      end
    end
  end
  
  def friendship_relation(user_2)
    Friendship.where(user_id: [self.id,user_2.id], friend_id: [self.id,user_2.id]).first
  end  
end
