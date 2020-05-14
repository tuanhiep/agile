 <!-- <!DOCTYPE html> -->
<html lang="en">
	<head>
		<meta charset="utf-8">

		<title>main</title>

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<!-- <script type="text/javascript" src="js/dboperations.js"></script> -->
		<link rel="stylesheet" type="text/css" href="css/loginpage.css" />
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">
		
		
	</head>
	
	<?php
        include ('connect.php');
    ?>
	
	<body>
		
		<div>
		<header>
			<!-- <h1 class="title">Scrum Manager</h1> -->
		</header>
	</div>
	
	  <div class="sidenav">
         <div class="login-main-text">
            <h2>Scrum Manager<br> Login Page</h2>
            <!--  <p>Welcome</p>-->
             <div class = "logo-icon">
                     <i class="fas fa-cubes fa-4x"></i>
                </div>

         </div>
          
      </div>
      <div class="main">
         <div class="col-md-6 col-sm-12">
            <div class="login-form">
               <form method="post" action="">
                  <div class="form-group">
                     <label>User Name</label>
                     <input type="text" class="form-control" id="username_form" name="username_form" placeholder="User Name">
                  </div>
                  <div class="form-group">
                     <label>Password</label>
                     <input type="password" class="form-control" id="password_form" name="password_form" placeholder="Password">
                  </div>
                  <button type="submit" class="btn btn-black" name="login_btn" id="login_btn">Login</button>
                  <button type="submit" class="btn btn-secondary">Register</button>
               </form>
            </div>
         </div>
      </div>
 	 
    <?php
            if (isset($_POST['login_btn'])) {
    
                $uname = mysqli_real_escape_string($connection, $_POST['username_form']);
                $password = mysqli_real_escape_string($connection, $_POST['password_form']);
    
                if ($uname != "" && $password != "") {        
                    $sql = "select user.userName,user.password from ase.user where user.userName='" . $uname . "' and user.password='" . $password . "'";
                    $result = mysqli_query($connection, $sql);
                    
                    if (!$result) {
                      
                    } else {
                                                                       
                        while ($row = mysqli_fetch_row($result)) {
                            //echo $row[0];
                            //echo $row[1];
                            $_SESSION['uname'] = $uname;
                            header('Location: php/homepage.php');    
                        }
                        
                        mysqli_free_result($result);
                    }
                }
            }
   ?>

	</body>
</html>