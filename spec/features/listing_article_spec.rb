require 'rails_helper'

RSpec.feature "Listing articles" do
  before do
    @article1 = Article.create(title:'The First Article', body:'Lorem Ipsum Carpe Diem')
    @article2 = Article.create(title:'The Second Article', body:'Random Content')
  end

  scenario "A user views all articles" do
    visit '/articles'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "A user has no articles" do
    Article.delete_all
    visit '/articles'

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within("h1#no-articles") do
      expect(page).to have_content('No Articles Created')
    end
  end
end
