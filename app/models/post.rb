# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :emote_reactions, as: :emotionable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 10_000 }
end
