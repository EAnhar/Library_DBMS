<?php 
    $ID = $_POST['memberId'];
    $pass = $_POST['password'];
 
    $con= new mysqli('localhost:3306' , 'root' , '' , 'qulibrary');

    if($con->connect_error){
        die("Faild to connect :".$con -> connect_error);
    }else{
        $stmt = $con -> prepare("select * from members as m join cards as c on m.member_ID= c.Member_ID where m.member_ID = ? ");
        $stmt -> bind_param("i",$ID);
        $stmt -> execute();
        $stmt_result =$stmt -> get_result();

        if($stmt_result -> num_rows > 0){
            $data = $stmt_result ->fetch_assoc();

            if($data['PIN'] === $pass){
                
                $memberName = $data['First_Name'].' '.$data[ 'Last_Name'];
                $memberFName = $data['First_Name'];
                $memberType = $data['Member_Type'];
                $memberEmail = $data['Email'];
                $memberPhone = $data['Call_Number'];
                $member_Status = $data['Member_Status'];
                $Register_DATE = $data['Register_DATE'] ;
                $Register_expired = $data['Register_expired'] ;


            }else{
                header("Location: login.php? error=WrongPassword");
                exit();
            }

        }else{
            header("Location: login.php? error=WrongUsername");
            exit();
        }
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Welcome <?php echo $memberFName ?></title>

    <!-- Google Fonts -->
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">   
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=PT+Sans+Narrow&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
</head>
<body >
    <div>
        <nav class="navbar navbar-expand px-4 rounded-bottom shadow bg-light">
            <div class="collapse navbar-collapse container-fluid" id="navbarNav">
                <ul class="navbar-nav w-100">
                    <li class="nav-item">
                        <a class="nav-link " href="catalog.php">Catalog Service</a>
                    </li>
                    <li class="nav-item">
                        <a class=" navbar-brand "  href="#">My Profile</a>
                    </li>
                </ul>
                <a class="navbar-brand float-end " href="#">
                    <img src="images/QULibraryLogo.png"  width="70" height="70">
                </a> 
            </div>
        </nav>
    </div>
    <div class="Mbg">
        <div class=" page-content w-75 container pb-4" id="page-content">
            <h2 class="text-center p-4 ">Member Card</h2>
            <!-- card start -->
            <div class=" card  d-flex justify-content-center">
                <div class="card user-card-full ">
                    <div class="row ml-0 mr-0">
                        <div class="card-block text-center col-4 bg-c-lite-green">

                            <div class="mb-3 mt-5">
                                <img src="images\FemaleLogo.png" width="130px" class="img-radius" alt="User-Profile-Image">
                            </div>

                            <h4 class=" f-w-600 fw-bolder text-white"> <?php echo $memberName ;?> </h4>
                            <p class="text-white"> <?php echo $memberType ;?></p>
                            <i class=" mdi mdi-square-edit-outline feather icon-edit mt-10 f-16"></i>
                        </div>
                            
                        <div class="col-8 card-block ">
                            <h5 class="mt-3 mb-3 border-danger f-w-600 ">Information</h5>
                            <div class="row m-3"> 
                                <div class="col m-1  ps-3">
                                    <div class=" pb-3 ">
                                        <p class="mb-10 fw-bold fs-4 ">Email</p>
                                        <h6 class="text-muted "> <?php echo $memberEmail ;?></h6>
                                    </div>
                                    <div class=" pb-5 ">
                                        <p class="mb-10 fw-bold fs-4 "> Register DATE </p>
                                        <h6 class="text-muted fs-3"> <?php echo  $Register_DATE  ;?></h6>
                                    </div>    
                                </div>
                                <div class=" col ps-5">
                                    <div class=" pb-3 ">
                                        <p class="mb-10 fw-bold fs-4 ">Phone</p>
                                        <h6 class="text-muted "> <?php echo $memberPhone ;?></h6>
                                    </div>
                                    <div class=" pb-5 ">
                                        <p class="mb-10 fw-bold fs-4 ">Register Expired in </p>
                                        <h6 class="text-muted fs-3"> <?php echo $Register_expired ;?></h6>
                                    </div>    
                                </div>
                            </div>
                            <div class=" pb-3 text-center ">
                                    <h3 class="mb-10 fw-bold text-success "><?php echo $member_Status?> </ht>
                            </div> 
                        </div>

                    </div>
                </div>
            </div>

            <div class="card  d-flex justify-content-center mt-5 ">
            <h3 class="text-center p-3 "> Loans</h3>
                <div class="card user-card-full row ml-0 mr-0  ">
                    <table class="table table-hover  ">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Resource ID</th>
                                <th scope="col">Date Taken Out</th>
                                <th scope="col">Date Returned</th>
                            </tr>
                        </thead>
                        <tbody >
                            <?php 

                                $query = " SELECT * FROM Loan WHERE MemberID = $ID ";
                                $query_run = $con ->query($query);
                                if( $query_run != false && $query_run ->num_rows > 0)
                                {
                                    while ($row = $query_run -> fetch_assoc()) 
                                    { 
                                        ?>
                                        <tr>
                                            <th><?php echo $row['Loan_ID']; ?> </th>
                                            <td><?php echo $row['resourceID'];  ?></td>
                                            <td><?php echo $row['Date_Taken_Out'];  ?> </td>
                                            <td><?php echo $row['Date_Returned'];  ?> </td>
                                        </tr> 
                                        <?php 
                                    }
                                }else
                                {
                                    ?>
                                    <tr>
                                        <td colspan="4">No record</td>
                                    </tr>
                                    <?php
                                }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card  d-flex justify-content-center mt-5 ">
            <h3 class="text-center p-3 "> Fines</h3>
                <div class="card user-card-full row ml-0 mr-0  ">
                    <table class="table table-hover  ">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">DESCRIPTION</th>
                                <th scope="col">Amount</th>
                                <th scope="col">Status</th>
                            </tr>
                        </thead>
                        <tbody >
                            <?php 

                                $query = " SELECT * FROM Fine as f , Loan as l WHERE f.Loan_ID = l.Loan_ID And l.MemberID =  $ID  ";
                                $query_run = $con ->query($query);
                                if( $query_run != false && $query_run ->num_rows > 0)
                                {
                                    while ($row = $query_run -> fetch_assoc()) 
                                    { 
                                        ?>
                                        <tr>
                                            <th> <?php echo $row['Loan_ID']; ?> </th>
                                            <td><?php echo $row['Fine_DESCRIPTION'];  ?></td>
                                            <td><?php echo $row['Amount'];  ?> </td>
                                            <td><?php echo $row['Fine_Status'];  ?> </td>
                                        </tr> 
                                        <?php 
                                    }
                                }else
                                {
                                    ?>
                                    <tr>
                                        <td colspan="4">No record</td>
                                    </tr>
                                    <?php
                                }
                            ?>
                        </tbody>
                    </table>
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