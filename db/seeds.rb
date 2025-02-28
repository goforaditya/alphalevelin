# Create sample data for AlphaLevelin

# Clean existing data
puts "Cleaning database..."
Post.destroy_all
Note.destroy_all
User.destroy_all
Category.destroy_all

# Create categories
puts "Creating categories..."
categories = ["Web Development", "Mobile Development", "AI & ML", "Blockchain", "Startups", "Product Management"]

category_objects = {}
categories.each do |name|
  category_objects[name] = Category.create!(name: name)
end

# Create users
puts "Creating users..."
admin = User.create!(username: "admin", email: "admin@example.com", password: "password123")
user1 = User.create!(username: "john_doe", email: "john@example.com", password: "password123")
user2 = User.create!(username: "jane_smith", email: "jane@example.com", password: "password123")

# Create welcome post
puts "Creating welcome post..."
welcome_post = Post.create!(
  title: "Welcome to AlphaLevelin! Start Here 🚀",
  content: "# Welcome to AlphaLevelin!\n\nThis platform is designed for developers and entrepreneurs to share knowledge, ideas, and experiences.\n\n## Getting Started\n\n1. **Browse the Categories**: Explore different topics through our category system\n2. **Create an Account**: Sign up to unlock all features\n3. **Create Posts**: Share your knowledge with markdown formatting\n4. **Keep Private Notes**: Store your thoughts, links, and code snippets",
  user: admin
)
welcome_post.categories << category_objects["Web Development"]

# Create markdown post
puts "Creating markdown tutorial post..."
markdown_post = Post.create!(
  title: "Mastering Markdown for Developers",
  content: "# Mastering Markdown for Developers\n\nMarkdown is an essential skill for modern developers. Here's how to make the most of it.\n\n## Why Use Markdown?\n\n* **Simplicity**: Easy to learn and use\n* **Portability**: Works across many platforms\n* **Versatility**: Good for documentation, notes, and content\n* **Developer-friendly**: Great for code snippets and technical content",
  user: user1
)
markdown_post.categories << category_objects["Web Development"]

# Create YC post
puts "Creating YC startups post..."
yc_post = Post.create!(
  title: "Y Combinator Startups to Watch",
  content: "# Notable Y Combinator Startups to Watch\n\nY Combinator continues to be the world's most prestigious startup accelerator. Here are some of their portfolio companies to keep an eye on this year.\n\n## AI & Machine Learning\n\n### TensorWave\n\nBuilding specialized AI hardware that's 10x more energy efficient than current GPUs.\n\n* Founded: 2024\n* Funding: $3.5M seed\n* Website: [tensorwave.ai](https://example.com)",
  user: user2
)
yc_post.categories << category_objects["Startups"]

# Create notes
puts "Creating notes..."
Note.create!(
  title: "Getting Started with AlphaLevelin",
  content: "# AlphaLevelin Admin Notes\n\n## Todo List\n\n- [x] Set up initial categories\n- [x] Create welcome post\n- [ ] Add more seed content\n- [ ] Implement email notifications\n- [ ] Add analytics dashboard",
  user: admin
)

Note.create!(
  title: "Y Combinator Resources & Links",
  content: "# Y Combinator Resources\n\nA collection of links and resources related to YC companies and applying to YC.\n\n## Official YC Resources\n\n* [Y Combinator Website](https://www.ycombinator.com/)\n* [Startup School](https://www.startupschool.org/)\n* [HackerNews](https://news.ycombinator.com/)",
  user: user1
)

Note.create!(
  title: "Tech Stack Comparison",
  content: "# Technology Stack Comparison\n\nComparing different tech stacks for my next project.\n\n## Frontend Options\n\n| Framework | Pros | Cons |\n|-----------|------|------|\n| React | Popular, large ecosystem | Requires additional libraries |\n| Vue | Easy to learn, comprehensive | Smaller job market |",
  user: user2
)

puts "Seed data created successfully!"
