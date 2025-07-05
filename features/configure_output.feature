Feature: Configure output format
    A user wants to configure the generated shell's output format

    Scenario Outline: Configure output format
        A user wants to configure the generated shell's output format
        
        Given A user wants to configure the shell's output format
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<technology>" technology
        And Navigates to the feature selection screen
        And Navigates to the output selection screen
        Then He is presented with the "<option>" output option

        Examples:

            | technology | option |
            | php | PHP |
            | php | PNG |
            | php | JPG |
            | php | GIF |
            | php | Obfuscate code |

