require "rails_helper"

feature "Edit Question", %q(
As a user
I want to delete a question
So that I can delete duplicate questions

Acceptance Criteria

- I must be able delete a question from the question edit page
- I must be able delete a question from the question details page
- All answers associated with the question must also be deleted
) do

  scenario 'user deletes a question from question details page' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)

    visit question_path(question.id)
    click_on "Delete"
    expect(page).to have_content("Question Deleted")
    expect(page).to have_content("Questions")
    expect(page).to have_no_content(question.title)
  end

end
