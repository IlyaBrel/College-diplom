<!DOCTYPE html>
<html>
<head>
    <title>BUYSELL</title>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../static/css/style.css">

</head>
<body>
<article class="container_reg">
    <div class="block">
        <form class="form_info">
            <p>
            <h2 class="info_main">Shop</h2>
            </p>
            <p>
            <h3 class="info_premain">Shop - магазин какой-то хуйни, я хуй его знает, что ещё здесь написать, пока не
                придумал</h3>
            </p>

            <img src="../static/css/nikeImg.png" height="60px"/><br><br>
        </form>
        <form action="/registration" method="post" class="form_reg">
            <h3 class="form__title">Регистрация</h3>
            <p>
                <input type="text" name="name" class="form__name">
            </p>
            <p>
                <input type="email" name="email" class="form__input" placeholder="Логин">
            </p>
            <p>
                <input type="text" name="phoneNumber" class="form__phoneNumber"
                       placeholder="Номер телефона в формате +375">
            </p>

            <p>
                <input type="password" name="password" class="form__input" placeholder="Пароль">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
            </p>
            <p>
                <button type="submit" class="form__btn">Зарегистрироваться</button>
                <#if errorMessage??>
            <h2 style="color: #003a9d">${errorMessage}</h2>
            </#if>
            </p>
            <p>
            <h4>Есть аккаунт?</h4>
            </p>
            <p>
                <a class="form__reg" href="/login">Войти</a>
            </p>
        </form>
        <#--<h4></h4>-->
        <#--<form action="/registration" method="post">-->
        <#--    Имя пользователя: <input type="text" name="name"><br><br>-->
        <#--    Эл. почта: <input type="email" name="email"><br><br>-->
        <#--    Номер телефона: <input type="text" name="phoneNumber"><br><br>-->
        <#--    Пароль: <input type="password" name="password"><br><br>-->
        <#--    <input type="hidden" name="_csrf" value="${_csrf.token}">-->
        <#--    <input type="submit" value="Зарегистрироваться"/>-->
        <#--</form>-->
    </div>
</article>
</body>
</html>