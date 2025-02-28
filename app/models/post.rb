class Post < ApplicationRecord
  require 'net/http'
  require 'uri'

  belongs_to :user

  has_many :post_categories
  has_many :categories, through: :post_categories
  
  has_one_attached :thumbnail
  validates :title, presence: true, length: {maximum:110, minimum:10}

  def markdown_content
    if github_repo_link.present?
      # Convert GitHub web URL to raw content URL if needed
      raw_url = github_url_to_raw(github_repo_link)
      fetch_content_from_url(raw_url)
    else
      # Fallback to local content
      content
    end
  end
  
  def rendered_content
    require 'redcarpet'
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(markdown_content)
  end

  private

  def github_url_to_raw(url)
    # Convert github.com URLs to raw.githubusercontent.com URLs
    if url.include?('github.com')
      url.gsub!('github.com', 'raw.githubusercontent.com')
      url.gsub!('/blob/', '/')
    end
    url
  end

  def fetch_content_from_url(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    
    if response.is_a?(Net::HTTPSuccess)
      response.body
    else
      "Error fetching content: #{response.code} - #{response.message}"
    end
  rescue => e
    "Error: #{e.message}"
  end
end
