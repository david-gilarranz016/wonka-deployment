Given('A user wants to use the generated shell to extract files from the server') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

And('Selects the File Download feature') do
  # Select the file upload feature
  @driver.find_element(xpath: '//*/button[contains(text(), "File Download")]').click
end

Then('He can use the client to download files') do
  # Move the client to a different directory
  `mv downloads/client.py .`

  # Create a test file in the server
  File.open('downloads/test.txt', 'w') { |f| f.puts 'Test' }

  client_pid = fork do
    # Create a pipe to communicate with the client
    client = IO.popen('python client.py --url http://localhost:1234/downloads/shell.php', 'r+')

    # Upload the file to the server
    client.puts '!get test.txt'
    client.gets

    # Close the client
    client.puts 'exit'
    client.close
  end

  Process.wait(client_pid)

  # Expect the file to have been downloaded
  expect(File.read('test.txt')).to eq(File.read('./downloads/test.txt'))

  # Close spawned processes
  Process.kill(:KILL, @server_pid)

  # Remove temp files and directory
  File.unlink('./downloads/shell.php')
  File.unlink('./downloads/test.txt')
  Dir.rmdir('./downloads')
  File.unlink('test.txt')
  File.unlink('client.py')
end
