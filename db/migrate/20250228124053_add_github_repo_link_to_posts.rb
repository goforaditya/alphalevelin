class AddGithubRepoLinkToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :github_repo_link, :string
  end
end
