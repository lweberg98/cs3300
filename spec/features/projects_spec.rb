
require 'rails_helper'

RSpec.feature "Projects", type: :feature do

  let(:user) {FactoryBot.create(:user)}

  def fill_in_signin_fields
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "Log in"
  end

  context "Create new project" do
    before(:each) do
      visit new_project_path
      fill_in_signin_fields
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      fill_in_signin_fields
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail" do
      fill_in_signin_fields
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end
end
