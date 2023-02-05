<!DOCTYPE html>
<html>
<head>
    <title>BELSEll</title>
</head>
<body>
<h1>BELSEll</h1>
<hr>
<#if user.email??>
    <h3>Имя пользователя: <i>${user.name}</i></h3>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Выйти"/>
    </form>
    <#if user.isAdmin()>
        <a href="/admin">Панель администратора</a>
    </#if>
<#else>
    <a href="/login">Войти</a></h1>
</#if>
<hr>
<h4>Товары со всей России</h4>
<form action="/" method="get">
    Поиск по названию объявления: <input type="text" name="title">
    <input type="submit" value="Поиск"/>
</form>
<#list products as product>
    <div>
        <p><b>${product.title}</b> ${product.price} руб. | <a href="/product/${product.id}">Подробнее...</a></p>
    </div>
<#else>
    <h3>Товаров нет</h3>
</#list>
<#if user.email??>
    <hr>
    <h3>Создать новый товар</h3>
    <form action="/product/create" method="post" enctype="multipart/form-data">
        Название объявления: <input type="text" name="title"/><br><br>
        Описание объявления: <input type="text" name="description"/><br><br>
        <#list category as category>
            <div>
                <label><input id="category" type="radio" name="category" value="${category.id}">${category.name}</label>
            </div>
        </#list>
        Популярый <input type="radio" name="popular"/><br><br>
        Цена: <input type="number" name="price" /><br><br>
        Город: <input type="text" name="city"/><br><br>
        Первая фотография: <input type="file" name="fileProduct1"/><br><br>
        Вторая фотография: <input type="file" name="fileProduct2"/><br><br>
        Третья фотография: <input type="file" name="fileProduct3"/><br><br>
        Размеры через запятую<input type="text" name="dimensions"/><br><br>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Добавить товар"/>
    </form>
</#if>


<form action="/product/category/create" method="post" enctype="multipart/form-data">
    Название категории: <input type="text" name="name"/><br><br>
    фотография: <input type="file" name="file1"/><br><br>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Добавить категорию"/>
</form>


<#--<form action="/product/sizes/create" method="post" enctype="multipart/form-data">-->
<#--    Введите размер: <input type="text" name="size"/><br><br>-->
<#--    <input type="hidden" name="_csrf" value="${_csrf.token}">-->
<#--    <input type="submit" value="Добавить размер"/>-->
<#--</form>-->
</body>
</html>