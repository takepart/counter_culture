class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  counter_culture :product
  counter_culture :product, :column_name => 'rexiews_count'
  counter_culture :user
  counter_culture :user, :column_name => Proc.new { |model| model.review_type ? "#{model.review_type}_count" : nil }, :column_names => {"reviews.review_type = 'using'" => 'using_count', "reviews.review_type = 'tried'" => 'tried_count'}
  counter_culture [:user, :manages_company]
  counter_culture [:user, :manages_company, :industry]
  counter_culture [:user, :manages_company, :industry], :column_name => 'rexiews_count'
  counter_culture [:user, :manages_company, :industry], :column_name => Proc.new { |model| model.review_type ? "#{model.review_type}_count" : nil }

  after_create :update_some_text

  def update_some_text
    update_attribute(:some_text, rand(36**12).to_s(36))
  end
end
