class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :wikis
  has_many :wikis, through: :collaborators
  has_many :collaborators

  # delegate :wikis, to: :collaborators

  scope :all_except, -> (user) { where.not(id: user)}

  before_save {self.role ||= :standard}

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  validates :username, :presence => true,
            :uniqueness => {:case_sensitive => false}

  enum role: [:standard, :admin, :premium]

   def login=(login)
     @login = login
   end

   def login
     @login || self.username || self.email
   end

   def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

end
