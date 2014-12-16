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

  scenario 'user posts answer from "question details" page' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)
    answer = "Here's a nice, long, well-thought-out answer that is definitely
      at least 50 characters."

    visit question_path(question.id)
    fill_in "Add an Answer:", with: answer
    click_on "Create Answer"
    expect(page).to have_content(answer)
  end

  scenario 'user posts a too-short answer' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)
    answer = "Here's a short answer."

    visit question_path(question.id)
    fill_in "Add an Answer:", with: answer
    click_on "Create Answer"
    expect(page).to have_content("Description is too short")
    expect(page).to have_no_content(answer)
  end

end
