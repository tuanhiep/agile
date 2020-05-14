<!-- <!DOCTYPE html> -->

<html lang="en">
	<head>

		<meta charset="utf-8">

		<title>main</title>

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/homepage.css" />
		<link href="https://use.fontawesome.com/releases/v5.0.4/css/all.css" rel="stylesheet">

	</head>

	<body>

        <?php
        include ('navigation.php');
        include ('connect.php');
    	?>

		<!--
		<div class="user-dropdown" id="user-dropdown">
		<a>Settings</a>
		<a>Account</a>
		<a>Logout</a>
		</div>
		-->

		<div class = "welcome-message">
			<h1>Home Page</h1>
		</div>

		<div>
			<header>
				<!-- <h1 class="title">Scrum Manager</h1> -->
			</header>
		</div>

		<div class="tables">
			<div class = "table-container1">
				<div id="table-wrapper">
					<div id="table-scroll">
					    <form action="" method="post">
						<table>
							<thead align = "left">
								<tr class="tableHead" style="height: 0;">
									<th><span class="text">My Open Issues </span></th>
								</tr>
							</thead>
							<tbody>
								
								<?php $sql = "SELECT issue.idIssue,issue.title FROM ase.issue,ase.user where user.idUser = 1";
                                
                                // session_start();
			                    // $value = "test";
								// $_SESSION["mytest"] = $value;
                                $result = $connection -> query($sql);
                                if ($result -> num_rows > 0) {                                   
                                    while ($row = $result -> fetch_assoc()) { 
                                ?>
                                <tr>
                                    <td class="issue"><a href="issue.php?a=<?php echo $row['idIssue']?>"><?php echo $row['idIssue']?></a></td>
                                    <td class="issue"><?php echo $row['title']?></td>
                                </tr>
                                <?php }
                                } else {
                                echo "0 results";
                                }
                                ?>    
                                              
							</tbody>
						</table>
						</form>
					</div>
				</div>
			</div>

			<div class = "table-container2">
				<div id ="table-wrapper2">
					<div id="table-scroll2">
						<table>
							<thead align = "left">
								<tr class="tableHead2" style="height: 0;">
									<th><span class="text">My projects </span></th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>

					</div>
				</div>
			</div>
		</div>

	</body>
	<script src="../js/homepage.js"></script>
	
	<?php
       session_start();
       if(isset($_GET['a'])){        
        $_SESSION['varname']=$_GET['a'];     
       }
    ?>
</html>
