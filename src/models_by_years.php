<div>
    <form action="table_view.php" method="GET">
        <p style="margin-left:3%" for="year">Modèles pris en charge au cours de l'année     
        <input type="hidden" name="fct" value="get_models_by_year">
        <select name="param[]" id="year_mod" style="margin-left:1%;">
            <?php
            for ($y = 2025; $y >= 2000; $y--) {
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

<!-- <script>
    function redirectToTableView() {
        var selectedYear = document.getElementById("year_mod").value;
        var url = "table_view.php?fct=get_models_by_year&param[]=" + encodeURIComponent(selectedYear) + "&param[]=567890123&submitable=false";
        window.location.href = url;
    }
</script>
 -->