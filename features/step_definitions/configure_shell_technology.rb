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

When('Navigates to the Shell selection screen') do
  @driver.find_element(xpath: '//button[@class="btn"]').click
end

Then('He is presented with the {string} option') do |string|
  button = @driver.find_element(xpath: "//*/button[contains(text(), '#{string}')]")
  pp button.text

  expect(button.nil?).to be_falsy

  @driver.close
end
