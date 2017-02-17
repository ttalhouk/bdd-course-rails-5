require 'rails_helper'

RSpec.feature "Showing an article" do
  before do
    @user = User.create!({email:"example@example.com", password:"123456", password_confirmation:"123456"})

    login_as(@user)
    @article = @user.articles.create(title:'The First Article', body:'Lorem Ipsum Carpe Diem')
  end

  scenario "A user checks article details" do
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
