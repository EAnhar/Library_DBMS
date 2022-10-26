<?php 
  $con=  mysqli_connect('localhost:3306' , 'root' , '' , 'qulibrary');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalog Service</title>
    
    <!-- Google Fonts -->
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">   
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IM+Fell+English&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=PT+Sans+Narrow&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">

</head>
<body class="main">

    <nav class="navbar navbar-expand px-4 rounded-bottom shadow bg-light">
        <div class="collapse  navbar-collapse container-fluid" id="navbarNav">
            <ul class="navbar-nav w-100">
                <li class="nav-item">
                    <a class="navbar-brand " href="catalog.php">Catalog Service</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link link-success "  href="login.php">Login</a>
                </li>
            </ul>
                <a class="navbar-brand float-end " href="Home.php">
                    <img src="images/QULibraryLogo.png"  width="70" height="70">
                </a> 
        </div>
    </nav>

    <!-- main catalog card -->
    <div class="container mt-5  p-3 w-75 bg-light mb-5 rounded-2">
        <h1 class="text-center p-3">Catalog Service</h1>

        <!-- Search bar-->
            <form method="get" class="align-self-center">
                <div class="input-group m-4 pe-5 ">
                    <input type="text" name="search"  value=" "default class="form-control " placeholder="Keyword, Title, Auther, room...etc">
                    <button type="submit" class="input-group-text shadow-none  "> 
                    <img src="https://img.icons8.com/search" height="20px">
                        Search
                    </button>
                </div>
            </form>
        <!-- Tabs -->
            <ul class="nav nav-tabs " id="myTab" role="tablist">

                <!-- book -->
                <li class="nav-item" role="presentation">
                    <button class="nav-link greentext active" id="Book-tab" data-bs-toggle="tab" data-bs-target="#Book" type="button" role="tab" aria-controls="Book" aria-selected="true">Book</button>
                </li>
                <!-- Thesis -->
                <li class="nav-item" role="presentation">
                    <button class="nav-link greentext" id="Thesis-tab" data-bs-toggle="tab" data-bs-target="#Thesis" type="button" role="tab" aria-controls="Thesis" aria-selected="false">Thesis</button>
                </li>
                <!-- Journal -->
                <li class="nav-item" role="presentation">
                    <button class="nav-link greentext" id="Journal-tab" data-bs-toggle="tab" data-bs-target="#Journal" type="button" role="tab" aria-controls="Journal" aria-selected="false">Journal</button>
                </li>
                <!-- Record -->
                <li class="nav-item" role="presentation">
                    <button class="nav-link greentext" id="Record-tab" data-bs-toggle="tab" data-bs-target="#Record" type="button" role="tab" aria-controls="Record" aria-selected="false">Record</button>
                </li>
                <!-- Author -->
                <li class="nav-item" role="presentation">
                    <button class="nav-link greentext" id="Author-tab" data-bs-toggle="tab" data-bs-target="#Author" type="button" role="tab" aria-controls="Author" aria-selected="false">Author</button>
                </li>
                <!-- Room -->
                <li class="nav-item" role="presentation">
                    <button class=" greentext nav-link" id="Room-tab" data-bs-toggle="tab" data-bs-target="#Room" type="button" role="tab" aria-controls="Room" aria-selected="false">Room</button>
                </li>

            </ul>
        <!-- Tables -->
        <div class="tab-content" id="myTabContent">
            <!-- ################################Book################################## -->

                <div class="tab-pane fade show active" id="Book" role="tabpanel" aria-labelledby="Book-tab">         
                    <table class="table table-hover  ">
                        <thead>
                            <tr>
                                <th scope="col">ISBN</th>
                                <th scope="col">Title</th>
                                <th scope="col">Edition</th>
                                <th scope="col">Subject</th>
                                <th scope="col">Book type</th>
                                <th scope="col">Language</th>
                            </tr>
                        </thead>
                        <tbody >
                            <?php 
                                if(isset($_GET['search'])){
                                    $filtervalues = $_GET['search'];
                                }else{
                                    $filtervalues='';
                                }

                                $query = " SELECT * FROM Book WHERE  CONCAT(ISBN,B_Name,B_Edition,B_Subject,Book_Type,B_Language) LIKE '%$filtervalues%'  ";
                                $query_run = $con ->query($query);
                                if( $query_run != false && $query_run ->num_rows > 0)
                                {
                                    while ($row = $query_run -> fetch_assoc()) 
                                    { 
                                        ?>
                                        <tr>
                                            <th> <?php echo $row['ISBN']; ?> </th>
                                            <td><?php echo $row['B_Name'];  ?></td>
                                            <td><?php echo $row['B_Edition'];  ?> </td>
                                            <td><?php echo $row['B_Subject'];  ?> </td>
                                            <td><?php echo $row['Book_Type'];  ?> </td>
                                            <td><?php echo $row['B_Language'];  ?> </td>
                                        </tr> 
                                        <?php 
                                    }
                                }else
                                {
                                    ?>
                                    <tr>
                                        <td colspan="6">No record</td>
                                    </tr>
                                    <?php
                                }
                            ?>
                        </tbody>
                    </table>
                </div>

            <!-- ################################Room################################## -->


                <div class="tab-pane fade" id="Room" role="tabpanel" aria-labelledby="Room-tab">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Room Type</th>
                                <th scope="col">Location</th>
                                <th scope="col">Maximum Duration</th>
                            </tr>
                        </thead>
                        <tbody >
                            <?php 
                                if(isset($_GET['search'])){
                                    $filtervalues = $_GET['search'];
                                }else{
                                    $filtervalues='';
                                }
                                $query = " SELECT * FROM Room WHERE  CONCAT(Room_number,Room_Type,R_Location,MaxDuration) LIKE '%$filtervalues%'  ";
                                $query_run = $con ->query($query);
                                if( $query_run != false && $query_run ->num_rows > 0)
                                    {
                                        while ($row = $query_run -> fetch_assoc()) 
                                        { 
                                            ?>
                                            <tr>
                                                <th scope="row"> <?php echo $row['Room_number']; ?> </th>
                                                <td><?php echo $row['Room_Type'];  ?></td>
                                                <td><?php echo $row['R_Location'];  ?> </td>
                                                <td><?php echo $row['MaxDuration'];  ?> </td>
                                            </tr> 
                                            <?php 
                                        }
                                    }
                                    else
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

            <!-- ################################Author################################## -->

                <div class="tab-pane fade" id="Author" role="tabpanel" aria-labelledby="Author-tab">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">Author ID</th>
                                <th scope="col">Author Name</th>
                                <th scope="col">Call Number</th>
                                <th scope="col">Year Of Birth</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                                if(isset($_GET['search'])){
                                    $filtervalues = $_GET['search'];
                                }else{
                                    $filtervalues='';
                                }
                                $query = " SELECT * FROM Author WHERE CONCAT(AuthorID, Author_Name , Call_Number ,Year_Of_Birth ) LIKE '%$filtervalues%'  ";
                                $query_run = $con ->query($query);
                                if( $query_run != false && $query_run ->num_rows > 0)
                                    {
                                        while ($row = $query_run -> fetch_assoc()) 
                                        { 
                                            ?>
                                            <tr>
                                                <th scope="row"> <?php echo $row['AuthorID']; ?> </th>
                                                <td><?php echo $row['Author_Name'];  ?></td>
                                                <td><?php echo $row['Call_Number'];  ?> </td>
                                                <td><?php echo $row['Year_Of_Birth'];  ?> </td>
                                            </tr> 
                                            <?php 
                                        }
                                    }
                                else
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
            <!--################################Thesis################################## -->

                <div class="tab-pane fade" id="Thesis" role="tabpanel" aria-labelledby="Thesis-tab">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Title</th>
                                <th scope="col">Description</th>
                                <th scope="col">Location</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                                if(isset($_GET['search'])){
                                    $filtervalues = $_GET['search'];
                                }else{
                                    $filtervalues='';
                                }
                                $query = " SELECT * FROM Thesis WHERE CONCAT (T_ID,T_Title,T_DESCRIPTION,T_Location)LIKE '%$filtervalues%'  ";
                                $query_run = $con ->query($query);
                                if( $query_run != false && $query_run ->num_rows > 0)
                                    {
                                        while ($row = $query_run -> fetch_assoc()) 
                                        { 
                                            ?>
                                            <tr>
                                                <th scope="row"> <?php echo $row['T_ID']; ?> </th>
                                                <td><?php echo $row['T_Title'];  ?></td>
                                                <td><?php echo $row['T_DESCRIPTION'];  ?> </td>
                                                <td><?php echo $row['T_Location'];  ?> </td>
                                            </tr> 
                                            <?php 
                                        }
                                    }
                                else
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
            <!--################################Journal################################## -->

                <div class="tab-pane fade" id="Journal" role="tabpanel" aria-labelledby="Journal-tab">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">Journal ID</th>
                                <th scope="col">Title</th>
                                <th scope="col">Journal type</th>
                                <th scope="col">Release Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                                if(isset($_GET['search'])){
                                    $filtervalues = $_GET['search'];
                                }else{
                                    $filtervalues='';
                                }
                                $query = " SELECT * FROM Journal WHERE CONCAT(J_ID , J_Title , Journal_type , Release_Date )LIKE '%$filtervalues%'  ";
                                $query_run = $con ->query($query);
                                if( $query_run != false && $query_run ->num_rows > 0)
                                    {
                                        while ($row = $query_run -> fetch_assoc()) 
                                        { 
                                            ?>
                                            <tr>
                                                <th scope="row"> <?php echo $row['J_ID']; ?> </th>
                                                <td><?php echo $row['J_Title'];  ?></td>
                                                <td><?php echo $row['Journal_type'];  ?> </td>
                                                <td><?php echo $row['Release_Date'];  ?> </td>
                                            </tr> 
                                            <?php 
                                        }
                                    }
                                else
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
            <!-- ################################Record################################## -->

                <div class="tab-pane fade" id="Record" role="tabpanel" aria-labelledby="Record-tab">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Title</th>
                                <th scope="col">Type</th>
                                <th scope="col">DESCRIPTION</th>
                                <th scope="col">Location</th>
                                <th scope="col">Publisher</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                                if(isset($_GET['search'])){
                                    $filtervalues = $_GET['search'];
                                }else{
                                    $filtervalues='';
                                }
                                $query = " SELECT * FROM Video_Sound_Record WHERE CONCAT (Record_ID,Record_Title,Record_Type,R_DESCRIPTION,R_Location,Publisher)LIKE '%$filtervalues%'  ";
                                $query_run = $con ->query($query);
                                if( $query_run != false && $query_run ->num_rows > 0)
                                    {
                                        while ($row = $query_run -> fetch_assoc()) 
                                        { 
                                            ?>
                                            <tr>
                                                <th scope="row"> <?php echo $row['Record_ID']; ?> </th>
                                                <td><?php echo $row['Record_Title'];  ?></td>
                                                <td><?php echo $row['Record_Type'];  ?> </td>
                                                <td><?php echo $row['R_DESCRIPTION'];  ?> </td>
                                                <td><?php echo $row['R_Location'];  ?> </td>
                                                <td><?php echo $row['Publisher'];  ?> </td>
                                            </tr> 
                                            <?php 
                                        }
                                    }
                                else
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>

    <script src="js/bootstrap.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>