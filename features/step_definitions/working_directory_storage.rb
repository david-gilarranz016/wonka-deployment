Given('A user wants the generated shell to remember the working directory') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

Then('He can use the client to change to the {string} and run commands') do |directory|
  # Create a pipe to communicate with the child process
  read, write = IO.pipe

  client_pid = fork do
    # Create a pipe to communicate with the client
    client = IO.popen('python downloads/client.py --url http://localhost:1234/downloads/shell.php', 'r+')

    # Change to the specified directory and ignore the output
    client.puts "cd #{directory}"
    client.gets

    # Run a pwd command to get the changed working directory
    client.puts 'pwd'

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

  # Expect the client to have changed to the directory
  expect(received_output).to include(directory)

  # Close spawned processes
  Process.kill(:KILL, @server_pid)

  # Remove temp files and directory
  File.unlink('.webshell_history')
  File.unlink('./downloads/shell.php')
  File.unlink('./downloads/client.py')
  Dir.rmdir('./downloads')
end
