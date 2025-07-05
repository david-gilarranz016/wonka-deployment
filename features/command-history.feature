Feature: Command History
    A user wants to generated shell to remember previous commands

    Scenario Outline: Command History
        A user wants to generated shell to remember previous commands
        
        Given A user wants to generated shell to remember previous commands
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<shell_technology>" technology
        And Navigates to the feature selection screen
        And Navigates to the output selection screen
        And Navigates to the client selection screen
        And Selects the "<client_technology>" client technology
        And Downloads the shell and the client
        And Uploads the shell to a server
        Then He can use the client to execute the "<command>" command and store it in the history

        Examples:

            | shell_technology | client_technology | command |
            | php | python | id |
            | php | python | whoami |
