Feature: Command Repetition
    A user wants to use the generated shell to repeat previously executed commands

    Scenario Outline: Command Execution
        A user wants to use the generated shell to repeat previously executed commands        

        Given A user wants to use the generated shell to repeat previously executed commands        
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<shell_technology>" technology
        And Navigates to the feature selection screen
        And Navigates to the output selection screen
        And Navigates to the client selection screen
        And Selects the "<client_technology>" client technology
        And Downloads the shell and the client
        And Uploads the shell to a server
        Then He can use the client to execute the repeat the previously executed "<command>" command

        Examples:

            | shell_technology | client_technology | command |
            | php | python | id |
            | php | python | whoami |

