<!DOCTYPE HTML>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <title>RecipeApp [Przepis]</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/przepis_bez_styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-md navbar-light bg-light">
        <a class="navbar-brand" href="index.php"><img src="img/favicon.png" alt="logo" width="65"></a>  
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="falsaria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto navbar-items">
            <li class="nav-item" data-toggle="collapse" data-target=".navbar-collapse.show">
              <a class="nav-link" href="index.php">Home</a>
            </li>
            <li class="nav-item" data-toggle="collapse" data-target=".navbar-collapse.show">
                <a class="nav-link" href="index.php#recipes-ref">Przepisy</a>
            </li>
            <li class="nav-item" data-toggle="collapse" data-target=".navbar-collapse.show">
              <a class="nav-link" href="rejestracja.php">Rejestracja</a>
            </li>
            <li class="nav-item" data-toggle="collapse" data-target=".navbar-collapse.show">
                <a class="nav-link" href="index.php#login-ref">Logowanie</a>
            </li>
          </ul>
        </div>
    </nav>
    <?php 
        try
        {
            require_once 'connection-config.php';

            if(isset($_POST['wyswietl_przepis'])) {
                $id = $_POST['id_przepisu'];

                $zapytanie = $database -> prepare("SELECT * FROM przepisy WHERE id like '$id'");
                $zapytanie -> execute();
                $wynik = $zapytanie -> fetch();
                $ile_rekordow = $zapytanie->rowCount();

                if($ile_rekordow > 0) {
                   ?>
                    <div class="container">
                        <article class="recipe-panel">
                            <section class="recipe-title col-12 col-md-6">
                                <h3><?php echo $wynik['nazwa']; ?></h3>
                                <h5><?php echo $wynik['kategoria']; ?></h5>
                            </section>
                            <section class="recipe-image col-12 col-md-6">
                                <img src="recipePhotos/<?php echo $wynik['id']; ?>.png" alt="<?php echo $wynik['nazwa']; ?>" class="img-fluid">
                            </section>
                            <section class="recipe-info">
                                <div>icon1</div>
                                <div>icon2</div>
                                <div>icon3</div>
                                <div>icon4</div>
                            </section>
                            <section class="recipe">
                                <?php echo $wynik['przepis']; ?>
                            </section>
                            <section class="recipe-components">
                                <?php echo $wynik['skladniki']; ?>
                            </section>
                        </article>
                    </div>
                   <?php
                }
                else
                {
                    header('Location: index.php?result=14');
                    exit();
                }
            }

        }
        catch(PDOException $error)
        {
           echo $error->getMessage();
        }
    ?> 
 
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>

