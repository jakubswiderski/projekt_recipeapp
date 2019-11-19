<?php 
    session_start();

    if(!isset($_SESSION['czy_zalogowany'])) {
        header('Location: index.php');
        exit();
    }
?>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>RecipeApp</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>

    <?php 
        echo 'Witaj: '.$_SESSION['nick'].' na stronie!';
        echo 'Twój email to: '.$_SESSION['email'].' zgadza się?<br>';
        echo '<a href="wylogowywanie.php">Wyloguj się</a>'
    ?>

    <script src="js/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>