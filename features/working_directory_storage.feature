Feature: RF-8 Working Directory Storage
    A user wants the generated shell to remember the working directory

    Scenario Outline: Working Directory Storage
        A user wants the generated shell to remember the working directory
        
        Given A user wants the generated shell to remember the working directory
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<shell_technology>" technology
        And Navigates to the feature selection screen
        And Navigates to the output selection screen
        And Navigates to the client selection screen
        And Selects the "<client_technology>" client technology
        And Downloads the shell and the client
        And Uploads the shell to a server
        Then He can use the client to change to the "<directory>" and run commands

        Examples:

            | shell_technology | client_technology | directory |
            | php | python | / |
            | php | python | /home |

