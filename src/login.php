
<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>Login to Qu Library</title>
    <link rel="stylesheet" href="css/bootstrap.css">

    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">     
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=PT+Sans+Narrow&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
    <body class="bgimg">
    <!-- NavBar -->
        <nav class="navbar navbar-expand px-4 rounded-bottom shadow bg-light">
            <ul class="navbar-nav w-100">          
                <li class="nav-item">
                    <a class="navbar-brand " href="catalog.php">Catalog Service</a>
                </li>
            </ul>
            <div class="justify-content-end collapse navbar-collapse container-fluid w-100" id="navbarNav">
                <a class="navbar-brand float-end " href="#">
                    <img src="images/QULibraryLogo.png"  width="70" height="70">
                </a> 
            </div>
        </nav>
    <!-- Login form -->
        <div class=" m-4">
            <div class="row justify-content-around ">

                <div class="col-md-5 p-3 text-center align-self-center" >
                    <h3 id="mainFont" class="">Welcome to <br> Qassim University Library</h3>
                </div>

                <div class="col-md-4 m-3">
                    <div class="card card-body m-3 ">


                        <form id="submitForm" action="profile.php" method="post" data-parsley-errors-messages-disabled="false" >
                        
                            <div class="form-group required">
                                <lSabel for="memberId">Member ID</lSabel>
                                <input required type="text" class="form-control"   name="memberId">
                            </div>   

                            <div class="form-group required">
                                <label class="d-flex flex-row align-items-center" for="password">Password 
                                    <a class="ml-auto border-link small-xl" href="">Forget?</a></label>
                                <input required type="password" class="form-control"  name="password" >
                            </div>

                            
                            <?php
                                if(isset($_GET['error']))
                                {
                                    if($_GET['error'] == 'WrongPassword')
                                    ?>
                                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                                        <svg class="bi flex-shrink-0 me-2" width="20" height="24" role="img" aria-label="Danger:">
                                            <use xlink:href="#exclamation-triangle-fill"/></svg>
                                        <div>
                                            Incorrect Password
                                        </div>
                                    </div>
                                    <?php
                                }
                                else if(isset($_GET['error']))
                                {
                                    if($_GET['error'] == 'WrongUsername')
                                    ?>
                                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                                        <svg class="bi flex-shrink-0 me-2" width="24" height="20" role="img" aria-label="Danger:">
                                            <use xlink:href="#exclamation-triangle-fill"/></svg>
                                        <div>
                                                Incorrect Username
                                        </div>
                                    </div>

                                    <?php
                                }
                            ?>
                            <div class="form-group mt-4 mb-1">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="remember-me" name="remember-me" data-parsley-multiple="remember-me">
                                    <label class="custom-control-label" for="remember-me">Remember me?</label>
                                </div>
                            </div>

                            <div class="form-group pt-1">
                                <button class="btn btn-block" type="submit">Log In</button>
                            </div>
                        </form>

                        <p class="small-xl pt-3 text-center">
                            <span class="text-muted">Not a member?</span>
                            <a href="">Sign up</a>
                        </p>

                    </div>
                </div>
            </div>
        </div>
        <div class="footer-basic">
            <footer>
                <div class="social"><a href="#"><i class="icon ion-social-instagram"></i></a><a href="#"><i class="icon ion-social-snapchat"></i></a><a href="#"><i class="icon ion-social-twitter"></i></a><a href="#"><i class="icon ion-social-facebook"></i></a></div>
                <ul class="list-inline">
                    <li class="list-inline-item"><a href="#">Home</a></li>
                    <li class="list-inline-item"><a href="#">Services</a></li>
                    <li class="list-inline-item"><a href="#">About</a></li>
                    <li class="list-inline-item"><a href="#">Terms</a></li>
                    <li class="list-inline-item"><a href="#">Privacy Policy</a></li>
                </ul>
                <p class="copyright">Qassim University Library © 2022</p>
            </footer>
        </div>
    </body>
</html>
