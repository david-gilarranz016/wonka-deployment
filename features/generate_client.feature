Feature: RF-6 Generate Client
    A user wants to download the generated web shell client

    Scenario Outline: Generate Client
        A user wants to download the generated web shell client
        
        Given A user wants to download the generated web shell client
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<shell_technology>" technology
        And Navigates to the feature selection screen
        And Navigates to the output selection screen
        And Navigates to the client selection screen
        And Selects the "<client_technology>" client technology
        Then He is presented with the "<link>" client download link

        Examples:

            | shell_technology | client_technology | link |
            | php | python | .py |

