# frozen_string_literal: true

module Seeds
  class UserSeeder
    class << self
      def seed
        User.roles.keys.each do |role|
          User.find_or_create_by!(email: "#{role}@test") do |user|
            user.password = '123456'
            user.role = role
          end
        end
      end
    end
  end
end
