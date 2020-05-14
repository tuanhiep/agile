<html>
    <head>
            <link rel="stylesheet" type="text/css" href="../css/navigation.css" />
            <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">
         
    </head>
    
    <?php
        include ('connect.php');
    ?>
    
    <body>

        <div class="nav">
            <ul>
                <li><a href="homepage.php">Home</a></li>
                <!-- <li><a href="homepage.php">Boards</a></li>  -->
                <li><a href="backlog.php">Backlog</a></li>
                <li><a><div class="dropdown"><button class="dropbtn">Create</button>
                        <div class="dropdown-content">
                           <a id="createProject" href="#">New Project</a>
                             <a id="createIssue" href="#">New Issue</a>
                        </div>
                        </div></a></li>
            </ul>
            <div class="user-dropdown" id="user-dropdown">
	    		<a>Settings</a>
	    		<a>Account</a>
	    		<a>Logout</a>
	</div>
            <div class = "user-icon">
                    <i class="fas fa-user-circle fa-2x"></i>
                    <a id="caret"><i class="fas fa-caret-down"></i></a>
                </div>
        </div>   
      
<div id="id01" class="modal">
  <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
  <form class="modal-content" action="" method = "post">
    <div class="container">
      <h1>Create an Issue</h1>

      <hr>
      <label for="issueTitle"><b>Issue Title</b></label>
      <input type="text" class="input_text" placeholder="Enter title" name="issueTitle" required>

      <label for="projectID"><b>Project</b></label>
      <input type="text" class="input_text" placeholder="Enter project ID" name="projectID" required>

      <label for="userAssign"><b>User Assignee</b></label>
      <input type="text" class="input_text" placeholder="Enter assignee" name="userAssign" required>
        
        <label for="comment"><b>Comment</b></label>
      <input type="text" class="input_text" placeholder="Enter title" name="comment" required>
      

      <div class="clearfix">
        <button class="button" id="cancel-button" type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
        <button class="button" type="" class="createbtn" id="create-button" name="create_issue_btn">Create</button>
      </div>       
    </div>
  </form>
</div>
        
        
<div id="id02" class="modal">
  <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>
  <form class="modal-content" action="" method = "post">
    <div class="container">
      <h1>Create a Project</h1>

      <hr>
      <label for="title"><b>Project Title</b></label>
      <input type="text" class="input_text" placeholder="Enter project name" name="title" required>

      <label for="startDate"><b>Start Date </b></label>
      <input type="text" class="input_text" placeholder="Enter project start date" name="startDate" required>

      <label for="enddate"><b>End Date</b></label>
      <input type="text" class="input_text" placeholder="Enter project end date" name="endDate" required>
        
      <div class="clearfix">
        <button class="button" type="button"  id="cancel-button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">Cancel</button>
        <button class="button" type="" id="create-button" class="createbtn" name="create_project_btn">Create</button>
      </div>   
     </div>
  </form>
</div>
    </body>
        <script src="../js/navigation.js"></script>
        
        <?php
        include ('connect.php');
    
        if (isset($_POST['create_issue_btn'])) {
            $issue_title = mysqli_real_escape_string($connection, $_REQUEST['issueTitle']);
            //$project_id = mysqli_real_escape_string($connection, $_REQUEST['projectID']);
            //$user_assignee = mysqli_real_escape_string($connection, $_REQUEST['userAssign']);
            $issue_comment = mysqli_real_escape_string($connection, $_REQUEST['comment']);
        
            // $issue_title="test_create issue";
            // $issue_comment="Testing create issue";
            $user_assignee = 1;
            $user_reporter = 2;
            $user_story = 1;
            $issue_status = 1;
        
            $sql = "INSERT INTO ase.issue(title, User_idAssignee, comment, Status_idStatus, UserStory_idUserStory, User_idReporter) VALUES('" . $issue_title . "', $user_assignee, '" . $issue_comment . "', $issue_status,$user_story,$user_reporter)";
            if (mysqli_query($connection, $sql)) {
                //echo "Info was added to database";
            } else {
                //echo "ERROR: Could not able to execute ";
            }
                           
        }
        
        if (isset($_POST['create_project_btn'])) {
            
            $project_title = mysqli_real_escape_string($connection, $_REQUEST['title']);
            //$Proj_start_date = mysqli_real_escape_string($connection, $_REQUEST['startDate']);
            //$Proj_end_date = mysqli_real_escape_string($connection, $_REQUEST['endDate']);
            //$project_comment = mysqli_real_escape_string($connection, $_REQUEST['comment']);
            
            //$project_title = "Test project 3";
            $Proj_start_date = date('Y-m-d H:i:s');
            $Proj_end_date = date('Y-m-d H:i:s');
            
            $sql = "INSERT INTO ase.project(projectName, startDate, endDate) VALUES('" . $project_title . "','" . $Proj_start_date . "', '" . $Proj_end_date . "')";
            //echo $sql;
            if (mysqli_query($connection, $sql)) {
                //echo "Info was added to database";
            } else {
                //echo "ERROR: Could not able to execute ";
            }
        }        
    ?>
</html>


