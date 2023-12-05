<div>
    <form action="table_view.php" method="GET">
        <p style="margin-left:3%" for="year">Modèles pris en charge au cours de l'année     
        <input type="hidden" name="fct" value="get_models_by_year">
        <select name="param[]" id="year_mod" style="margin-left:1%;">
            <?php
            for ($y = 2024; $y >= 2019; $y--) {
                echo '<option value="' . $y . '">' . $y . '</option>';
            }
            ?>
        </select>
        <input type="hidden" name="param[]" value="567890123">
        <input type="hidden" name="submitable" value="false">
        <input type="submit" value="Valider">
        </p>
    </form>
</div>