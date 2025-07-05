Given('A user wants to generated shell to remember previous commands') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

Then('He can use the client to execute the {string} command and store it in the history') do |command|
  client_pid = fork do
    # Create a pipe to communicate with the client
    client = IO.popen('python downloads/client.py --url http://localhost:1234/downloads/shell.php', 'r+')

    # Send the command and ignore its output
    client.puts command
    client.gets

    # Close the client
    client.puts 'exit'
    client.close
  end

  Process.wait(client_pid)

  # Expect the command history to include the command
  expect(File.read('.webshell_history')).to include(command)

  # Close spawned processes
  Process.kill(:KILL, @server_pid)

  # Remove temp files and directory
  File.unlink('.webshell_history')
  File.unlink('./downloads/shell.php')
  File.unlink('./downloads/client.py')
  Dir.rmdir('./downloads')
end
