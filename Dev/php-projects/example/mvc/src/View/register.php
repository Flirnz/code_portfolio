<!DOCTYPE html>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrierung - Himmelshof</title>

    <!-- 
      JAWABAN QUERY LU: 
      Kenapa linknya gini?
      1. Kita pake "Absolute Path" (Mulai dari /).
      2. Artinya: "Server, tolong cari folder 'my-php-project', lalu 'example', dst..."
      3. Google Fonts? Itu kita dapet copas dari website Google Fonts pas milih font.
    -->
    <link rel="stylesheet" href="/my-php-project/example/mvc/static/css/main.css">
    <link rel="stylesheet" href="/my-php-project/example/mvc/static/css/register.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600&family=Satisfy&display=swap" rel="stylesheet">
</head>

<body>

    <header>
        <nav class="navbar">
            <div class="nav-container">
                <div class="left-section">
                    <a href="/my-php-project/example/mvc/home" class="logo">Himmelshof</a>
                </div>
                <div class="nav-buttons">
                    <a href="/my-php-project/example/mvc/contact" class="btn btn-contact">Kontakt</a>
                </div>
            </div>
        </nav>
    </header>

    <!-- TUGAS LU DI SINI:
     1. Bikin <form> yang ngarah ke Controller.
     2. Bikin Input (Username, Email, Password).
     3. Bikin Tombol Submit.
     4. TAMPILIN PESAN ERROR pake PHP ($_GET['error']).
-->
    <div class="center-wrapper">
        <div class="center-box">
            <!-- SILAKAN ISI DI SINI -->
            <form method='POST' action="my-php-project/example/mvc/register/save">
                <label>User Name </label><br>
                <input type='text' name='username' placeholder='User Name' required> <br>
                <label>Email</label><br>
                <input type='email' name='email' placeholder='Email' required> <br>
                <label>Password</label><br>
                <input type='password' name='password' placeholder='password' required><br>
                <label>ReEnter Password</label>
                <input type='password' name='password_confirm' placeholder='Confirm Password'>
                <input type='submit' name='register' value='Register'>

            </form>
        </div>
    </div>

</body>

</html>