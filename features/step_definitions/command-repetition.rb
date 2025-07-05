require 'open-uri'

Given('A user wants to use the generated shell to repeat previously executed commands') do
  # Get a WebDriver instance
  @driver = Selenium::WebDriver.for :firefox
end

Then('He can use the client to execute the repeat the previously executed {string} command') do |command|
  # Execute the command and get the expected output
  expected_output = `#{command}`

  # Create a pipe to communicate with the child process
  read, write = IO.pipe

  client_pid = fork do
    # Create a pipe to communicate with the client
    client = IO.popen('python downloads/client.py --url http://localhost:1234/downloads/shell.php', 'r+')

    # Send the command and discard the output
    client.puts command
    client.gets
    client.gets

    # Repeat the command
    client.puts "!#{command}"
    received_output = client.gets
    puts client.gets

    # Return the result
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

  # Expect the command to be executed
  expect(received_output).to include(expected_output)

  # Close spawned processes
  Process.kill(:KILL, @server_pid)

  # Remove temp files and directory
  File.unlink('.webshell_history')
  File.unlink('./downloads/shell.php')
  File.unlink('./downloads/client.py')
  Dir.rmdir('./downloads')
end
