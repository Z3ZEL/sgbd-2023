# sgbd-2023
Projet Systeme de Gestion de Base de Donnée


## Installation

### Connect to the database

-> Create a file named 'auth.php' in the src folder
-> Add the following code to the file
```php
<?php
$host = 'servername';
$dbname = 'dbname';
$user = 'user';
$password = 'password';

try {
    $pdo = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
    // set the PDO error mode to exception
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected successfully";
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>
```
> With the correct values for the connection to the database

### Live server
-> Install Live server + Php server extension on visual studio code
-> Right Click : Php server : Serve project
