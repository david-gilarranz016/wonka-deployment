Feature: File Upload
    A user wants to use the generated shell to upload files to the server

    Scenario Outline: File Upload
        A user wants to use the generated shell to upload files to the server        

        Given A user wants to use the generated shell to upload files to the server        
        When The user accesses the front-end
        And Navigates to the Shell selection screen
        And Selects the "<shell_technology>" technology
        And Navigates to the feature selection screen
        And Selects the File Upload feature
        And Navigates to the output selection screen
        And Navigates to the client selection screen
        And Selects the "<client_technology>" client technology
        And Downloads the shell and the client
        And Uploads the shell to a server
        Then He can use the client to upload files

        Examples:

            | shell_technology | client_technology |
            | php | python |

