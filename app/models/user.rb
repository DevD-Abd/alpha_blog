class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_secure_password
    
    has_many :articles, dependent: :destroy
    validates :username, presence: true, 
                                        length: { minimum: 3, maximum: 25 },
                                        uniqueness: { case_sensitive: false }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
                                        uniqueness: { case_sensitive: false}, 
                                        length: { maximum: 105 }, 
                                        format: { with: VALID_EMAIL_REGEX }
end