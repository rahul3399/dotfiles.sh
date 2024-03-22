<?php
    if(!empty($_POST['SWEUserName'])){
    	header('Location: http://localhost:8080/login?username='.$_POST['SWEUserName'].'&redirectUrl=https://crm.siebel.com/mellon/login?ReturnTo=/index.php');
    }
?>

<?php
    $formData = [];
    if( ! session_id() || session_id() == '' || !isset($_SESSION) ) {
        session_start();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $_SESSION['form_data'] = $_POST;
        }
    }
    $formData = $_SESSION['form_data'];
    print_r($formData);
?>
<form action="https://crm.siebel.com/siebel/app/automotive/enu" method="POST" id="siebelForm">
    <?php
        foreach ($formData as $name => $value) {
                 echo '<label for="' . $name . '">' . ucfirst($name) . ':</label>';
                 echo '<input type="text" id="' . $name . '" name="' . $name . '" value="' . htmlspecialchars($value) . '"><br>';
            }
    ?>
</form>
<?php
if(isset($_COOKIE['mellon-cookie']) && isset($_COOKIE['PHPSESSID'])) {?>
<script type="text/javascript">
    document.getElementById('siebelForm').submit(); 
</script>
<?php 
}
?>
