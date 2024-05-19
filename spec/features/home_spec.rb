require "rails_helper"

describe "home page", type: :feature do
  it "renders successfully" do
    visit "/"

    expect(page).to have_content "Welcome to Lightning Rails 🚆"
  end
end
