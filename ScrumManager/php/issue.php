<!-- <!DOCTYPE html> -->
<html lang="en">
    <head>
        <title>issue</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

       
        <link rel="stylesheet" type="text/css" href="../css/issue.css" />
        <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">
    </head>
    
    <?php
        include ('connect.php');
        include ('navigation.php');
    
        $_SERVER['QUERY_STRING'];
        //echo $_GET['a'];

        $selected_id = $_GET['a'];
    
        //Get number of fields in database.
        $sql1 = "SELECT count(*) FROM information_schema.columns WHERE table_name = 'issue'";
        $result1 = mysqli_query($connection, $sql1);
        $row1 = mysqli_fetch_row($result1);
        $count = $row1[0];
        //echo $count;
    
        //Get all the fields in issue table.
        $sql = "SELECT * FROM ase.issue where issue.idIssue=$selected_id";
        $result = mysqli_query($connection, $sql);
        $row = mysqli_fetch_row($result);
    
        $issue_id = $row[0];
        $issue_title = $row[1];
        $issue_description = $row[2];
        $issue_type = $row[3];
        $issue_priority = $row[4];
        //$issue_date_created = $row[5];
        $issue_org_estimate = $row[6];
        $issue_resolution = $row[7];
        $issue_status_id = $row[8];
        //$issue_user_story_id = $row[9];
        $issue_assignee_id = $row[10];
        $issue_reporter_id = $row[11];
        $issue_actual_estimate = $row[12];
        $issue_comment = $row[13];
        $issue_sprint = $row[14];
    
        //Get issue status
        $sql2 = "SELECT status.Name from ase.status,ase.issue where issue.idIssue=$selected_id and issue.Status_idStatus=status.idStatus";
        $result2 = mysqli_query($connection, $sql2);
        $row2 = mysqli_fetch_row($result2);
        $issue_status = $row2[0];
    
        //Get Assignee name
        $sql3 = "SELECT user.userName from ase.user,ase.issue where issue.idIssue=$selected_id and issue.User_idAssignee=user.idUser";
        $result3 = mysqli_query($connection, $sql3);
        $row3 = mysqli_fetch_row($result3);
        $issue_assignee = $row3[0];
    
        //Get Reporter name
        $sql4 = "SELECT user.userName from ase.user,ase.issue where issue.idIssue=$selected_id and issue.User_idReporter=user.idUser";
        $result4 = mysqli_query($connection, $sql4);
        $row4 = mysqli_fetch_row($result4);
        $issue_reporter = $row4[0];
    
        //Debug
        // echo " issue id:    ".$issue_id;
        // echo " issue_title: ".$issue_title;
        // echo " issue_description:   ".$issue_description;
        // echo " issue_type:  ".$issue_type;
        // echo " issue_priority:  ".$issue_priority;
        // echo " issue_org_estimate:  ".$issue_org_estimate;
        // echo " issue_resolution: ".$issue_resolution;
        // echo " issue_status_id: ".$issue_status;
        // echo " issue_assignee_id:   ".$issue_assignee;
        // echo " issue_reporter_id:   ".$issue_reporter;
        // echo " issue_actual_estimate:  ".$issue_actual_estimate;
    ?>
    
    <body>    
        <form action="" method="post">
        <div class="issue_title_div" align="left">
            <table>
                <tr>
                    <td valign="top"><img src="../images/issue_task.png" class="issue_icon"/></td>
                    <th >
                        <label style="font-size: 30px" class="issue_title" contenteditable="false"><?php echo $selected_id." : "?></label>
                    </th>
                    <th >
                        <input style="font-size: 30px" type="text" class="issue_title" name="issue_title" value="<?php echo $issue_title; ?>">
                        <!-- <label for="issue_title" name="issue_title" contenteditable="true"><h2> <?php echo $selected_id." : ".$issue_title; ?></h2></label> -->
                    </th>
                </tr>
            </table>
        </div>

        <!-- Issue information div -->
        <div class="issue_container_div">
            

            <!-- Issue information table -->
            <table class="issue_container_table">
                <!-- Issue information row 1 for Edit/Comment buttons -->
                <tr class="issue_row1">
                    <td class="issue_column1" align="right">
                        <!-- <button type="button" class="issue_button_edit"></button>
                        <button type="button" class="issue_button_comment"></button> -->
                    </td>
                    <td class="issue_column2" align="right">
                        <button type="submit" class="issue_button_save" name="submit"></button>
                        <!-- Keep empty for now -->
                    </td>
                </tr>

                <!-- Empty row to add space -->
                <tr></tr>

                <!-- Issue information row 2 for heading Details & People -->
                <tr class="issue_row2">
                    <th class="issue_column1" align="left" class="issue_detail">
                        <label for="issue_description">Details:</label>
                    </th>
                    <th class="issue_column2" align="left">
                        <label for="issue_description">People:</label>
                    </th>
                </tr>

                <!-- Issue information row 3 for Details & People data-->
                <tr class="issue_row3">
                    <td class="issue_column1" align="left">
                        <table>
                            <td class="detail_column1">
                                <table>
                                    <tr>
                                        <td >
                                            <label for="issue_type" >Type:</label>
                                        </td>
                                        <td align="left" class="issue_detail_inner_column2">
                                            <select id="issue_type" name="issue_type" class="select_left" > 
                                                <?php echo "<option value=$issue_type>$issue_type</option>"?>
                                                <option value="Bug">Bug</option>                                               
                                                <option value="Feature">Feature</option>
                                                <option value="Query">Query</option>
                                                <option value="Documentation">Documentation</option>
                                                <option value="Feasibility">Feasibility</option>
                                                <option value="Task">Task</option>
                                            </select>
                                            <!-- <label for="issue_type">Task</label> -->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            <label for="issue_type">Priority:</label>
                                        </td>
                                        <td align="left" class="issue_detail_inner_column2">
                                            <!-- <label for="issue_type">High</label> -->
                                            <select id="issue_priority" name="issue_priority" class="select_left"> 
                                                <?php echo "<option value=$issue_priority>$issue_priority</option>"?>
                                                <option value="Low">Low</option>
                                                <option value="Medium">Medium</option>
                                                <option value="Critical">Critical</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </td>

                            <td class="detail_column2" align="left">
                                <table>
                                    <tr>
                                        <td>
                                            <label for="issue_type" align="left">Status:</label>
                                        </td>
                                        <td align="left" class="issue_detail_inner_column2">
                                            <!-- <label for="issue_type">New</label> -->
                                            <select id="issue_status" name="issue_status" class="select_left"> 
                                                
                                                <?php echo "<option value=$issue_status>$issue_status</option>"?>
                                                <?php $sql = "select status.Name from ase.status";
                                                    $result = mysqli_query($connection, $sql);
                                                    if (!$result) {
                                                        echo "<option value='empty'>null</option>";
                                                    } else {
                                                        while ($row = mysqli_fetch_row($result)) {

                                                            echo "<option value=$row[0]>$row[0]</option>";
                                                        }
                                                        mysqli_free_result($result);
                                                    }
										        ?>
                                               
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <label for="issue_type">Resolution:</label>
                                        </td>
                                        <td align="left" class="issue_detail_inner_column2"> 
                                            <!-- <label for="issue_type">Unresolved</label> -->
                                            <select id="issue_resolution" name="issue_resolution" class="select_left"> 
                                                <?php echo "<option value=$issue_resolution>$issue_resolution</option>"?>
                                                <option value="Unresolved">Unresolved</option>
                                                <option value="Resolved">Resolved</option>
                                                <option value="Not fixable">Not fixable</option>
                                                <option value="Hold">Hold</option>                                              
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </table>
                    </td>

                    <td class="issue_column2" align="left">
                        <table>
                            <tr>
                                <td issue_detail_inner_column1>
                                    <label for="issue_type" >Assignee:</label>
                                </td>
                                <td align="left" class="issue_detail_inner_column2">
                                    <!-- <label for="issue_type">Anju K. James</label> -->
                                    <select id="issue_assignee" name="issue_assignee" class="select_right">
                                        
                                        <?php echo "<option value=$issue_assignee>$issue_assignee</option>"?>
                                        <?php $sql = "SELECT user.userName FROM ase.user";
                                        $result = mysqli_query($connection, $sql);
                                        if (!$result) {
                                            echo "<option value='empty'>null</option>";
                                        } else {
                                            while ($row = mysqli_fetch_row($result)) {

                                                echo "<option value=$row[0]>$row[0]</option>";
                                            }
                                            mysqli_free_result($result);
                                        }
                                        ?>
                                                                                
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td issue_detail_inner_column1>
                                    <label for="issue_type">Reporter:</label>
                                </td>
                                <td align="left" class="issue_detail_inner_column2">
                                    <!-- <label for="issue_type">Nicole Price</label> -->
                                    <select id="issue_reporter" name="issue_reporter" class="select_right">
                                        
                                        <?php echo "<option value=$issue_reporter>$issue_reporter</option>"?>                                                                            
                                        <?php $sql = "SELECT user.userName FROM ase.user";
                                        $result = mysqli_query($connection, $sql);
                                        if (!$result) {
                                            echo "<option value='empty'>null</option>";
                                        } else {
                                            while ($row = mysqli_fetch_row($result)) {

                                                echo "<option value=$row[0]>$row[0]</option>";
                                            }
                                            mysqli_free_result($result);
                                        }
                                        ?>
                                        
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                <tr></tr>
                
                <tr class="issue_row4">
                    <th class="issue_column1" align="left" class="issue_detail">
                        <label for="issue_description">Description:</label>
                    </th>
                    <th class="issue_column2" align="left">
                        <table>
                            <tr>
                                <th class="issue_detail_inner_column1">
                                    <label for="issue_sprint">Sprint:</label>
                                </th>
                                <td class="issue_sprint_column2">
                                    <select id="issue_sprint" name="issue_sprint" class="select_left">
                                        
                                    <?php echo "<option value=$issue_sprint>$issue_sprint</option>"?> 
                                    <?php $sql = "SELECT sprint.idSprint FROM ase.sprint";                                    
                                    $result = mysqli_query($connection, $sql);
                                    if (!$result) {
                                        echo "<option value='empty'>null</option>";
                                    } else {
                                        while ($row = mysqli_fetch_row($result)) {

                                            echo "<option value=$row[0]>$row[0]</option>";
                                        }
                                        mysqli_free_result($result);
                                    }
									?>                                             
                                    </select>
                                </td>
                            </tr>
                        </table>                        
                    </th>                   
                </tr>
                
                <tr align="top">
                    <td class="issue_column1">
                        <!-- <p class="description_para">
                            Add description of issue..
                        </p> -->
                        <textarea name="issue_description" class="description_para"><?php echo $issue_description; ?></textarea>
                    </td>
                    <td class="issue_column2" align="top">
                        <table>
                            <tr>
                                <th align="left">
                                    <label for="issue_description">Time Tracking</label>
                                </th>
                            </tr>
                            <tr>
                                <td >
                                    <label for="issue_original_estimate" >Original Estimate:</label>
                                </td>
                                <td align="left" class="issue_detail_inner_column2">
                                    <!-- <label for="issue_type">2d</label> -->
                                    <input type="text" id="issue_original_estimate" name="issue_original_estimate" class="estimate" value="<?php echo $issue_org_estimate; ?>">
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <label for="issue_actual_estimate">Actual Estimate:</label>
                                </td>
                                <td align="left" class="issue_detail_inner_column2">
                                    <!-- <label for="issue_type">3d</label> -->
                                    <input type="text" id="issue_actual_estimate" name="issue_actual_estimate" class="estimate" value="<?php echo $issue_actual_estimate; ?>"> 
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <th>
                        <label for="issue_description">Comments:</label>
                        <button type="button" class="issue_button_comment" disabled></button>                       
                    </th>                   
                </tr>
                
            </table>
            <textarea name="issue_comment" rows="10" class="comment_box"><?php echo $issue_comment; ?></textarea>           
        </div>
        </form>
    </body>    
    <script src="js/issue.js"></script> 
    
    <?php

        if (isset($_POST['submit'])) {
    
            $issue_id = $selected_id;
            $title = "Hello";
            $type;
            $priority;
            $status;
            $resolution;
            $assignee;
            $reporter;
            $sprint;
            $description;
            $comments;
            $original_estimate;
            $actual_estimate;
    
            if (isset($_POST['issue_title'])) {
                $title = $_POST['issue_title'];
                //echo $issue_title;
            }
    
            if (isset($_POST['issue_type'])) {
                $type = $_POST['issue_type'];
                //echo $type;
            }
    
            if (isset($_POST['issue_priority'])) {
                $priority = $_POST['issue_priority'];
                //echo $priority;
            }
    
            if (isset($_POST['issue_status'])) {
                $status = $_POST['issue_status'];
                //echo $status;
            }
    
            if (isset($_POST['issue_resolution'])) {
                $resolution = $_POST['issue_resolution'];
                //echo $resolution;
            }
    
            if (isset($_POST['issue_assignee'])) {
                $assignee = $_POST['issue_assignee'];
                //echo $assignee;
            }
    
            if (isset($_POST['issue_reporter'])) {
                $reporter = $_POST['issue_reporter'];
                //echo $reporter;
            }
    
            if (isset($_POST['issue_sprint'])) {
                $sprint = $_POST['issue_sprint'];
                //echo $sprint;
            }
    
            if (isset($_POST['issue_original_estimate'])) {
                $original_estimate = $_POST['issue_original_estimate'];
                //echo $original_estimate;
            }
    
            if (isset($_POST['issue_actual_estimate'])) {
                $actual_estimate = $_POST['issue_actual_estimate'];
                //echo $actual_estimate;
            }
    
            if (isset($_POST['issue_comment'])) {
                $comments = $_POST['issue_comment'];
                //echo $comments;
            }
    
            if (isset($_POST['issue_description'])) {
                $description = $_POST['issue_description'];
                //echo $description;
            }
    
            /*********** Save to DB *************/
    
            $sql1 = "UPDATE ase.issue SET important='" . $priority . "',Comment='" . $comments . "',estimation='" . $original_estimate . "',Actual_estimate='" . $actual_estimate . "', title='" . $title . "',description='" . $description . "',type='" . $type . "',resolution='" . $resolution . "' WHERE idIssue='" . $issue_id . "'";
            $result1 = mysqli_query($connection, $sql1);
    
            $sql2 = "SELECT user.idUser FROM ase.user WHERE user.userName='" . $assignee . "'";
            $result2 = mysqli_query($connection, $sql2);
            $row2 = mysqli_fetch_row($result2);
            $assignee_id = $row2[0];
            //echo $assignee_id;
    
            $sql3 = "SELECT user.idUser FROM ase.user WHERE user.userName='" . $reporter . "'";
            $result3 = mysqli_query($connection, $sql3);
            $row3 = mysqli_fetch_row($result3);
            $reporter_id = $row3[0];
            //echo $reporter_id;
    
            $sql4 = "SELECT status.idStatus FROM ase.status WHERE status.Name='" . $status . "'";
            $result4 = mysqli_query($connection, $sql4);
            $row4 = mysqli_fetch_row($result4);
            $status_id = $row4[0];
            //echo $status_id;
    
            $sql5 = "UPDATE ase.issue SET sprint_id=$sprint, Status_idStatus='" . $status_id . "',User_idAssignee='" . $assignee_id . "',User_idReporter='" . $reporter_id . "' WHERE idIssue='" . $issue_id . "'";
            $result = mysqli_query($connection, $sql5);
    
            echo "<meta http-equiv='refresh' content='0'>";
        }
    ?>
   
</html>