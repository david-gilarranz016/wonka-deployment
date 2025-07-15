Feature: RF-11 History Deletion
    A user wants to be able to delete shell history from the generated web shell

    Scenario Outline: History Deletion
        A user wants to be able to delete shell history from the generated web shell

        Given A user wants to be able to delete shell history from the generated web shell
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<shell_technology>" technology
        And Navigates to the feature selection screen
        And Navigates to the output selection screen
        And Navigates to the client selection screen
        And Selects the "<client_technology>" client technology
        And Downloads the shell and the client
        And Uploads the shell to a server
        Then He can use the client to delete command history

        Examples:

            | shell_technology | client_technology |
            | php | python |

