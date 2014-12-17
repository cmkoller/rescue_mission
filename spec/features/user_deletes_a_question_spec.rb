require "rails_helper"

feature "Delete Question", %q(
As a user
I want to delete a question
So that I can delete duplicate questions

Acceptance Criteria

- I must be able delete a question from the question edit page
- I must be able delete a question from the question details page
- All answers associated with the question must also be deleted
) do

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

  scenario 'user deletes a question from question details page' do
    question = FactoryGirl.create(:question)
    visit question_path(question.id)
    click_on "Delete"
    expect(page).to have_content("Question Deleted")
    expect(page).to have_content("Questions")
    expect(page).to have_no_content(question.title)
  end

end
