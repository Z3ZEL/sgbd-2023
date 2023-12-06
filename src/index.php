<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Choix du garage</title>
    <link rel="stylesheet" href="css/index.css">
    
</head>

<body>
    <div id="choix">

        <script>
            if(sessionStorage.getItem("garage") != null){
                window.location.href = "indexbis.php";
            }

            function submitForm() {
                var selectedValue = document.getElementById("garage").value;
                console.log(selectedValue); 
                sessionStorage.setItem("garage", selectedValue);
                window.location.href = "indexbis.php";
            }
        </script>
        <h1>Choisissez votre garage :</h1>
        <form method="post" action="indexbis.php" >
            <select name="garage" id="garage" onchange="submitForm()">
                <?php
                include 'auth.php';

                $request = "SELECT * FROM garages";
                $stmt = $pdo->query($request);
                $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
                foreach ($data as $row) {
                    echo "<option value='$row[numero_siren]'> $row[denomination_garage] </option>";
                }
                ?>
            </select>
        </form>
        </div>

</body>

</html>