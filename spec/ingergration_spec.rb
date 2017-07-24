require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('showing the landing page', {:type => :feature}) do
  it"shows the landing page on opening the website" do
    visit('/')
    expect(page).to have_content('index')
  end
end
