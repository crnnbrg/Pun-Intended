require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('adding a new pun', {:type => :feature}) do
  it('allows a user to add a new pun') do
    visit('/')
    fill_in('pun_body', :with =>'Frank says put this in your pipe and smoke it')
    fill_in('user_name', :with =>'Frank Sinatra')
    click_button('Submit')
    expect(page).to have_content('Frank says put this in your pipe and smoke it')
  end
end
