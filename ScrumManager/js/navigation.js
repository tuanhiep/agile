
    var dropDown = document.getElementById("caret");
       dropDown.addEventListener("click", function () {
       document.getElementById("user-dropdown").style.display = "block";
                });

    var userDrop = document.getElementById("user-dropdown");
        userDrop.addEventListener("mouseleave", function() {
            userDrop.style.display = "none";
        })

    var modal = document.getElementById('id01');
    var modal2 = document.getElementById('id02');
 
 

    //Clicking on the create tab functionality 
    document.getElementById("createProject").addEventListener("click", function () {
       document.getElementById('id02').style.display='block';
                });

//When click on new issue button - pop up form
document.getElementById("createIssue").addEventListener("click", function () {
       document.getElementById('id01').style.display='block';
                });

// When the user clicks anywhere outside of the box, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    
    window.onclick = function(event) {
        if (event.target == modal2) {
            modal.style.display = "none";
        }
    }
    
//    window.onclick = function(event) {
//        if (event.target == drop) {
//            user-dropdown.style.display = "none";
//        }
//    }