# frozen_string_literal: true

module Seeds
  class CommentSeeder
    MAX_FAKE_COMMENTS_PER_POST_COUNT = 3
    CONTENT_SENTENCES_RANGE = 5..30

    class << self
      def seed
        fake_comments = []

        Post.pluck(:id, :created_at).each do |post_id, post_created_at|
          rand(1..MAX_FAKE_COMMENTS_PER_POST_COUNT ).times do
            fake_comments << {
              user_id: User.select(:id).order('RAND()').first.id,
              commentable_type: Post,
              commentable_id: post_id,
              content: Faker::Lorem.paragraph(sentence_count: CONTENT_SENTENCES_RANGE),
              created_at: Faker::Date.between(from: post_created_at, to: Time.current),
              updated_at: Time.current
            }
          end
        end

        Comment.upsert_all(fake_comments)
      end
    end
  end
end
