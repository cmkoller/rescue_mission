require "rails_helper"

feature "Post a Question", %q(
  As a user
  I want to post a question
  So that I can receive help from others

  Acceptance Criteria
  [ ] I must provide a title that is at least 40 characters long
  [ ] I must provide a description that is at least 150 characters long
  [ ] I must be presented with errors if I fill out the form incorrectly

) do

  context "authenticated user" do
    before(:each) do
      user = User.create(
      first_name: "Joe",
      last_name: "Schmoe",
      email: "email@email.com",
      password: "passwordsecret"
      )

      visit new_user_session_path
      fill_in "Email",with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      visit new_question_path
    end

    scenario 'user posts a question' do
      question = FactoryGirl.create(:question)

      fill_in "Title", with: question.title
      fill_in "Description", with: question.description
      click_on "Create Question"
      expect(page).to have_content("Question created.")
      expect(page).to have_content(question.title)
      expect(page).to have_content(question.description)
    end

    scenario 'user posts a question with too-short title' do
      question = FactoryGirl.create(:question)
      question.title = "Short Title"

      fill_in "Title", with: question.title
      fill_in "Description", with: question.description
      click_on "Create Question"
      expect(page).to have_content("Title is too short")
      expect(find_field("Title").value).to eq question.title
      expect(find_field("Description").value).to eq question.description
    end

    scenario 'user posts a question with too-long title' do
      question = FactoryGirl.create(:question)
      question.title *= 8

      fill_in "Title", with: question.title
      fill_in "Description", with: question.description
      click_on "Create Question"
      expect(page).to have_content("Title is too long")
      expect(find_field("Title").value).to eq question.title
      expect(find_field("Description").value).to eq question.description
    end

    scenario 'user posts a question with too-short description' do
      question = FactoryGirl.create(:question)
      question.description = "Short description"

      fill_in "Title", with: question.title
      fill_in "Description", with: question.description
      click_on "Create Question"
      expect(page).to have_content("Description is too short")
      expect(find_field("Title").value).to eq question.title
      expect(find_field("Description").value).to eq question.description
    end
  end

  context "unauthenticated user" do
    scenario "can't access question creation form" do
      visit new_question_path
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end
end
