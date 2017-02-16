require 'rails_helper'

RSpec.feature "Deleting an article" do
  before do
    @article = Article.create(title:'The First Article', body:'Lorem Ipsum Carpe Diem')
  end

  scenario "A user deletes and article" do
    visit "/articles/#{@article.id}"

    click_link "Delete"
    expect(page).to have_content("Article has been deleted.")
    expect(page).to_not have_content(@article.title)
    expect(page).to_not have_content(@article.body)
    expect(current_path).to eq(articles_path)
  end
end
