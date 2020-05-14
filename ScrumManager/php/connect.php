<?php

    $server_name = "localhost";
    $user_name = "root";
    $password = "password";
    $database = "scrum_manager";
    
    // Create connection.
    $connection = new mysqli($server_name, $user_name, $password, $database);
    
    // Check connection
    if ($connection -> connect_error) {
        //echo "Connection failed\n";
    } else {
        //echo "Connected to DB successfully...\n";
    }

?>
