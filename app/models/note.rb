class Note < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :content, presence: true
  
  def rendered_content
    require 'redcarpet'
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(content)
  end
end
