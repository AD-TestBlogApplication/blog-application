# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :emote_reactions, as: :emotionable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 1_000 }
end
