class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :rememberable,:recoverable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable
end
