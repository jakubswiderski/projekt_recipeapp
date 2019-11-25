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
    <title>RecipeApp [Ustawienia konta]</title>
    <link rel="shortcut icon" href="img/favicon.png">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/ustawienia.css">
    
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
              <a class="nav-link" href="witryna_po_autoryzacji.php">Home</a>
            </li>
            <li class="nav-item" data-toggle="collapse" data-target=".navbar-collapse.show">
                <a class="nav-link" href="witryna_po_autoryzacji.php#recipes-ref">Przepisy</a>
            </li>
            <li class="nav-item" data-toggle="collapse" data-target=".navbar-collapse.show">
                <a class="nav-link" href="ustawienia.php">Konto</a>
            </li>
            <?php
            if($_SESSION['typ'] == "Moderator" || $_SESSION['typ'] == "Administrator")
            {
              echo '
              <li class="nav-item" data-toggle="collapse" data-target=".navbar-collapse.show">
                  <a class="nav-link" href="#"><span style="color: #D39486;">Panel administracyjny</span></a>
              </li>';
            }
            ?>
            <li class="nav-item" data-toggle="collapse" data-target=".navbar-collapse.show">
                <a class="nav-link" href="wylogowywanie.php"><button class="btn btn-outline-secondary btn-sm">Wyloguj się</button></a>
            </li>
          </ul>
        </div>
    </nav>

    <?php 
      require_once 'result.php';
    ?>

    <?php
      try
      {
        require_once 'connection-config.php';
        ?>
        <section class="content">
            
            <header class="info-panel">
                <div class="container">
                  <div class="row settings-info">
                    <div class="col-12 col-lg-6">
                      <h1>Panel konfiguracyjny</h1>
                      <p>Witaj w panelu konfiguracyjnym! Znajdziesz tu spis wszystkich swoich przepisów a także zmienisz podstawowe informacje o swoim koncie.</p>
                      <a href="dodawanie_przepisu.php"><button class="btn btn-primary">Dodaj nowy przepis</button></a>
                    </div>
                    <div class="col-12 col-lg-6 settings-photo">
                      <img src="img/konfiguracja.png" alt="user-image" class="img-fluid">
                    </div>
                  </div>
                </div>  
            </header>  

            <section class="recipes-panel">
                <h1>Twoje przepisy</h1>
                <p>Lista dodanych przez Ciebie przepisów</p>
                <section class="recipes">
                    <?php
                    $zapytanie = $database->query("SELECT * FROM przepisy");
                    echo '<ul>';
                    foreach($zapytanie as $wynik)
                    { 
                        echo '<div class="card recipe-card col-xl-3">
                                <img src="img/test.png" class="card-img-top" alt="zdjęcie jedzenia">
                                <div class="card-body">
                                  <h5 class="card-title">'.$wynik['nazwa'].'</h5>
                                  <p class="card-text">'.$wynik['kategoria'].'</p>
                                  <form action="przepis_z_autoryzacja.php" method="post">
                                    <input type="hidden" name="id_przepisu" value="'.$wynik['id'].'">
                                    <input type="submit" class="btn btn-primary" name="wyswietl_przepis" value="Sprawdź przepis">
                                  </form>
                                </div>
                              </div>';
                    }
                    //$zapytanie->closeCursor();
                    echo '</ul>';
                    ?>
                </section>
            </section>
        </section>
            
        <?php
      }
      catch(PDOException $e)
      {
        echo '
        <div class="alert alert-danger" role="alert">
          Wystąpił błąd! Przepraszamy za utrudnienia.
        </div>';
      }
    ?>

    <footer class="footer-panel">
      Wszelkie prawa zastrzeżone &copy RecipeApp 2019
    </footer>
    
    <script src="js/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>