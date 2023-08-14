class Posting < ApplicationRecord

  belongs_to :author,    class_name: 'User', foreign_key: 'user_id'
  belongs_to :editor,    class_name: 'User', foreign_key: 'editor_id'
  
  # rename article_with_image to snippet
  # make it return unmodified body
  # override method in Article model for proper implementation
  def snippet
    body
  end
end