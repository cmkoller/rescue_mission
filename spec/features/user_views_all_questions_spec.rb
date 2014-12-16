require "rails_helper"

feature "Visit Index", %q(
  As a user
  I want to view recently posted questions
  So that I can help others

  Acceptance Criteria

  [ ] I must see the title of each question
  [ ] I must see questions listed in order, most recently posted first
) do

  scenario 'user visits index page with one item' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)

    visit questions_path
    expect(page).to have_content(question.title)
  end

  scenario 'user visits index page with multiple items, views in order' do
    attrs1 = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    attrs2 = {
      title: "Another Question - How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question1 = Question.create(attrs1)
    question2 = Question.create(attrs2)

    visit questions_path
    expect(page).to have_content(question1.title)
    expect(page).to have_content(question2.title)
    question2.title.should appear_before(question1.title)
  end


end
