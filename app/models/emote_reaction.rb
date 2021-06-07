# frozen_string_literal: true

class EmoteReaction < ApplicationRecord
  belongs_to :user
  belongs_to :emotionable, polymorphic: true

  enum kind: { like: 0, dislike: 1 }

  validates :user, uniqueness: { scope: %i[emotionable_id emotionable_type kind] }
end
