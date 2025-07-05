Given("A user wants to download the generated web shell client") do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

Then('He is presented with the {string} client download link') do |extension|
  # Search for a link with the technology as extension
  link = @driver.find_element(xpath: "//*/a[contains(text(), '#{extension}')]")

  # Expect the feature to be present
  expect(link.nil?).to be_falsy

  @driver.close
end
