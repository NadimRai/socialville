class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :statuses

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", 
  micro: "40x40>" }, default_url:  "ina.jpeg"  
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/   
end
