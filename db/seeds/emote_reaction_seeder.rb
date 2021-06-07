# frozen_string_literal: true

module Seeds
  class EmoteReactionSeeder
    MAX_REACTIONS_PER_EMOTIONABLE = 10
    CHANCE_FOR_EMOTION = 4 # 1/5

    class << self
      def seed
        fake_emote_reactions = []
        fake_emote_reactions.concat fake_reactions_on_posts

        EmoteReaction.upsert_all(fake_emote_reactions)
      end

      private

      def fake_reactions_on_posts
        Post.pluck(:id).map do |post_id|
          user_ids = User.select(:id)
                         .order('RAND()')
                         .limit(MAX_REACTIONS_PER_EMOTIONABLE)
                         .ids

          user_ids.map do |user_id|
            next if rand(CHANCE_FOR_EMOTION).zero?

            {
              user_id: user_id,
              emotionable_type: Post,
              emotionable_id: post_id,
              kind: EmoteReaction.kinds.values.sample,
              created_at: Faker::Date.between(from: 1.week.ago, to: Time.current),
              updated_at: Time.current
            }
          end.compact
        end.flatten
      end
    end
  end
end
