Feature: Configure shell features 
    A user wants to configure the buil-in features for the Web Shell

    Scenario Outline: Configure shell features
        A user wants to configure the buil-in features for the Web Shell
        
        Given A user wants to configure the shell features 
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<technology>" technology
        And Navigates to the next screen
        Then He is presented with the "<feature>" feature

        Examples:

            | technology | feature |
            | php | Command Execution |
            | php | Identify Execution Alternatives |
            | php | File Upload |
            | php | Replay protection |
            | php | Allowed IPs|

