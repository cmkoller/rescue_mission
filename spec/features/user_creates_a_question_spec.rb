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
    # title = "How do I do this crazy complicated thing??"
    # description = "Here's a pretty long description of my question.
    # Here's a pretty long description of my question.
    # Here's a pretty long description of my question. "
    question = FactoryGirl.build(:question)

    visit new_question_path
    fill_in "Title", with: question.title
    fill_in "Description", with: question.description
    click_on "Create Question"
    expect(page).to have_content("Question created.")
    expect(page).to have_content(question.title)
    expect(page).to have_content(question.description)
  end

  scenario 'user posts a question with too-short title' do
    question = FactoryGirl.build(:question)
    question.title = "Short Title"

    visit new_question_path
    fill_in "Title", with: question.title
    fill_in "Description", with: question.description
    click_on "Create Question"
    expect(page).to have_content("Title is too short")
    expect(find_field("Title").value).to eq question.title
    expect(find_field("Description").value).to eq question.description
  end

  scenario 'user posts a question with too-long title' do
    question = FactoryGirl.build(:question)

    question.title *= 8

    visit new_question_path
    fill_in "Title", with: question.title
    fill_in "Description", with: question.description
    click_on "Create Question"
    expect(page).to have_content("Title is too long")
    expect(find_field("Title").value).to eq question.title
    expect(find_field("Description").value).to eq question.description
  end

  scenario 'user posts a question with too-short description' do
    question = FactoryGirl.build(:question)

    question.description = "Short description"

    visit new_question_path
    fill_in "Title", with: question.title
    fill_in "Description", with: question.description
    click_on "Create Question"
    expect(page).to have_content("Description is too short")
    expect(find_field("Title").value).to eq question.title
    expect(find_field("Description").value).to eq question.description
  end

end
