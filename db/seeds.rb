# frozen_string_literal: true

require_relative 'seeds/support'

return if Rails.env.production?

Seeds::UserSeeder.seed
Seeds::PostSeeder.seed
Seeds::CommentSeeder.seed
Seeds::EmoteReactionSeeder.seed
