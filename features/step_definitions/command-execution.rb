require 'open-uri'

Given('A user wants to use the generated shell to execute commands') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

When('Downloads the shell and the client') do
  # Create a temporary directory for the downloads
  Dir.mkdir('downloads')

  # Get the shell download link
  shell_link = @driver.find_element(xpath: '//*/div[h2[contains(text(), "Web Shell")]]//a[contains(text(), "/api/output")]').text()
  download = URI.open(shell_link)
  IO.copy_stream(download, './downloads/shell.php')

  # Get the client and download link
  client_link = @driver.find_element(xpath: '//*/div[h2[contains(text(), "Client")]]//a[contains(text(), "/api/output")]').text()
  download = URI.open(client_link)
  IO.copy_stream(download, './downloads/client.py')

  # Close the driver
  @driver.close
end

When('Uploads the shell to a server') do
  # Start a server on the downloads folder to serve the web-shell
  @server_pid = spawn('php -S 127.0.0.1:1234')
end

Then('He can use the client to execute the {string} command') do |command|
  # Execute the command and get the expected output
  expected_output = `#{command}`

  # Create a pipe to communicate with the child process
  read, write = IO.pipe

  client_pid = fork do
    # Create a pipe to communicate with the client
    client = IO.popen('python downloads/client.py --url http://localhost:1234/downloads/shell.php', 'r+')

    # Send the command
    client.puts command

    # Read the result
    received_output = client.gets
    write.puts received_output
    write.close

    # Close the client
    client.puts 'exit'
    client.close
  end

  # Read the output
  received_output = read.gets
  read.close

  Process.wait(client_pid)

  expect(received_output).to include(expected_output)

  # Close spawned processes
  Process.kill(:KILL, @server_pid)

  # Remove temp files and directory
  File.unlink('./downloads/shell.php')
  File.unlink('./downloads/client.py')
  Dir.rmdir('./downloads')
end
