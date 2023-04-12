<!DOCTYPE html>
<html>
<head>
    <title>BUYSELL</title>
</head>
<body>
<h1>BUYSELL</h1>
<hr>
<h4>Панель администратора</h4>
<table border="1">
    <tr>
        <th>Email</th>
        <th>Номер телефона</th>
        <th>Активность</th>
        <th>Роли</th>
        <th>Бан</th>
        <th>Редактирование</th>
        <th>Подробная информация</th>
    </tr>
    <#list users as user>
        <tr>
            <th>${user.email}</th>
            <th>${user.phoneNumber}</th>
            <th><#if user.active>true<#else>false</#if></th>
            <th><#list user.roles as role>${role}</#list></th>
            <th>
                <form action="/admin/user/ban/${user.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Бан">
                </form>
            </th>
            <th><a href="/admin/user/edit/${user.id}">Редактировние</a></th>
            <th><a href="/user/${user.id}">Подробная информация</a></th>
        </tr>
    <#else>
        <h3>Пользователей нет</h3>
    </#list>
</table>

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
<#--        Размеры через запятую<input type="text" name="dimensions"/><br><br>-->

        <div id="dimensions-container">
            <div class="dimension-row">
                <label for="dimension">Размер</label>
                <input type="text" id="dimension" name="dimension">
                <label for="quantity">Количество</label>
                <input type="number" id="quantity" name="quantity">
            </div>
        </div>
        <button type="button" onclick="addDimensionRow()">Добавить размер</button>

        <input type="hidden" name="_csrf" value="${_csrf.token}">


        <input type="submit" value="Добавить товар"/>
    </form>


<form action="/product/category/create" method="post" enctype="multipart/form-data">
    Название категории: <input type="text" name="name"/><br><br>
    фотография: <input type="file" name="file1"/><br><br>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Добавить категорию"/>
</form>
<script>
    function addDimensionRow() {
        const container = document.getElementById('dimensions-container');
        const newRow = document.createElement('div');
        newRow.className = 'dimension-row';
        newRow.innerHTML = `
        <label for="dimension">Размер</label>
        <input type="text" name="dimension">
        <label for="quantity">Количество</label>
        <input type="number" name="quantity">
        <button type="button" onclick="removeDimensionRow(this)">Удалить размер</button>
    `;
        container.appendChild(newRow);
    }

    function removeDimensionRow(button) {
        button.parentNode.remove();
    }
</script>
</body>
</html>