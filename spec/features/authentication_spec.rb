require 'rails_helper'
feature 'authentication' do
  before do
    @user = create(:user)
  end
  feature "user sign-in" do
    scenario 'visits sign-in page' do
      visit '/sessions/new'
      expect(page).to have_field('email')
      expect(page).to have_field('password')
    end
    scenario 'logs in user if email/password combination is valid' do
      visit '/sessions/new'
      fill_in "email", with: "oscar@gmail.com"
      fill_in "password", with: "password"
      click_button "submit"
      expect(current_path).to eq("/users/#{@user.id}")
      expect(page).to have_text(@user.name)
    end
    scenario 'does not sign in user if email is not found' do
        visit '/sessions/new'
        fill_in "email", with: "osca@gmail.com"
        fill_in "password", with: "password"
        click_button "submit"
      expect(current_path).to eq("/sessions/new")
      expect(page).to have_text('Invalid Combination')
    end    
    scenario 'does not sign in user if email/password combination is invalid' do
        visit '/sessions/new'
        fill_in "email", with: "oscar@gmail.com"
        fill_in "password", with: "passwo"
        click_button "submit"
      expect(current_path).to eq("/sessions/new")      
      expect(page).to have_text('Invalid Combination')
    end
  end
  feature "user to log out" do
    before do 
        visit '/sessions/new'
        fill_in "email", with: "oscar@gmail.com"
        fill_in "password", with: "password"
        click_button "submit"
    end
    scenario 'displays "Log Out" button when user is logged on' do
        page.should have_selector(:link_or_button, 'Log Out')
    end
    scenario 'logs out user and redirects to login page' do
      click_link_or_button 'Log Out'
      expect(current_path).to eq('/sessions/new')
    end
  end
end