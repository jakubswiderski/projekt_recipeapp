<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>RecipeApp [Reset hasła]</title>
</head>
<body>
    <?php 
        try
        {
            session_start();

            require_once 'connection-config.php';
            require_once 'result.php';
            
            if(isset($_POST['zmien_haslo'])) {
                $email = $_POST['login'];
                $new_password = $_POST['password'];
                $re_password = $_POST['re_password'];

                $poprawna_walidacja = true;

                if ((strlen($new_password)<8) || (strlen($new_password)>20)) {
                    $poprawna_walidacja = false;
                    $_SESSION['password_error'] = "Długość hasła powinna wynosić od 8 do 20 znaków!";
                }

                if($new_password != $re_password) {
                    $poprawna_walidacja = false;
                    $_SESSION['password_error'] = "Podane hasła się różnią!";
                }

                if($poprawna_walidacja) 
                {
                    $zapytanie = $database -> exec("UPDATE uzytkownicy SET haslo='$new_password' WHERE email='$email'");
                    header('Location: index.php?result=11');
                }
            }

            if(isset($_GET['recovery'])) 
            {
              $recovery_key = $_GET['recovery'];
        
              $zapytanie = $database->prepare("SELECT * FROM uzytkownicy WHERE kod_przywracania like :key");
              $zapytanie -> bindValue('key', $recovery_key, PDO::PARAM_STR);
              $zapytanie -> execute();
              $wynik = $zapytanie -> fetch();
              $ile_rekordow = $zapytanie->rowCount();
        
              if($ile_rekordow > 0) { ?>
                <h3>Podaj nowe hasło do konta <?php echo $wynik['email']; ?></h3>
                <form method="post">
                  <input type="hidden" name="login" placeholder="Email" value="<?php echo $wynik['email']; ?>">
                  <input type="password" name="password" required>
                  <input type="password" name="re_password" required>
                  <input type="submit" value="Wyślij" name="zmien_haslo">
                </form> 
                <?php 
                    if(isset($_SESSION['password_error'])) { echo $_SESSION['password_error']; unset($_SESSION['password_error']); } 
              } else {
                  header('Location: index.php?result=12');
                  exit();
              }
            }
            if(isset($_SESSION['password_error'])) unset($_SESSION['password_error']);
        }
        catch(PDOException $error)
        {
           echo $error->getMessage();
        }
    ?> 
    
</body>
</html>

