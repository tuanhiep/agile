<!-- <!DOCTYPE html> -->
<html lang="en">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="../css/backlog.css" />
	</head>

	<?php
        include ('connect.php');
        include ('navigation.php');
	?>
	<body>
		<div class="containerDiv">
			<div class="leftDiv" align="center">
				<h1>Scrum Manager</h1>
				<h2>Backlog</h2>
				<h3>Issues</h3>	
			</div>
			<div class="rightDiv">
			             <div class = "table-container1">
                <div id="table-wrapper">
				<div id="table-scroll">
                        <table>
                            <thead align = "left">
                                <tr class="tableHead" style="height: 0;">
                                    <th><span class="text">Issues</span></th>
                                </tr>
                            </thead>
                            <tbody>

                                <?php $sql = "SELECT issue.idIssue,issue.title FROM ase.issue,ase.user where user.idUser = 1";
                                $result = $connection -> query($sql);
                                if ($result -> num_rows > 0) {                                   
                                    while ($row = $result -> fetch_assoc()) { 
                                ?>
                                <tr>
                                <td class="issue"><a href="issue.php?a=<?php echo $row['idIssue']?>"><?php echo $row['idIssue']?></a></td>
                                <td class="issue"><?php echo $row['title']?></td>
                                </tr>
                                <?php
                                }
                                } else {
                                echo "0 results";
                                }
                                ?>   
                                
                                <?php
                                   session_start();
                                   if(isset($_GET['a'])){        
                                    $_SESSION['varname']=$_GET['a'];     
                                   }
                                ?>                           
                            </tbody>

                        </table>
                    </div>
                    </div>
			     </div>
            </div>
		</div>

	</body>
</html>

