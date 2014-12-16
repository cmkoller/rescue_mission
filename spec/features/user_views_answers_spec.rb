require "rails_helper"

feature "View Question's Answers", %q(
As a user
I want to view the answers for a question
So that I can learn from the answer

Acceptance Criteria

- I must be on the question detail page
- I must only see answers to the question I'm viewing
- I must see all answers listed in order, most recent last
) do

  scenario 'user views single answer on "question details" page' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)


    answer = Answer.create({
      question_id: question.id,
      description: "Here's a nice, long, well-thought-out answer that is definitely
    at least 50 characters."})

    visit question_path(question.id)
    expect(page).to have_content(answer.description)
  end

  scenario 'user views multiple answers on "question details" page, in order' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)

    answer1 = Answer.create({
      question_id: question.id,
      description: "This should appear LAST! Here's a nice, long, well-thought-out answer that is definitely" +
      " at least 50 characters."})
    answer2 = Answer.create({
      question_id: question.id,
      description: "This should appear FIRST! Here's a SECOND nice, long, well-thought-out answer that is" +
      " definitely at least 50 characters."})

      visit question_path(question.id)
      expect(page).to have_content(answer1.description)
      expect(page).to have_content(answer2.description)
      # expect(answer2.description).to appear_before(answer1.description)
    end



end
