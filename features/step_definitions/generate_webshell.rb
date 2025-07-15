Given("A user wants to download the generated web shell") do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

When("Selects the {string} client technology") do |client|
  # Select the python technology and navigate to the next screen
  @driver.find_element(xpath: "//*/button[contains(text(), '#{client}')]").click
  @driver.find_element(xpath: '//*/button[@id="navigation-button"]').click
  sleep 1
end

Then('He is presented with the {string} shell download link') do |technology|
  # Search for a link with the technology as extension
  link = @driver.find_element(xpath: "//*/a[contains(text(), '.#{technology}')]")

  # Expect the feature to be present
  expect(link.nil?).to be_falsy

  @driver.close
end
