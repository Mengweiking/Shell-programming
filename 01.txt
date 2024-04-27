#!/bin/bash

while true; do
    # Step 1: Prompt the user to enter some text
    echo "Please enter a message (press 'q' to quit):"

    # Step 2: Read the input from the user
    read user_input

    # Step 3: Greet the user with their entered text or break the loop if 'q' is entered
    if [[ "$user_input" == "q" ]]; then
        echo "Exiting the script in 2 seconds..."
        sleep 2
        break
    else
        echo "You entered: $user_input"
    fi
done

# End of script