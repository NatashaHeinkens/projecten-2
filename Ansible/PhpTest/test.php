[B]<font color='"Red"'>TEST</font>[/B]
<?php error_reporting(-1); ?>
<?php ini_set('display_errors', true); ?>
<?php
$servname = "localhost";
$dabaname = "naamTest";
$username = "userTest";
$password = "passTest";


echo "Testbestand om werking http, php en db te controleren";
try {
    $conn = new PDO("mysql:host=$servname;dbname=$dabaname", $username, $password);
    //Errors in exceptions veranderen
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO_ERRMODE_EXCEPTION);
    echo "Connected successfully  <br>";
    
    //Testtabel maken
    $sql = "CREATE TABLE Test (iets VARCHAR(10))"
    $conn->exec($sql);
    echo "Table created successfully <br>";
    //Data in testtabel steken
    $sql = "INSERT INTO Test VALUES ('TEST')";
    $conn->exec($sql);

    //Data uitlezen
    $sql = "SELECT * FROM Test";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        echo "Data gevonden, Alles okay!";
        }
    }
catch(PDOException $e) {
    echo "dbFOUT:<br>" . $e->getMessage();
    }
catch(Exception $ e) {
    echo "miscFOUT:<br>" . e->getMessage();
    }
finally {
    echo "einde bereikt"
    //Connectie sluiten
    $conn=null;
    }
echo "buiten try/catch/finally blok";
?>
