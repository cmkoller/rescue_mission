require "rails_helper"

feature "View Question's Details", %q(
As a user
I want to view a question's details
So that I can effectively understand the question

Acceptance Criteria

- I must be able to get to this page from the questions index
- I must see the question's title
- I must see the question's description
) do

  scenario 'user follows link from index page, views question details' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)

    visit questions_path
    click_on question.title
    expect(page).to have_content(question.title)
    expect(page).to have_content(question.description)
  end

end
