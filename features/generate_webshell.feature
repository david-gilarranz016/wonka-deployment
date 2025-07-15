Feature: RF-5 Generate WebShell
    A user wants to download the generated web shell

    Scenario Outline: Generate WebShell
        A user wants to download the generated web shell
        
        Given A user wants to download the generated web shell
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<shell_technology>" technology
        And Navigates to the feature selection screen
        And Navigates to the output selection screen
        And Navigates to the client selection screen
        And Selects the "<client_technology>" client technology
        Then He is presented with the "<shell_technology>" shell download link

        Examples:

            | shell_technology | client_technology |
            | php | python |

