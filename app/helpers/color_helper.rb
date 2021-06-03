# frozen_string_literal: true

module ColorHelper
  COLORS = %w[
    red orange yellow olive green teal blue violet purple pink brown grey black
  ].freeze

  COLORS.each do |color|
    define_method "#{color}_color" do
      color
    end
  end

  def random_color
    COLORS.sample
  end
end
