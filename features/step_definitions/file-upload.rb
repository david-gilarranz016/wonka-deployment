Given('A user wants to use the generated shell to upload files to the server') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

And('Selects the File Upload feature') do
  # Select the file upload feature
  @driver.find_element(xpath: '//*/button[contains(text(), "File Upload")]').click
end

Then('He can use the client to upload files') do
  # Move the client to a different directory
  `mv downloads/client.py .`

  # Create a test file
  File.open('test.txt', 'w') { |f| f.puts 'Test' }

  client_pid = fork do
    # Create a pipe to communicate with the client
    client = IO.popen('python client.py --url http://localhost:1234/downloads/shell.php', 'r+')

    # Upload the file to the server
    client.puts '!put test.txt'
    client.gets

    # Close the client
    client.puts 'exit'
    client.close
  end

  Process.wait(client_pid)

  # Expect the file to have been uploaded
  expect(File.read('./downloads/test.txt')).to eq(File.read('./test.txt'))

  # Close spawned processes
  Process.kill(:KILL, @server_pid)

  # Remove temp files and directory
  File.unlink('./downloads/shell.php')
  File.unlink('./downloads/test.txt')
  Dir.rmdir('./downloads')
  File.unlink('test.txt')
  File.unlink('client.py')
end
