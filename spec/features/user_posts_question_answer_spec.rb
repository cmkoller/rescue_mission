require "rails_helper"

feature "Post Qustion Answer", %q(
As a user
I want to answer another user's question
So that I can help them solve their problem

Acceptance Criteria

- I must be on the question detail page
- I must provide a description that is at least 50 characters long
- I must be presented with errors if I fill out the form incorrectly
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

    scenario 'user posts answer from "question details" page' do
      question = FactoryGirl.create(:question)

      answer = "Here's a nice, long, well-thought-out answer that is definitely
        at least 50 characters."

      visit question_path(question.id)
      fill_in "Add an Answer:", with: answer
      click_on "Create Answer"
      expect(page).to have_content(answer)
    end

    scenario 'user posts a too-short answer' do
      question = FactoryGirl.create(:question)

      answer = "Here's a short answer."

      visit question_path(question.id)
      fill_in "Add an Answer:", with: answer
      click_on "Create Answer"
      expect(page).to have_content("Description is too short")
      expect(page).to have_no_content(answer)
    end
  end

  context 'unauthenticated user' do
    scenario "can't post answer" do
      question = FactoryGirl.create(:question)
      
      answer = "Here's a nice, long, well-thought-out answer that is definitely
      at least 50 characters."

      visit question_path(question.id)
      fill_in "Add an Answer:", with: answer
      click_on "Create Answer"
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

end
