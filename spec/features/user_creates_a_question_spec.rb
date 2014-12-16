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

  scenario 'user posts a question' do
    title = "How do I do this crazy complicated thing??"
    description = "Here's a pretty long description of my question.
    Here's a pretty long description of my question.
    Here's a pretty long description of my question. "

    visit new_question_path
    fill_in "Title", with: title
    fill_in "Description", with: description
    click_on "Create Question"
    expect(page).to have_content("Question created.")
    expect(page).to have_content(title)
    expect(page).to have_content(description)
  end

  scenario 'user posts a question with too-short title' do
    title = "Short Title"
    description = "Here's a pretty long description of my question. Here's a pretty long description of my question. Here's a pretty long description of my question. "

    visit new_question_path
    fill_in "Title", with: title
    fill_in "Description", with: description
    click_on "Create Question"
    expect(page).to have_content("Title is too short")
    expect(find_field("Title").value).to eq title
    expect(find_field("Description").value).to eq description
  end

  scenario 'user posts a question with too-long title' do
    title = "Looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
    oooooooooooooooooooooooooooong loooooooooooooooooooooooooooooooooooooooooooo
    ooooooooooooooooooooooooooooooooooooooooooooooong looooooooooooooooooooooooo
    oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong title"
    description = "Here's a pretty long description of my question. Here's a pretty long description of my question. Here's a pretty long description of my question. "

    visit new_question_path
    fill_in "Title", with: title
    fill_in "Description", with: description
    click_on "Create Question"
    expect(page).to have_content("Title is too long")
    expect(find_field("Title").value).to eq title
    expect(find_field("Description").value).to eq description
  end

  scenario 'user posts a question with too-short description' do
    title = "How do I do this crazy complicated thing??"
    description = "Short description"

    visit new_question_path
    fill_in "Title", with: title
    fill_in "Description", with: description
    click_on "Create Question"
    expect(page).to have_content("Description is too short")
    expect(find_field("Title").value).to eq title
    expect(find_field("Description").value).to eq description
  end


end
