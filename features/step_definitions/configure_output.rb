Given("A user wants to configure the shell's output format") do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

When('Navigates to the output selection screen') do
  # Select the command execution feature and navigate to the next screen
  @driver.find_element(xpath: '//*/button[contains(text(), "Command Execution")]').click
  @driver.find_element(xpath: '//*/button[@id="navigation-button"]').click
  sleep 1
end

Then('He is presented with the {string} output option') do |option|
  # Search for a button with the feature as content
  button = @driver.find_element(xpath: "//*/div/*[contains(text(), '#{option}')]")

  # Expect the feature to be present
  expect(button.nil?).to be_falsy

  @driver.close
end

