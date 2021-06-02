# frozen_string_literal: true

module Seeds
  class UserSeeder
    DEFAULT_PASSWORD = '123456'
    DEFAULT_LAST_NAME = 'Tuser'

    class << self
      def seed
        User.roles.keys.each do |role|
          User.find_or_create_by!(email: "#{role}@test") do |user|
            user.password = DEFAULT_PASSWORD
            user.role = role
            user.first_name = role
            user.last_name = DEFAULT_LAST_NAME
          end
        end
      end
    end
  end
end
