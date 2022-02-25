class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workouts, :dependent => :destroy
  has_one :tier, :foreign_key => 'id' # TODO: foregin_key 가 왜 자동으로 안잡히는지 체크하기
end
