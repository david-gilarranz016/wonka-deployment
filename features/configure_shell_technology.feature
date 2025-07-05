Feature: Configure shell technology
    A user wants to configure the target technology for the Web Shell

    Scenario Outline: Configure shell technology
        A user wants to configure the target technology for the Web Shell
        
        Given A user wants to configure the shell technology
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        Then He is presented with the "<technology>" shell technology 

        Examples:

            | technology |
            | php |

