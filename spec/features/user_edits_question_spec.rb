require "rails_helper"

feature "Edit Question", %q(
As a user
I want to edit a question
So that I can correct any mistakes or add updates

Acceptance Criteria

- I must provide valid information
- I must be presented with errors if I fill out the form incorrectly
- I must be able to get to the edit page from the question details page
) do

  scenario 'user navigates to edit page from question page' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)

    visit question_path(question.id)
    click_on "Edit"
    expect(find_field("Title").value).to have_content(question.title)
    expect(find_field("Description").value).to have_content(question.description)
    expect(page).to have_button("Update Question")
  end

  scenario 'user successfully edits question' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)

    new_title = "Here's a brand new question title that's definitely
    way better."
    new_description = "New description, New description,
    New description, New description, New description, New description,
    New description, New description, New description, New description"

    visit question_path(question.id)

    click_on "Edit"
    fill_in "Title:", with: new_title
    fill_in "Description", with: new_description
    click_on "Update Question"

    expect(page).to have_content(new_title)
    expect(page).to have_content(new_description)
    expect(page).to have_content("Question Updated")
  end

  scenario 'user unsuccessfully edits question - title too short' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)

    new_title = "New short title"
    new_description = "New description, New description,New description, New description, New description, New description, New description, New description, New description, New description"

    visit question_path(question.id)

    click_on "Edit"
    fill_in "Title:", with: new_title
    fill_in "Description", with: new_description
    click_on "Update Question"

    expect(find_field("Title").value).to eq new_title
    expect(find_field("Description").value).to eq new_description
    expect(page).to have_content("Title is too short")
  end

  scenario 'user unsuccessfully edits question - description too short' do
    attrs = {
      title: "How do I do this crazy complicated thing??",
      description: "Here's a pretty long description of my question.
      Here's a pretty long description of my question.
      Here's a pretty long description of my question. "
    }
    question = Question.create(attrs)

    new_title = "Here's a brand new question title that's definitely
    way better."
    new_description = "New short description"

    visit question_path(question.id)

    click_on "Edit"
    fill_in "Title:", with: new_title
    fill_in "Description", with: new_description
    click_on "Update Question"

    expect(find_field("Title").value).to eq new_title
    expect(find_field("Description").value).to eq new_description
    expect(page).to have_content("Description is too short")
  end


end
