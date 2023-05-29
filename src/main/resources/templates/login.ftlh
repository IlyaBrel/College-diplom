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


<article class="container">
    <div class="block">
        <form class="form_info">
            <p>
            <h2 class="info_main">Shop</h2>
            </p>
            <p>
            <h3 class="info_premain">
            </h3>
            </p>

            <img src="../static/css/nikeImg.png" height="60px"/><br><br>

        </form>
        <form action="/login" method="post" class="form">
            <h3 class="form__title">Вход</h3>
            <#if errorMessageLogin??>
                ${errorMessageLogin}
            </#if>
            <#if message1??>
                ${message1}
            </#if>
            <p>
                <input type="email" name="username" class="form__input" placeholder="Логин">
            </p>
            <p>
                <input type="password" name="password" class="form__input" placeholder="Пароль">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
            </p>
            <p>
                <button type="submit" class="form__btn">Войти</button>
            </p>

            <p>
                <a class="form__reg" href="/registration">Зарегистрироваться</a>
            </p>
        </form>
    </div>
</article>


</body>
</html>