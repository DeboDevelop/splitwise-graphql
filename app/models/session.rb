class Session < ApplicationRecord
    belongs_to :user

    before_create do
        self.key = SecureRandom.hex(48)
        self.expires_at = Time.zone.today + 30
    end
end
