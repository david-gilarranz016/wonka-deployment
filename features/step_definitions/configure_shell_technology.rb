require 'rubygems'
require 'selenium-webdriver'

Given('A user wants to configure the shell technology') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

When('The user accesses the front-end') do
  # Navigate to the front end
  @driver.get('http://localhost:8081/')
end

And('Navigates to the Shell selection screen') do
  @driver.find_element(xpath: '//button[@class="btn"]').click
  sleep 1
end

Then('He is presented with the {string} shell technology') do |technology|
  # Search for a button with the technology as content
  button = @driver.find_element(xpath: "//*/button[contains(text(), '#{technology}')]")

  # Expect the button to exist
  expect(button.nil?).to be_falsy

  @driver.close
end
