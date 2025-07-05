Feature: Configure client technology
    A user wants to configure the technology for the generated client

    Scenario Outline: Configure client technology
        A user wants to configure the technology for the generated client
        
        Given A user wants to configure the client technology
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<shell_technology>" technology
        And Navigates to the feature selection screen
        And Navigates to the output selection screen
        And Navigates to the client selection screen
        Then He is presented with the "<client_technology>" client technology

        Examples:

            | shell_technology | client_technology |
            | php | python |

