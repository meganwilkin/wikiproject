class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  # delegate :users, to: :collaborators

  scope :all_except, -> (user) { where.not(id: user)}

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true

  # def collaborators
  #   Collaborator.where(wiki_id: users)
  #   # users
  # end

  def owner
   user
  end

end
