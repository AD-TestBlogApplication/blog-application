# frozen_string_literal: true

module Seeds
  class PostSeeder
    FAKE_POSTS_PER_USER_COUNT = 3
    CONTENT_SENTENCES_RANGE = 5..30

    class << self
      def seed
        fake_posts = []

        User.pluck(:id, :created_at).each do |user_id, user_created_at|
          FAKE_POSTS_PER_USER_COUNT.times do
            fake_posts << {
              user_id: user_id,
              content: Faker::Lorem.paragraph(sentence_count: CONTENT_SENTENCES_RANGE),
              created_at: Faker::Date.between(from: user_created_at, to: Time.current),
              updated_at: Time.current
            }
          end
        end

        Post.upsert_all(fake_posts)
      end
    end
  end
end
