Given('A user wants to be able to delete shell history from the generated web shell') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

Then('He can use the client to delete command history') do
  client_pid = fork do
    # Create a pipe to communicate with the client
    client = IO.popen('python downloads/client.py --url http://localhost:1234/downloads/shell.php', 'r+')

    # Run a command and ignore the output
    client.puts 'whoami'
    client.gets
    client.gets

    # Delete the command history
    client.puts '!delete'
    client.gets

    # Close the client
    client.puts 'exit'
    client.close
  end

  Process.wait(client_pid)

  # Expect the command history to include the command
  expect(File.exist?('.webshell_history')).to be_falsy

  # Close spawned processes
  Process.kill(:KILL, @server_pid)

  # Remove temp files and directory
  File.unlink('./downloads/shell.php')
  File.unlink('./downloads/client.py')
  Dir.rmdir('./downloads')
end
