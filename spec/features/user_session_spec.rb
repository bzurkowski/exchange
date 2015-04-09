feature "Session" do
  scenario "User signs up" do
    visit root_path
    click_on "Rejestracja"

    fill_in "Login",         with: "testJohn"
    fill_in "Email",         with: "john@test.com"
    fill_in "Numer albumu",  with: "255550"
    fill_in "Hasło",         with: "so-secure56"
    fill_in "Powtórz hasło", with: "so-secure56"

    click_on "Zarejestruj"

    expect(page).to have_content "Wiadomość email z instrukcją aktywacji konta została przesłana na Twój adres email."
    expect(ActionMailer::Base.deliveries.size).to eq 1

    ctoken = ActionMailer::Base.deliveries[0].body.match(/confirmation_token=\w*/)
    visit "/users/confirmation?#{ctoken}"

    expect(current_path).to eq new_user_session_path

    fill_in "Email", with: "john@test.com"
    fill_in "Hasło", with: "so-secure56"
    click_on "Zaloguj"

    expect(page).to have_content "Zostałeś zalogowany."
  end
end
