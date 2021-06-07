# frozen_string_literal: true

module Seeds
  class UserSeeder
    DEFAULT_PASSWORD = '123456'
    DEFAULT_LAST_NAME = 'Tuser'
    FAKE_USERS_COUNT = 10

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

        create_fake_users
      end

      private

      def create_fake_users
        fake_users = []

        FAKE_USERS_COUNT.times do
          fake_users << {
            role: :client,
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.unique.email,
            created_at: Faker::Date.between(from: 1.year.ago, to: Time.current),
            updated_at: Time.current
          }
        end

        User.upsert_all(fake_users)
      end
    end
  end
end
