Given('A user wants to configure the client technology') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

When('Navigates to the client selection screen') do
  # Select an output format
  @driver.find_element(xpath: '//*/button[contains(text(), "PHP")]').click
  @driver.find_element(xpath: '//*/button[@id="navigation-button"]').click
end

Then('He is presented with the {string} client technology') do |technology|
  # Search for a button with the feature as content
  button = @driver.find_element(xpath: "//*/button[contains(text(), '#{technology}')]")

  # Expect the feature to be present
  expect(button.nil?).to be_falsy

  @driver.close
end
