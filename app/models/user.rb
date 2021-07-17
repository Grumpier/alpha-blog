class User < ApplicationRecord
    # run this closure on the object before saving
    before_save { self.email = email.downcase }

    # one to many association with article
    # dependent articles will be destroyed if a user is destoryed
    has_many :articles, dependent: :destroy
    validates :username, presence: true, 
        uniqueness: { case_sensitive: false }, 
        length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
        uniqueness: { case_sensitive: false }, 
        length: { maximum: 105 },
        format: { with: VALID_EMAIL_REGEX }
    has_secure_password
end
  