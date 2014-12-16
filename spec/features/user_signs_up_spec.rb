require "rails_helper"

feature "User Signs Up", %q(
As a user
I want to sign in
So that my questions and answers can be associated to me

Acceptance Criteria

- I must be able to sign in using either GitHub, Twitter, or Facebook (choose
one)
) do

  scenario "user provides valid information" do
    visit root_path
    click_on "Sign Up"

    fill_in "First Name", with: "Joe"
    fill_in "Last Name", with: "Shmoe"
    fill_in "Email", with: "name@email.com"
    fill_in "Password", with: "supersecret"
    fill_in "Password confirmation", with: "supersecret"
    click_on "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "password fields do not match" do
    visit root_path
    click_on "Sign Up"

    fill_in "First Name", with: "Joe"
    fill_in "Last Name", with: "Shmoe"
    fill_in "Email", with: "name@email.com"
    fill_in "Password", with: "supersecret"
    fill_in "Password confirmation", with: "different"
    click_on "Sign up"

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

end
