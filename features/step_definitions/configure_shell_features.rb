require 'rubygems'
require 'selenium-webdriver'

Given('A user wants to configure the shell features') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

# When the user navigates to the front-end -> already implemented
# And navigates to the shell selection screen -> already implemented

And('Selects the {string} technology') do |technology|
  # Search for a button with the technology as content and click it
  @driver.find_element(xpath: "//*/button[contains(text(), '#{technology}')]").click
end

And('Navigates to the feature selection screen') do
  # Look for the navigation button and press it
  @driver.find_element(xpath: '//*/button[@id="navigation-button"]').click
end

Then('He is presented with the {string} feature') do |feature|
  # Search for a button with the feature as content
  button = @driver.find_element(xpath: "//*/div/*[contains(text(), '#{feature}')]")

  # Expect the feature to be present
  expect(button.nil?).to be_falsy

  @driver.close
end
