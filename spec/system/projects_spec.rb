require 'rails_helper'

RSpec.describe "Projects", type: :system do
  # ユーザーは新しいプロジェクトを作成する
  scenario 'user creates a new project' do
    user = FactoryBot.create(:user)

    sign_in user

    # DeviseのIntegrationHelperではセッションの作成はしてくれるが、TOPページへ遷移はしてくれない。
    # 明示的に遷移する。
    visit root_path

    expect {
      click_link 'New Project'
      fill_in 'Name', with: 'Test Project'
      fill_in 'Description', with: 'Trying out Capybara'
      click_button 'Create Project'

      expect(page).to have_content 'Project was successfully created'
      expect(page).to have_content 'Test Project'
      expect(page).to have_content "Owner: #{user.name}"
  }.to change(user.projects, :count).by(1)
  end

  scenario 'guest adds a project' do
    # visit projects_pathz
    # save_and_open_page
    # click_link "New Project"
  end
end
