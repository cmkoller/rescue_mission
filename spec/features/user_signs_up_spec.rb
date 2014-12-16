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
    expect(page).to_not have_link "Sign Up"
    expect(page).to have_link "Sign Out"
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

  scenario "email is already registered" do
    existing_user = User.create(
    first_name: "Joe",
    last_name: "Schmoe",
    email: "email@email.com",
    password: "passwordsecret"
    )

    visit root_path
    click_on "Sign Up"

    fill_in "First Name", with: existing_user.first_name
    fill_in "Last Name", with: existing_user.last_name
    fill_in "Email", with: existing_user.email
    fill_in "Password", with: existing_user.password
    fill_in "Password confirmation", with: existing_user.password
    click_on "Sign up"

    expect(page).to have_content "Email has already been taken"
  end

  scenario "improperly formatted email" do
    visit root_path
    click_on "Sign Up"

    fill_in "First Name", with: "Joe"
    fill_in "Last Name", with: "Shmoe"
    fill_in "Email", with: "email.com"
    fill_in "Password", with: "supersecret"
    fill_in "Password confirmation", with: "different"
    click_on "Sign up"

    expect(page).to have_content "Email is invalid"
  end

end
